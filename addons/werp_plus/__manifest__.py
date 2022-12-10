# -*- coding: utf-8 -*-
{
    'name': 'Werp+',
    'summary': 'Advanced version for recommended installation',
    'description': "",
    'author': 'Quy Minh',
    'website': 'http://www.yourcompany.com',

    # Categories can be used to filter modules in modules listing
    # Check https://github.com/odoo/odoo/blob/15.0/odoo/addons/base/data/ir_module_category_data.xml
    # for the full list
    'category': 'Version/Werp+',
    'version': '1.0',

    # any module necessary for this one to work correctly
    'depends': [
        'werp',
        'stock_scrap',
        'hr_attendance_kiosk',
        'hr_presence',
        'hr_contract',
        'hr_skills',
    ],

    # always loaded
    'data': [
        # 'security/ir.model.access.csv',
        'views/views.xml',
        'views/templates.xml',
    ],
    # only loaded in demonstration mode
    'demo': [
        'demo/demo.xml',
    ],
    
    'installable': True,
    'auto_install': False,
    'application': False,
    'license': 'LGPL-3'
}
