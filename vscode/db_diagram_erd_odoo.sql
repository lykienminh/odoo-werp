TABLE sale_order
{
  id integer [pk]
  campaign_id integer
  source_id integer
  medium_id integer
  message_main_attachment_id integer
  access_token varchar
  name varchar [not null]
  origin varchar
  client_order_ref varchar
  reference varchar
  state varchar
  date_order timestamp [not null]
  validity_date date
  require_signature boolean
  require_payment boolean
  user_id integer
  partner_id integer [not null]
  partner_invoice_id integer [not null]
  partner_shipping_id integer [not null]
  pricelist_id integer [not null]
  currency_id integer
  analytic_account_id integer
  invoice_status varchar
  note text
  amount_untaxed numeric
  amount_tax numeric
  amount_total numeric
  currency_rate numeric
  payment_term_id integer
  fiscal_position_id integer
  company_id integer [not null]
  team_id integer
  signed_by varchar
  signed_on timestamp
  commitment_date timestamp
  show_update_pricelist boolean
  sale_order_template_id integer
}

REF: sale_order.analytic_account_id > account_analytic_account.id
REF: sale_order.campaign_id > utm_campaign.id
REF: sale_order.fiscal_position_id > account_fiscal_position.id
REF: sale_order.medium_id > utm_medium.id
REF: sale_order.partner_id > res_partner.id
REF: sale_order.partner_invoice_id > res_partner.id
REF: sale_order.partner_shipping_id > res_partner.id
REF: sale_order.payment_term_id > account_payment_term.id
REF: sale_order.pricelist_id > product_pricelist.id
REF: sale_order.sale_order_template_id > sale_order_template.id
REF: sale_order.source_id > utm_source.id
REF: sale_order.team_id > crm_team.id

TABLE sale_order_line
{
  id integer [pk]
  order_id integer [not null]
  name text  [not null]
  sequence integer
  invoice_status varchar
  price_unit numeric [not null]
  price_subtotal numeric
  price_tax double
  price_total numeric
  price_reduce numeric
  price_reduce_taxinc numeric
  price_reduce_taxexcl numeric
  discount numeric
  product_id integer
  product_uom_qty numeric [not null]
  product_uom integer
  qty_delivered_method varchar
  qty_delivered numeric
  qty_delivered_manual numeric
  qty_to_invoice numeric
  qty_invoiced numeric
  untaxed_amount_invoiced numeric
  untaxed_amount_to_invoice numeric
  salesman_id integer
  currency_id integer
  company_id integer
  order_partner_id integer
  is_expense boolean
  is_downpayment boolean
  state varchar
  customer_lead double [not null]
  display_type varchar
  product_packaging_id integer
  product_packaging_qty double
}

REF: sale_order_line.order_id > sale_order.id
REF: sale_order_line.order_partner_id > res_partner.id
REF: sale_order_line.product_id > product_product.id
REF: sale_order_line.product_packaging_id > product_packaging.id
REF: sale_order_line.product_uom > uom_uom.id
REF: sale_order_line.salesman_id > res_users.id

TABLE account_move
{
  id integer [pk]
  sequence_prefix varchar
  sequence_number integer
  message_main_attachment_id integer
  access_token varchar
  name varchar
  date date [not null]
  ref varchar
  narration text
  state varchar [not null]
  posted_before boolean
  move_type varchar [not null]
  to_check boolean
  journal_id integer [not null]
  company_id integer
  currency_id integer [not null]
  partner_id integer
  commercial_partner_id integer
  is_move_sent boolean
  partner_bank_id integer
  payment_reference varchar
  payment_id integer
  statement_line_id integer
  amount_untaxed numeric
  amount_tax numeric
  amount_total numeric
  amount_residual numeric
  amount_untaxed_signed numeric
  amount_tax_signed numeric
  amount_total_signed numeric
  amount_total_in_currency_signed numeric
  amount_residual_signed numeric
  payment_state varchar
  tax_cash_basis_rec_id integer
  tax_cash_basis_origin_move_id integer
  always_tax_exigible boolean
  auto_post boolean
  reversed_entry_id integer
  fiscal_position_id integer
  invoice_user_id integer
  invoice_date date
  invoice_date_due date
  invoice_origin varchar
  invoice_payment_term_id integer
  invoice_incoterm_id integer
  qr_code_method varchar
  invoice_source_email varchar
  invoice_partner_display_name varchar
  invoice_cash_rounding_id integer
  secure_sequence_number integer
  inalterable_hash varchar
  edi_state varchar
  campaign_id integer
  source_id integer
  medium_id integer
  team_id integer
  partner_shipping_id integer
  preferred_payment_method_id integer
}

