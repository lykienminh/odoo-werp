
TABLE sale_order
{
  id integer [pk]
  name varchar [not null]
  // draft, sale, cancel
  state varchar
  user_id integer
  partner_id integer [not null]
  partner_invoice_id integer [not null]
  partner_shipping_id integer [not null]
  pricelist_id integer [not null]
  // no, to invoice, invoiced
  invoice_status varchar
  team_id integer
  sale_order_template_id integer
  // procurement_group_id
}

REF: sale_order.partner_id - res_partner.id
REF: sale_order.partner_invoice_id - res_partner.id
REF: sale_order.partner_shipping_id - res_partner.id
REF: sale_order.pricelist_id - product_pricelist.id
REF: sale_order.sale_order_template_id - sale_order_template.id
REF: sale_order.team_id - crm_team.id

TABLE sale_order_line
{
  id integer [pk]
  order_id integer [not null]
  name text [not null]
  // sort order start with 10
  sequence integer
  invoice_status varchar 
  
  price_unit numeric [not null]
  price_subtotal numeric
  price_tax double
  price_total numeric
  
  product_id integer
  product_uom_qty numeric [not null]
  // units [km, kg]
  // product_uom integer
  
  // qty_delivered_method varchar 
  qty_delivered numeric
  // qty_delivered_manual numeric
  qty_to_invoice numeric
  qty_invoiced numeric
  // untaxed_amount_invoiced numeric
  // untaxed_amount_to_invoice numeric
  
  salesman_id integer
  // currency_id integer
  // company_id integer
  order_partner_id integer
  // is_expense boolean
  // is_downpayment boolean
  state varchar 
  // customer_lead double [not null]
  // display_type varchar
  product_packaging_id integer
  product_packaging_qty double
}

REF: sale_order_line.order_id - sale_order.id
REF: sale_order_line.order_partner_id - res_partner.id
REF: sale_order_line.salesman_id - res_users.id

TABLE account_move
{
  id integer [pk]
  // sequence_prefix varchar
  // sequence_number integer
  name varchar
  
  // message_main_attachment_id integer
  // access_token varchar
  // date date [not null]
  // ref varchar
  // narration text
  state varchar [not null]
  // posted_before boolean
  // move_type varchar [not null]
  // to_check boolean
  
  // CASH, BANK, BILL
  journal_id integer [not null]
  // company_id integer
  // currency_id integer [not null]
  partner_id integer
  // commercial_partner_id integer
  // is_move_sent boolean
  partner_bank_id integer
  
  // payment_reference varchar
  payment_id integer
  // statement_line_id integer
  
  // amount_untaxed numeric
  // amount_tax numeric
  amount_total numeric
  // amount_residual numeric
  // amount_untaxed_signed numeric
  // amount_tax_signed numeric
  amount_total_signed numeric
  // amount_total_in_currency_signed numeric
  // amount_residual_signed numeric
  
  payment_state varchar
  // tax_cash_basis_rec_id integer
  // tax_cash_basis_origin_move_id integer
  // always_tax_exigible boolean
  // auto_post boolean
  // reversed_entry_id integer
  // fiscal_position_id integer
  invoice_user_id integer
  invoice_date date
  invoice_date_due date
  // invoice_origin varchar
  // invoice_payment_term_id integer
  // invoice_incoterm_id integer
  // qr_code_method varchar
  invoice_source_email varchar
  invoice_partner_display_name varchar
  // invoice_cash_rounding_id integer
  // secure_sequence_number integer
  // inalterable_hash varchar
  // edi_state varchar
  // campaign_id integer
  // source_id integer
  // medium_id integer
  team_id integer
  partner_shipping_id integer
  preferred_payment_method_id integer
  // stock_move_id
}

// REF: account_move.campaign_id - utm_campaign.id
// REF: account_move.commercial_partner_id - res_partner.id
REF: account_move.journal_id - account_journal.id
REF: account_move.partner_bank_id - res_partner_bank.id
REF: account_move.partner_id - res_partner.id
REF: account_move.partner_shipping_id - res_partner.id
REF: account_move.payment_id - account_payment.id
REF: account_move.preferred_payment_method_id - account_payment_method.id
// REF: account_move.reversed_entry_id - account_move.id
// REF: account_move.tax_cash_basis_origin_move_id - account_move.id
REF: account_move.team_id - crm_team.id

TABLE crm_team_member
{
  id integer [pk]
  // message_main_attachment_id integer
  crm_team_id integer [not null]
  user_id integer [not null]
  // active boolean
}

REF: crm_team_member.crm_team_id - crm_team.id

TABLE product_pricelist
{
  id integer [pk]
  name varchar [not null]
  active boolean
  currency_id integer [not null]
  company_id integer
  sequence integer
  discount_policy varchar [not null]
}
 
