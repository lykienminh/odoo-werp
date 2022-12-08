# -*- coding: utf-8 -*-
# Part of Odoo. See LICENSE file for full copyright and licensing details.

from odoo import _, api, models


class Company(models.Model):
    _inherit = "res.company"
    _check_company_auto = True

    def _create_scrap_location(self):
        parent_location = self.env.ref('stock.stock_location_locations_virtual', raise_if_not_found=False)
        for company in self:
            scrap_location = self.env['stock.location'].create({
                'name': 'Scrap',
                'usage': 'inventory',
                'location_id': parent_location.id,
                'company_id': company.id,
                'scrap_location': True,
            })

    def _create_scrap_sequence(self):
        scrap_vals = []
        for company in self:
            scrap_vals.append({
                'name': '%s Sequence scrap' % company.name,
                'code': 'stock.scrap',
                'company_id': company.id,
                'prefix': 'SP/',
                'padding': 5,
                'number_next': 1,
                'number_increment': 1
            })
        if scrap_vals:
            self.env['ir.sequence'].create(scrap_vals)

    @api.model
    def create_missing_scrap_location(self):
        company_ids  = self.env['res.company'].search([])
        companies_having_scrap_loc = self.env['stock.location'].search([('scrap_location', '=', True)]).mapped('company_id')
        company_without_property = company_ids - companies_having_scrap_loc
        company_without_property._create_scrap_location()

    @api.model
    def create_missing_scrap_sequence(self):
        company_ids  = self.env['res.company'].search([])
        company_has_scrap_seq = self.env['ir.sequence'].search([('code', '=', 'stock.scrap')]).mapped('company_id')
        company_todo_sequence = company_ids - company_has_scrap_seq
        company_todo_sequence._create_scrap_sequence()

    def _create_per_company_locations(self):
        self.ensure_one()
        self._create_scrap_location()

    def _create_per_company_sequences(self):
        self.ensure_one()
        self._create_scrap_sequence()