REF: account_move.campaign_id > utm_campaign.id
REF: account_move.commercial_partner_id > res_partner.id
REF: account_move.fiscal_position_id > account_fiscal_position.id
REF: account_move.invoice_cash_rounding_id  > account_cash_rounding.id
REF: account_move.invoice_incoterm_id > account_incoterms.id
REF: account_move.invoice_payment_term_id > account_payment_term.id
REF: account_move.journal_id > account_journal.id
REF: account_move.medium_id > utm_medium.id
REF: account_move.partner_bank_id > res_partner_bank.id
REF: account_move.partner_id > res_partner.id
REF: account_move.partner_shipping_id > res_partner.id
REF: account_move.payment_id > account_payment.id
REF: account_move.preferred_payment_method_id > account_payment_method.id
REF: account_move.reversed_entry_id > account_move.id
REF: account_move.source_id > utm_source.id
REF: account_move.statement_line_id > account_bank_statement_line.id
REF: account_move.tax_cash_basis_origin_move_id > account_move.id
REF: account_move.tax_cash_basis_rec_id > account_partial_reconcile.id
REF: account_move.team_id > crm_team.id

TABLE crm_team
{
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

TABLE crm_team_member
{
  id integer [pk]
  message_main_attachment_id integer
  crm_team_id integer [not null]
  user_id integer [not null]
  active boolean
}

REF: crm_team_member.crm_team_id > crm_team.id

TABLE crm_tag
{
  id integer [pk]
  name varchar [not null]
  color integer
}

TABLE account_analytic_account
{
  id integer [pk]
  message_main_attachment_id integer
  name varchar [not null]
  code varchar
  active boolean
  group_id integer
  company_id integer
  partner_id integer
}

REF: account_analytic_account.group_id > account_analytic_group.id
REF: account_analytic_account.partner_id > res_partner.id

TABLE product_category
{
  id integer [pk]
  name varchar [not null]
  complete_name varchar
  parent_id integer
  parent_path varchar
}

REF: product_category.parent_id > product_category.id

TABLE product_template
{
  id integer [pk]
  message_main_attachment_id integer
  name varchar [not null]
  sequence integer
  description text
  description_purchase text
  description_sale text
  detailed_type varchar [not null]
  type varchar
  categ_id integer [not null]
  list_price numeric
  volume numeric
  weight numeric
  sale_ok boolean
  purchase_ok boolean
  uom_id integer [not null]
  uom_po_id integer [not null]
  company_id integer
  active boolean
  color integer
  default_code varchar
  can_image_1024_be_zoomed boolean
  has_configurable_attributes boolean
  priority varchar
  service_type varchar
  sale_line_warn varchar [not null]
  sale_line_warn_msg text
  expense_policy varchar
  invoice_policy varchar
}

REF: product_template.categ_id > product_category.id
REF: product_template.uom_id > uom_uom.id
REF: product_template.uom_po_id > uom_uom.id

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

TABLE product_attribute
{
  id integer [pk]
  name varchar [not null]
  sequence integer
  create_variant varchar [not null]
  display_type varchar [not null]
}

TABLE utm_campaign
{
  id integer [pk]
  name varchar [not null]
  user_id integer [not null]
  stage_id integer [not null]
  is_auto_campaign boolean
  color integer
  company_id integer
}

REF: utm_campaign.stage_id > utm_stage.id

TABLE account_account_tag
{
  id integer [pk]
  name varchar [not null]
  applicability varchar [not null]
  color integer
  active boolean
  tax_negate boolean
  country_id integer
}

REF: account_account_tag.country_id > res_country.id

TABLE account_account_type
{
  id integer [pk]
  name varchar [not null]
  include_initial_balance boolean
  type varchar [not null]
  internal_group varchar [not null]
  note text
}

TABLE account_account
{
  id integer [pk]
  message_main_attachment_id integer
  name varchar [not null]
  currency_id integer
  code varchar{64} [not null, unique]
  deprecated boolean
  user_type_id integer [not null]
  internal_type varchar
  internal_group varchar
  reconcile boolean
  note text
  company_id integer [not null, unique]
  group_id integer
  root_id integer
  is_off_balance boolean
}

REF: account_account.company_id > res_company.id
REF: account_account.currency_id > res_currency.id
REF: account_account.group_id > account_group.id


-- account_group
-- account_root
-- account_analytic_default
-- account_cashbox_line
-- account_bank_statement_cashbox
-- account_bank_statement_closebalance
-- account_bank_statement
-- account_bank_statement_line
-- account_cash_rounding
-- account_full_reconcile
-- account_incoterms
-- account_journal_group
-- account_journal
-- account_move
-- account_move_line
-- account_partial_reconcile
-- account_payment_method
-- account_payment_method_line
-- account_payment_term
-- account_payment_term_line
-- account_payment
-- account_reconcile_model_partner_mapping
-- account_reconcile_model_line
-- account_reconcile_model
-- account_tax_carryover_line
-- account_tax_report
-- account_tax_report_line
-- account_tax_group
-- account_tax
-- account_tax_repartition_line
-- account_group_template
-- account_account_template
-- account_chart_template
-- account_tax_template
-- account_tax_repartition_line_template
-- account_fiscal_position_template
-- account_fiscal_position_tax_template
-- account_fiscal_position_account_template
-- account_reconcile_model_template
-- account_reconcile_model_line_template
-- account_fiscal_position
-- account_fiscal_position_tax
-- account_fiscal_position_account
-- sequence_mixin
