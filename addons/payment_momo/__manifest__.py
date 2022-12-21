# Part of Odoo. See LICENSE file for full copyright and licensing details.

{
    'name': 'MoMo Payment Acquirer',
    'version': '2.0',
    'category': 'Accounting/Payment Acquirers',
    'sequence': 366,
    'summary': 'Payment Acquirer: MoMo Implementation',
    'description': """MoMo Payment Acquirer""",
    'depends': ['payment'],
    'data': [
        'views/payment_views.xml',
        'views/payment_paypal_templates.xml',
        'data/payment_acquirer_data.xml',
        # 'data/payment_paypal_email_data.xml',
    ],
    'application': False,
    'uninstall_hook': 'uninstall_hook',
    'license': 'LGPL-3',
}
