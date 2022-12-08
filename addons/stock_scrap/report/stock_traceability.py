# -*- coding: utf-8 -*-
# Part of Odoo. See LICENSE file for full copyright and licensing details.

from odoo import api, models, _
from odoo.tools import config
from odoo.tools import format_datetime
from markupsafe import Markup



class MrpStockReport(models.TransientModel):
    _inherit = 'stock.traceability.report'

    @api.model
    def _get_reference(self, move_line):
        res_model = ''
        ref = ''
        res_id = False
        picking_id = move_line.picking_id or move_line.move_id.picking_id
        if picking_id:
            res_model = 'stock.picking'
            res_id = picking_id.id
            ref = picking_id.name
        elif move_line.move_id.is_inventory:
            res_model = 'stock.move'
            res_id = move_line.move_id.id
            ref = 'Inventory Adjustment'
        elif move_line.move_id.scrapped and move_line.move_id.scrap_ids:
            res_model = 'stock.scrap'
            res_id = move_line.move_id.scrap_ids[0].id
            ref = move_line.move_id.scrap_ids[0].name
        return res_model, res_id, ref