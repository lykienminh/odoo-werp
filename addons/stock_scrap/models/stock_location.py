# -*- coding: utf-8 -*-
# Part of Odoo. See LICENSE file for full copyright and licensing details.

import calendar

from collections import defaultdict, OrderedDict
from datetime import timedelta

from odoo import _, api, fields, models
from odoo.exceptions import UserError
from odoo.tools.misc import groupby
from odoo.osv import expression
from odoo.tools.float_utils import float_compare


class Location(models.Model):
    _inherit = "stock.location"
    _check_company_auto = True

    scrap_location = fields.Boolean('Is a Scrap Location?', default=False, help='Check this box to allow using this location to put scrapped/damaged goods.')
    
    @api.onchange('usage')
    def _onchange_usage(self):
        if self.usage not in ('internal', 'inventory'):
            self.scrap_location = False

    def write(self, values):
        if 'company_id' in values:
            for location in self:
                if location.company_id.id != values['company_id']:
                    raise UserError(_("Changing the company of this record is forbidden at this point, you should rather archive it and create a new one."))
        if 'usage' in values and values['usage'] == 'view':
            if self.mapped('quant_ids'):
                raise UserError(_("This location's usage cannot be changed to view as it contains products."))
        if 'usage' in values or 'scrap_location' in values:
            modified_locations = self.filtered(
                lambda l: any(l[f] != values[f] if f in values else False
                              for f in {'usage', 'scrap_location'}))
            reserved_quantities = self.env['stock.move.line'].search_count([
                ('location_id', 'in', modified_locations.ids),
                ('product_qty', '>', 0),
            ])
            if reserved_quantities:
                raise UserError(_(
                    "You cannot change the location type or its use as a scrap"
                    " location as there are products reserved in this location."
                    " Please unreserve the products first."
                ))
        if 'active' in values:
            if values['active'] == False:
                for location in self:
                    warehouses = self.env['stock.warehouse'].search([('active', '=', True), '|', ('lot_stock_id', '=', location.id), ('view_location_id', '=', location.id)])
                    if warehouses:
                        raise UserError(_("You cannot archive the location %s as it is"
                        " used by your warehouse %s") % (location.display_name, warehouses[0].display_name))

            if not self.env.context.get('do_not_check_quant'):
                children_location = self.env['stock.location'].with_context(active_test=False).search([('id', 'child_of', self.ids)])
                internal_children_locations = children_location.filtered(lambda l: l.usage == 'internal')
                children_quants = self.env['stock.quant'].search(['&', '|', ('quantity', '!=', 0), ('reserved_quantity', '!=', 0), ('location_id', 'in', internal_children_locations.ids)])
                if children_quants and values['active'] == False:
                    raise UserError(_('You still have some product in locations %s') %
                        (', '.join(children_quants.mapped('location_id.display_name'))))
                else:
                    super(Location, children_location - self).with_context(do_not_check_quant=True).write({
                        'active': values['active'],
                    })

        res = super(Location, self).write(values)
        self.invalidate_cache(['warehouse_id'])
        return res

    def should_bypass_reservation(self):
        self.ensure_one()
        return self.usage in ('supplier', 'customer', 'inventory', 'production') or self.scrap_location or (self.usage == 'transit' and not self.company_id)