Table res_users {
 id integer [pk]
 active boolean [default: true]
 login varchar [not null, unique]
 password varchar
// company_id integer
 partner_id integer
 signature text
 action_id integer
// share boolean
// totp_secret varchar
// notification_type varchar [not null]
// odoobot_state varchar
// odoobot_failed boolean
 sale_team_id integer
}
Ref: res_users.partner_id - res_partner.id
Ref: res_users.sale_team_id - crm_team.id
 
Table sale_order_template {
id integer [pk]
name varchar [not null]
note text
number_of_days integer
require_signature boolean
require_payment boolean
// mail_template_id integer
active boolean
// company_id integer
}
 
Table res_partner {
 id integer [pk]
 name varchar
// company_id integer
 display_name varchar
// date date
// title integer
 parent_id integer
// ref varchar
 lang varchar
 // region
 tz varchar
 user_id integer
 vat varchar
// website varchar
// comment text
// credit_limit double
 active boolean
// employee boolean
 function varchar
 
 //contact private
 type varchar
 street varchar
// street2 varchar
 zip varchar
 city varchar
 state_id integer
 country_id integer
 partner_latitude numeric
 partner_longitude numeric
 email varchar
 phone varchar
 mobile varchar
// is_company boolean
// industry_id integer
// color integer
// partner_share boolean
 commercial_partner_id integer
 commercial_company_name varchar
// company_name varchar
// message_main_attachment_id integer
// email_normalized varchar
// message_bounce integer
// signup_token varchar
// signup_type varchar
// signup_expiration timestamp
 team_id integer
// partner_gid integer
// additional_info varchar
// phone_sanitized varchar
// debit_limit numeric
// last_time_entries_checked timestamp
// invoice_warn varchar
// invoice_warn_msg text
// supplier_rank integer
// customer_rank integer
// sale_warn varchar
// sale_warn_msg text
}
Ref: res_partner.commercial_partner_id - res_partner.id
// Ref: res_partner.industry_id - res_partner_industry.id
Ref: res_partner.parent_id - res_partner.id
Ref: res_partner.team_id - crm_team.id
// Ref: res_partner.title - res_partner_title.id
 
// Table res_partner_industry {
// id integer [pk]
// name varchar
// full_name varchar
// active boolean
// }
 
// Table res_partner_title {
// id integer [pk]
// name varchar [not null]
// shortcut varchar
// }
 
Table crm_team {
 id integer [pk]
 message_main_attachment_id integer
 name varchar [not null]
 sequence integer
 active boolean
 company_id integer
 user_id integer
 color integer
 use_quotations boolean
 invoiced_target double
}
 
// Table res_groups {
// id integer [pk]
// name varchar [not null]
// comment text
// category_id integer
// color integer
// share boolean
// }
 
Table account_journal {
 id integer [pk]
 name varchar [not null]
 code varchar [not null, unique]
}

 
Table account_payment_method {
 id integer [pk]
 name varchar [not null]
 code varchar [not null, unique]
 payment_type varchar [not null, unique]
}
 
Table account_payment {
 id integer [pk]
 message_main_attachment_id integer
 move_id integer [not null]
// is_reconciled boolean
// is_matched boolean
 partner_bank_id integer
// is_internal_transfer boolean
// paired_internal_transfer_payment_id integer
// payment_method_line_id integer
 payment_method_id integer
 amount numeric
// partner_type varchar [not null]
// payment_reference varchar
// currency_id integer
 partner_id integer
// outstanding_account_id integer
// destination_account_id integer
// destination_journal_id integer
// payment_transaction_id integer
// payment_token_id integer
// source_payment_id integer
 check_amount_in_words varchar
// check_number varchar
}
 
// Ref: account_payment.destination_account_id - account_account.id
// Ref: account_payment.destination_journal_id - account_journal.id
Ref: account_payment.move_id - account_move.id
// Ref: account_payment.outstanding_account_id - account_account.id
// Ref: account_payment.paired_internal_transfer_payment_id - account_payment.id
Ref: account_payment.partner_bank_id - res_partner_bank.id
Ref: account_payment.partner_id - res_partner.id
Ref: account_payment.payment_method_id - account_payment_method.id
// Ref: account_payment.payment_token_id - payment_token.id
// Ref: account_payment.payment_transaction_id - payment_transaction.id
// Ref: account_payment.source_payment_id - account_payment.id

Table res_partner_bank {
  id integer [pk]
  active boolean
  acc_number varchar [not null]
  sanitized_acc_number varchar [unique]
  acc_holder_name varchar
  partner_id integer [not null]
  bank_id integer
  sequence integer
  currency_id integer
  company_id integer [unique]
  aba_routing varchar
}
