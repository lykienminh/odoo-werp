# Part of Odoo. See LICENSE file for full copyright and licensing details.

# ISO 4217 codes of currencies supported by PayPal
SUPPORTED_CURRENCIES = (
    'VND',
)

# Mapping of transaction states to PayPal payment statuses
# See https://developer.paypal.com/docs/api-basics/notifications/ipn/IPNandPDTVariables/
PAYMENT_STATUS_MAPPING = {
    'pending': ('Pending',),
    'done': ('Processed', 'Completed'),
    'cancel': ('Voided', 'Expired'),
}
