from odoo import api, fields, models, _

class StockWarehouse(models.Model):
    _inherit = 'stock.warehouse'

    ghn_shop_id = fields.Char('GHN Shop ID', help='Shop ID giúp quản lý nhiều cửa hàng trên GHN')