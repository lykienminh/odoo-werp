# -*- coding: utf-8 -*-
{
    'name': "Attendance in Kiosk Mode",
    'summary': "Checkin/Checkout in Kiosk Mode",
    'description': "",
    'author': "Quy Minh",
    'category': 'Human Resources/Attendances',
    'version': '1.0',
    'depends': ['hr_attendance'],
    'demo': [
        'data/hr_attendance_kiosk_demo.xml'
    ],
    'data': [
        'security/ir.model.access.csv',
        'report/hr_employee_badge.xml',
        'views/hr_attendance_views.xml',
        'views/hr_employee_views.xml',
        'views/res_users.xml',
    ],
    'assets': {
        'web.assets_backend': [
            'hr_attendance_kiosk/static/src/js/kiosk_mode.js',
            'hr_attendance_kiosk/static/src/js/kiosk_confirm.js',
        ],
        'web.assets_qweb': [
            'hr_attendance_kiosk/static/src/xml/attendance.xml',
        ],
    },
    'installable': True,
    'auto_install': False,
    'application': False,
    'license': 'LGPL-3'
}
