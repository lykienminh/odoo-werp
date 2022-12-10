# -*- coding: utf-8 -*-
{
	'name': "Shopee Integration",
	'summary': "Shopee Integration",
	'description': "Sale Shopee x Odoo Integration",
	'author': "Quy Minh",
	'version': '1.0',
	'category': 'Sales',
	'depends': ['mail', 'base', 'sale', 'purchase', 'stock'],
	'images': ['static/description/icon.png'],
	'data': [
		'security/sale_shopee_security.xml',
		'security/ir.model.access.csv',
		'views/merchant_shopee_views.xml',
		'views/sale_views.xml',
		'data/refresh_token.xml',
		'wizard/shopee_sync_views.xml',
		'wizard/pickup_views_wizard.xml'
	],
    'assets': {
        'web.assets_backend': [
            'sale_shopee/static/src/js/systray_shopeebutton.js',
        ],
        'web.assets_qweb': [
            'sale_shopee/static/src/xml/systray.xml',
        ],
    },
    "installable": True,
    'application': False,
    'auto_install': False,
	'license': 'LGPL-3'
}
