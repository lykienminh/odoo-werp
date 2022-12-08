# -*- coding: utf-8 -*-
{
    'name': "Scrap",
    'summary': "Manage scrapped/damaged goods.",
    'description': "",
    'author': "Quy Minh",
    'category': 'Inventory/Inventory',
    'version': '1.0',
    'depends': ['stock', 'product'],
    'data': [
        'security/ir.model.access.csv',
        'security/stock_scrap_security.xml',
        'views/stock_location_views.xml',
        'views/stock_move_views.xml',
        'views/stock_picking_views.xml',
        'views/stock_scrap_views.xml',
        'wizard/stock_warn_insufficient_qty_views.xml',
        'data/stock_data.xml',
    ],

    'installable': True,
    'auto_install': False,
    'application': False,
    'license': 'LGPL-3'
}
