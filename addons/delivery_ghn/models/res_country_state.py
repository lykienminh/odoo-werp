from odoo import api, fields, models, _
import requests
import json

class ResCountryState(models.Model):
    _inherit = 'res.country.state'

    ghn_province_id = fields.Integer(string="GHN City/Province Code", help='City/Province code according to GHN')

    def fetch_all_province_id(self):
        request_url = "https://online-gateway.ghn.vn/shiip/public-api/master-data/province"
        ghn_token = self.env['ir.config_parameter'].sudo().get_param('ghn_token')
        headers = {
            'Content-type': 'application/json',
            'Token': ghn_token
        }
        req = requests.get(request_url, headers=headers)
        req.raise_for_status()
        content = req.json()
        print(content)
        data = content['data']
        for rec in data:
            existed_state = self.env['res.country.state'].sudo().search([('name', 'ilike', rec['ProvinceName'])])
            if existed_state:
                for e in existed_state:
                    e.sudo().write({
                        'ghn_province_id': rec['ProvinceID']
                    })
        return content


