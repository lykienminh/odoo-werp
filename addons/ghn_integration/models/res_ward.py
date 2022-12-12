from odoo import api, fields, models, _
import requests
import json

class ResWard(models.Model):
    _name = 'res.ward'
    _description = 'Ward'
    _order = 'state_id'

    name = fields.Char("Name", required=True, translate=True)
    country_id = fields.Many2one('res.country', string='Country', required=True)
    state_id = fields.Many2one('res.country.state', 'State', domain="[('country_id', '=', country_id)]")
    district_id = fields.Many2one('res.district', 'District', domain="[('state_id', '=', state_id)]")
    ghn_ward_id = fields.Char("GHN Ward Code", help='Mã phường/xã theo Giao hàng Nhanh')

    def create_ward_data(self):
        request_url = "https://online-gateway.ghn.vn/shiip/public-api/master-data/ward"
        ghn_token = self.env['ir.config_parameter'].sudo().get_param('ghn_token')
        headers = {
            'Content-type': 'application/json',
            'Token': ghn_token
        }
        req = requests.get(request_url, headers=headers, params={"district_id": 1452})
        req.raise_for_status()
        content = req.json()
        print(content)
        data = content['data']
        for rec in data:
            existed_district = self.env['res.district'].sudo().search([('ghn_district_id', '=', rec['DistrictID'])],limit=1)
            if existed_district:
                vals = {}
                vals['state_id'] = existed_district.state_id.id
                vals['country_id'] = existed_district.country_id.id
                vals['district_id'] = existed_district.id
                vals['name'] = rec['WardName']
                vals['ghn_ward_id'] = rec['WardCode']
                self.env['res.ward'].sudo().create(vals)