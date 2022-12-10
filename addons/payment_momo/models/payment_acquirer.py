# Part of Odoo. See LICENSE file for full copyright and licensing details.

import logging

from odoo import _, api, fields, models

from odoo.addons.payment_momo.const import SUPPORTED_CURRENCIES

_logger = logging.getLogger(__name__)


class PaymentAcquirer(models.Model):
    _inherit = 'payment.acquirer'

    provider = fields.Selection(
        selection_add=[('momo', "MoMo")], ondelete={'momo': 'set default'})
    momo_endpoint = fields.Char(
        string="endpoint",
        help="https://test-payment.momo.vn/v2/gateway/api/create",
        required_if_provider='momo')
    momo_partner_code = fields.Char(
        string="partnerCode",
        help="partnerCode")
    momo_access_key = fields.Char(
        string="accessKey",
        help="accessKey")
    momo_secret_key = fields.Char(
        string="secretKey",
        help="secretKey")

    @api.model
    def _get_compatible_acquirers(self, *args, currency_id=None, **kwargs):
        """ Override of payment to unlist MoMo acquirers when the currency is not supported. """
        acquirers = super()._get_compatible_acquirers(*args, currency_id=currency_id, **kwargs)

        currency = self.env['res.currency'].browse(currency_id).exists()
        if currency and currency.name not in SUPPORTED_CURRENCIES:
            acquirers = acquirers.filtered(lambda a: a.provider != 'momo')

        return acquirers

    def _momo_get_api_url(self):
        """ Return the API URL according to the acquirer state.

        Note: self.ensure_one()

        :return: The API URL
        :rtype: str
        """
        self.ensure_one()

        return self.momo_endpoint

    # def _paypal_send_configuration_reminder(self):
    #     template = self.env.ref(
    #         'payment_paypal.mail_template_paypal_invite_user_to_configure', raise_if_not_found=False
    #     )
    #     if template:
    #         render_template = template._render({'acquirer': self}, engine='ir.qweb')
    #         mail_body = self.env['mail.render.mixin']._replace_local_links(render_template)
    #         mail_values = {
    #             'body_html': mail_body,
    #             'subject': _("Add your PayPal account to Odoo"),
    #             'email_to': self.paypal_email_account,
    #             'email_from': self.create_uid.email_formatted,
    #             'author_id': self.create_uid.partner_id.id,
    #         }
    #         self.env['mail.mail'].sudo().create(mail_values).send()

    def _get_default_payment_method_id(self):
        self.ensure_one()
        if self.provider != 'momo':
            return super()._get_default_payment_method_id()
        return self.env.ref('payment_momo.payment_method_momo').id
