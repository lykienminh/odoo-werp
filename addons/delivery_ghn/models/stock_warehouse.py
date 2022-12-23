from odoo import api, fields, models, _

class StockWarehouse(models.Model):
    _inherit = 'stock.warehouse'

    ghn_shop_id = fields.Char('GHN Shop ID', default='3554523', help='Shop ID helps to manage multiple stores on GHN')