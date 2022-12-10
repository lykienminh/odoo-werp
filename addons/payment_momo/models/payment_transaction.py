# Part of Odoo. See LICENSE file for full copyright and licensing details.

import logging
import uuid
import hmac
import hashlib

from werkzeug import urls

from odoo import _, api, fields, models
from odoo.exceptions import ValidationError

from odoo.addons.payment import utils as payment_utils
from odoo.addons.payment_momo.const import PAYMENT_STATUS_MAPPING
from odoo.addons.payment_momo.controllers.main import MoMoController

_logger = logging.getLogger(__name__)


class PaymentTransaction(models.Model):
    _inherit = 'payment.transaction'

    def _get_specific_rendering_values(self, processing_values):
        """ Override of payment to return Paypal-specific rendering values.

        Note: self.ensure_one() from `_get_processing_values`

        :param dict processing_values: The generic and specific processing values of the transaction
        :return: The dict of acquirer-specific processing values
        :rtype: dict
        """
        res = super()._get_specific_rendering_values(processing_values)
        if self.provider != 'momo':
            return res

        base_url = self.acquirer_id.get_base_url() 

        partnerCode = self.acquirer_id.momo_partner_code
        accessKey = self.acquirer_id.momo_access_key
        secretKey = self.acquirer_id.momo_secret_key
        orderInfo = f"{self.reference}: {self.partner_name}"
        redirectUrl = urls.url_join(base_url, MoMoController._return_url)
        ipnUrl = urls.url_join(base_url, MoMoController._notify_url)
        amount = int(self.amount)
        orderId = str(uuid.uuid4())
        requestId = str(uuid.uuid4())
        requestType = "captureWallet"
        extraData = ""  # pass empty value or Encode base64 JsonString
        rawSignature = "accessKey=" + accessKey + "&amount=" + str(amount) + "&extraData=" + extraData + "&ipnUrl=" + ipnUrl + "&orderId=" + orderId + "&orderInfo=" + orderInfo + "&partnerCode=" + partnerCode + "&redirectUrl=" + redirectUrl + "&requestId=" + requestId + "&requestType=" + requestType
        h = hmac.new(bytes(secretKey, 'ascii'), bytes(rawSignature, 'ascii'), hashlib.sha256)
        signature = h.hexdigest()

        return {
            # 'address1': self.partner_address,
            # 'business': self.acquirer_id.paypal_email_account,
            # 'city': self.partner_city,
            # 'country': self.partner_country_id.code,
            # 'currency_code': self.currency_id.name,
            # 'email': self.partner_email,
            # 'first_name': partner_first_name,
            # 'handling': self.fees,
            # 'item_name': f"{self.company_id.name}: {self.reference}",
            # 'item_number': self.reference,
            # 'last_name': partner_last_name,
            # 'lc': self.partner_lang,
            # 'notify_url': notify_url,
            # 'return_url': urls.url_join(base_url, PaypalController._return_url),
            # 'state': self.partner_state_id.name,
            # 'zip_code': self.partner_zip,
            # MoMo
            'api_url': self.acquirer_id._momo_get_api_url(),
            'partner_code': partnerCode,
            'partner_name': 'WERP',
            'store_id': 'Online',
            'order_id': orderId,
            'order_info': orderInfo,
            'request_id': requestId,
            'amount': amount,
            'lang': "en" if self.partner_lang == "en_US" else "vi",
            'extra_data': extraData,
            'request_type': requestType,
            'redirect_url': redirectUrl,
            'ipn_url': ipnUrl,
            'signature': signature,
        }

    # @api.model
    # def _get_tx_from_feedback_data(self, provider, data):
    #     """ Override of payment to find the transaction based on Paypal data.

    #     :param str provider: The provider of the acquirer that handled the transaction
    #     :param dict data: The feedback data sent by the provider
    #     :return: The transaction if found
    #     :rtype: recordset of `payment.transaction`
    #     :raise: ValidationError if the data match no transaction
    #     """
    #     tx = super()._get_tx_from_feedback_data(provider, data)
    #     if provider != 'paypal':
    #         return tx

    #     reference = data.get('item_number')
    #     tx = self.search([('reference', '=', reference), ('provider', '=', 'paypal')])
    #     if not tx:
    #         raise ValidationError(
    #             "PayPal: " + _("No transaction found matching reference %s.", reference)
    #         )
    #     return tx

    # def _process_feedback_data(self, data):
    #     """ Override of payment to process the transaction based on Paypal data.

    #     Note: self.ensure_one()

    #     :param dict data: The feedback data sent by the provider
    #     :return: None
    #     :raise: ValidationError if inconsistent data were received
    #     """
    #     super()._process_feedback_data(data)
    #     if self.provider != 'paypal':
    #         return

    #     txn_id = data.get('txn_id')
    #     txn_type = data.get('txn_type')
    #     if not all((txn_id, txn_type)):
    #         raise ValidationError(
    #             "PayPal: " + _(
    #                 "Missing value for txn_id (%(txn_id)s) or txn_type (%(txn_type)s).",
    #                 txn_id=txn_id, txn_type=txn_type
    #             )
    #         )
    #     self.acquirer_reference = txn_id
    #     self.paypal_type = txn_type

    #     payment_status = data.get('payment_status')

    #     if payment_status in PAYMENT_STATUS_MAPPING['pending'] + PAYMENT_STATUS_MAPPING['done'] \
    #         and not (self.acquirer_id.paypal_pdt_token and self.acquirer_id.paypal_seller_account):
    #         # If a payment is made on an account waiting for configuration, send a reminder email
    #         self.acquirer_id._paypal_send_configuration_reminder()

    #     if payment_status in PAYMENT_STATUS_MAPPING['pending']:
    #         self._set_pending(state_message=data.get('pending_reason'))
    #     elif payment_status in PAYMENT_STATUS_MAPPING['done']:
    #         self._set_done()
    #     elif payment_status in PAYMENT_STATUS_MAPPING['cancel']:
    #         self._set_canceled()
    #     else:
    #         _logger.info("received data with invalid payment status: %s", payment_status)
    #         self._set_error(
    #             "PayPal: " + _("Received data with invalid payment status: %s", payment_status)
    #         )
