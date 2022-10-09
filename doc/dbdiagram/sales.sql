-- ============================================
-- Sales Modules: Sales, Invoice
-- ============================================

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
  parent_path varchar
}

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

TABLE account_group
{
  id integer [pk]
  parent_path varchar
  name varchar [not null]
  code_prefix_start varchar
  code_prefix_end varchar
  company_id integer [not null]
}

REF: account_group.company_id > res_company.id

TABLE account_bank_statement_cashbox
{
  id integer [pk]
}

TABLE account_bank_statement
{
  id integer [pk]
  sequence_prefix varchar
  sequence_number integer
  message_main_attachment_id integer
  name varchar
  reference varchar
  date date [not null]
  date_done timestamp
  balance_start numeric
  balance_end_real numeric
  state varchar [not null]
  journal_id integer [not null]
  company_id integer
  total_entry_encoding numeric
  balance_end numeric
  difference numeric
  user_id integer
  cashbox_start_id integer
  cashbox_end_id integer
  previous_statement_id integer
  is_valid_balance_start boolean
}

REF: account_bank_statement.cashbox_end_id > account_bank_statement_cashbox.id
REF: account_bank_statement.cashbox_start_id > account_bank_statement_cashbox.id
REF: account_bank_statement.company_id > res_company.id
REF: account_bank_statement.journal_id > account_journal.id
REF: account_bank_statement.message_main_attachment_id > ir_attachment.id
REF: account_bank_statement.previous_statement_id > account_bank_statement.id

TABLE account_bank_statement_line
{
  id integer [pk]
  move_id integer [not null]
  statement_id integer [not null]
  sequence integer
  account_number varchar
  partner_name varchar
  transaction_type varchar
  payment_ref varchar [not null]
  amount numeric
  amount_currency numeric
  foreign_currency_id integer
  amount_residual double
  currency_id integer
  partner_id integer
  is_reconciled boolean
}

REF: account_bank_statement_line.currency_id > res_currency.id
REF: account_bank_statement_line.foreign_currency_id > res_currency.id
REF: account_bank_statement_line.move_id > account_move.id
REF: account_bank_statement_line.partner_id > res_partner.id
REF: account_bank_statement_line.statement_id > account_bank_statement.id

TABLE account_cash_rounding
{
  id integer [pk]
  name varchar [not null]
  rounding double [not null]
  strategy varchar [not null]
  rounding_method varchar [not null]
}

TABLE account_full_reconcile
{
  id integer [pk]]
  name varchar [not null]
  exchange_move_id integer
}

REF: account_full_reconcile.exchange_move_id > account_move.id

TABLE account_incoterms
{
  id integer [pk]
  name varchar [not null]
  code varchar [not null]
  active boolean
}

TABLE account_move_line
{
  id integer [pk]
  move_id integer [not null]
  move_name varchar
  date date
  ref varchar
  parent_state varchar
  journal_id integer
  company_id integer
  company_currency_id integer
  account_id integer
  account_root_id integer
  sequence integer
  name varchar
  quantity numeric
  price_unit numeric
  discount numeric
  debit numeric
  credit numeric
  balance numeric
  amount_currency numeric
  price_subtotal numeric
  price_total numeric
  reconciled boolean
  blocked boolean
  date_maturity date
  currency_id integer [not null]
  partner_id integer
  product_uom_id integer
  product_id integer
  reconcile_model_id integer
  payment_id integer
  statement_line_id integer
  statement_id integer
  group_tax_id integer
  tax_line_id integer
  tax_group_id integer
  tax_base_amount numeric
  tax_repartition_line_id integer
  tax_audit varchar
  tax_tag_invert boolean
  amount_residual numeric
  amount_residual_currency numeric
  full_reconcile_id integer
  matching_number varchar
  analytic_account_id integer
  display_type varchar
  is_rounding_line boolean
  exclude_from_invoice_tab boolean
}

REF: account_move_line.account_id > account_account.id
REF: account_move_line.analytic_account_id > account_analytic_account.id
REF: account_move_line.company_currency_id > res_currency.id
REF: account_move_line.company_id > res_company.id
REF: account_move_line.currency_id > res_currency.id
REF: account_move_line.full_reconcile_id > account_full_reconcile.id
REF: account_move_line.group_tax_id > account_tax.id
REF: account_move_line.journal_id > account_journal.id
REF: account_move_line.move_id > account_move.id
REF: account_move_line.partner_id > res_partner.id
REF: account_move_line.payment_id > account_payment.id
REF: account_move_line.product_id > product_product.id
REF: account_move_line.product_uom_id > uom_uom.id
REF: account_move_line.reconcile_model_id > account_reconcile_model.id
REF: account_move_line.statement_id > account_bank_statement.id
REF: account_move_line.statement_line_id > account_bank_statement_line.id
REF: account_move_line.tax_group_id > account_tax_group.id
REF: account_move_line.tax_line_id > account_tax.id
REF: account_move_line.tax_repartition_line_id > account_tax_repartition_line.id

TABLE account_partial_reconcile
{
  id integer [pk]
  debit_move_id integer [not null]
  credit_move_id integer [not null]
  full_reconcile_id integer
  debit_currency_id integer
  credit_currency_id integer
  amount numeric
  debit_amount_currency numeric
  credit_amount_currency numeric
  company_id integer
  max_date date
}

REF: account_partial_reconcile.company_id > res_company.id
REF: account_partial_reconcile.credit_currency_id > res_currency.id
REF: account_partial_reconcile.credit_move_id > account_move_line.id
REF: account_partial_reconcile.debit_currency_id > res_currency.id
REF: account_partial_reconcile.debit_move_id > account_move_line.id
REF: account_partial_reconcile.full_reconcile_id > account_full_reconcile.id

TABLE account_payment_method_line
{
  id integer [pk]
  name varchar
  sequence integer
  payment_method_id integer [not null]
  payment_account_id integer
  journal_id integer
  payment_acquirer_id integer
}

REF: account_payment_method_line.journal_id > account_journal.id
REF: account_payment_method_line.payment_account_id > account_account.id
REF: account_payment_method_line.payment_acquirer_id > payment_acquirer.id
REF: account_payment_method_line.payment_method_id > account_payment_method.id

TABLE account_payment_term
{
  id integer [pk]
  name varchar [not null]
  active boolean
  note text
  company_id integer
  sequence integer [not null]
}

REF: account_payment_term.company_id > res_company.id

-- TABLE account_payment_term_line
-- {
--   id integer [not null]
--   value varchar [not null]
--   value_amount numeric
--   days integer [not null]
--   day_of_the_month integer
--   option varchar [not null]
--   payment_id integer [not null]
--   sequence integer
-- }

-- REF: account_payment_term_line.payment_id > account_payment_term.id

TABLE account_reconcile_model
{
  id integer [pk]
  message_main_attachment_id integer
  active boolean
  name varchar [not null]
  sequence integer [not null]
  company_id integer [not null]
  rule_type varchar [not null]
  auto_reconcile boolean
  to_check boolean
  matching_order varchar [not null]
  match_text_location_label boolean
  match_text_location_note boolean
  match_text_location_reference boolean
  match_nature varchar [not null]
  match_amount varchar
  match_amount_min double
  match_amount_max double
  match_label varchar
  match_label_param varchar
  match_note varchar
  match_note_param varchar
  match_transaction_type varchar
  match_transaction_type_param varchar
  match_same_currency boolean
  allow_payment_tolerance boolean
  payment_tolerance_param double
  payment_tolerance_type varchar [not null]
  match_partner boolean
  past_months_limit integer
  decimal_separator varchar
}

REF: account_reconcile_model.company_id > res_company.id
REF: account_reconcile_model.message_main_attachment_id > ir_attachment.id

-- TABLE account_reconcile_model_line
-- {
--   id integer [pk]
--   model_id integer
--   company_id integer
--   sequence integer [not null]
--   account_id integer [not null]
--   journal_id integer
--   label varchar
--   amount_type varchar [not null]
--   force_tax_included boolean
--   amount double
--   amount_string varchar [not null]
--   analytic_account_id integer
-- }

-- REF: account_reconcile_model_line.account_id > account_account.id
-- REF: account_reconcile_model_line.analytic_account_id > account_analytic_account.id
-- REF: account_reconcile_model_line.company_id > res_company.id
-- REF: account_reconcile_model_line.journal_id > account_journal.id
-- REF: account_reconcile_model_line.model_id > account_reconcile_model.id

TABLE account_tax_report
{
    id integer [pk]
    name varchar [not null]
    country_id integer [not null]
}

REF: account_tax_report.country_id > res_country.id

TABLE account_tax_group
{
  id integer [not null]
  name varchar [not null]
  sequence integer
  country_id integer
  preceding_subtotal varchar
}

REF: account_tax_group.country_id > res_country.id

TABLE account_tax
{
  id integer [pk]
  name varchar [not null]
  type_tax_use varchar [not null]
  tax_scope varchar
  amount_type varchar [not null]
  active boolean
  company_id integer [not null]
  sequence integer [not null]
  amount numeric [not null]
  description varchar
  price_include boolean
  include_base_amount boolean
  is_base_affected boolean
  analytic boolean
  tax_group_id integer [not null]
  tax_exigibility varchar
  cash_basis_transition_account_id integer
  country_id integer [not null]
  CONSTRAINT account_tax_name_company_uniq UNIQUE {name company_id type_tax_use tax_scope}
}

REF: account_tax.cash_basis_transition_account_id > account_account.id
REF: account_tax.company_id > res_company.id
REF: account_tax.country_id > res_country.id
REF: account_tax.tax_group_id > account_tax_group.id

TABLE account_tax_repartition_line
{
  id integer [pk]
  factor_percent double [not null]
  repartition_type varchar [not null]
  account_id integer
  invoice_tax_id integer
  refund_tax_id integer
  company_id integer
  sequence integer
  use_in_tax_closing boolean
}

REF: account_tax_repartition_line.account_id > account_account.id
REF: account_tax_repartition_line.company_id > res_company.id
REF: account_tax_repartition_line.invoice_tax_id > account_tax.id
REF: account_tax_repartition_line.refund_tax_id > account_tax.id

TABLE account_fiscal_position
{
  id integer [pk]
  sequence integer
  name varchar [not null]
  active boolean
  company_id integer [not null]
  note text
  auto_apply boolean
  vat_required boolean
  country_id integer
  country_group_id integer
  zip_from varchar
  zip_to varchar
  foreign_vat varchar
}

REF: account_fiscal_position.company_id > res_company.id
REF: account_fiscal_position.country_group_id > res_country_group.id
REF: account_fiscal_position.country_id > res_country.id

-- ==================================================

Table digest_digest {
    id integer [pk]
    name varchar [not null]
    periodicity varchar [not null]
    next_run_date date
    company_id integer
    state varchar [default: 'activated']
    kpi_res_users_connected boolean
    kpi_mail_message_total boolean
    kpi_account_total_revenue boolean
    kpi_all_sale_total boolean
}

Table digest_tip {
    id integer [pk]
    sequence integer
    name varchar
    tip_description text
    group_id integer
}

Ref: digest_tip.group_id > res_groups.id

Table res_users {
    id integer [pk]
    active boolean [default: true]
    login varchar [not null, unique]
    password varchar 
    company_id integer
    partner_id integer
    signature text 
    action_id integer
    share boolean
    totp_secret varchar 
    notification_type varchar [not null]
    odoobot_state varchar 
    odoobot_failed boolean
    sale_team_id integer
}

Ref: res_users.partner_id > res_partner.id
Ref: res_users.sale_team_id > crm_team.id

Table digest_digest_res_users_rel {
    digest_digest_id integer [not null]
    res_users_id integer
    Indexes {
        (digest_digest_id, res_users_id) [pk]
    }
}

Ref: digest_digest_res_users_rel.digest_digest_id > digest_digest.id
Ref: digest_digest_res_users_rel.res_users_id > res_users.id

Table digest_tip_res_users_rel {
    digest_tip_id integer [not null]
    res_users_id integer [not null]
    Indexes {
        (digest_tip_id, res_users_id) [pk]
    }
}

Ref: digest_tip_res_users_rel.digest_tip_id > digest_digest.id
Ref: digest_tip_res_users_rel.res_users_id > res_users.id

Table sale_order_template {
    id integer [pk]
    name varchar [not null]
    note text
    number_of_days integer
    require_signature boolean
    require_payment boolean
    mail_template_id integer
    active boolean
    company_id integer
}

Ref: sale_order_template.mail_template_id > mail_template.id

Table mail_template {
    id integer [pk]
    lang varchar
    name varchar
    model_id integer
    model varchar
    subject varchar
    email_from varchar
    use_default_to boolean
    email_to varchar
    partner_to varchar
    email_cc varchar
    reply_to varchar
    body_html text
    report_name varchar
    report_template integer
    mail_server_id integer
    scheduled_date varchar
    auto_delete boolean
    ref_ir_act_window integer
}

Table bus_presence {
    id integer [pk]
    user_id integer
    last_poll timestamp
    last_presence timestamp
    status varchar
    guest_id integer
}

Ref: bus_presence.guest_id > mail_guest.id

Table mail_guest {
    id integer [pk]
    name varchar [not null]
    access_token varchar [not null]
    country_id integer
    lang varchar
    timezone varchar
}

Table res_partner {
    id integer [pk]
    name varchar
    company_id integer
    display_name varchar
    date date
    title integer
    ref varchar
    lang varchar
    tz varchar
    user_id integer
    vat varchar
    website varchar
    comment text
    credit_limit double
    active boolean
    employee boolean
    function varchar
    type varchar
    street varchar
    street2 varchar
    zip varchar
    city varchar
    state_id integer
    country_id integer
    partner_latitude numeric
    partner_longitude numeric
    email varchar
    phone varchar
    mobile varchar
    is_company boolean
    industry_id integer
    color integer
    partner_share boolean
    commercial_partner_id integer
    commercial_company_name varchar
    company_name varchar
    email_normalized varchar
    message_bounce integer
    signup_token varchar
    signup_type varchar
    signup_expiration timestamp
    team_id integer
    partner_gid integer
    additional_info varchar
    phone_sanitized varchar
    debit_limit numeric
    last_time_entries_checked timestamp
    invoice_warn varchar
    invoice_warn_msg text
    supplier_rank integer
    customer_rank integer
    sale_warn varchar
    sale_warn_msg text
}
Ref: res_partner.commercial_partner_id > res_partner.id
Ref: res_partner.industry_id > res_partner_industry.id
Ref: res_partner.team_id > crm_team.id
Ref: res_partner.title > res_partner_title.id

Table res_partner_industry {
    id integer [pk]
    name varchar
    full_name varchar
    active boolean
}

Table res_partner_title {
    id integer [pk]
    name varchar [not null]
    shortcut varchar
}

Table crm_team {
    id integer [pk]
    name varchar [not null]
    sequence integer
    active boolean
    company_id integer
    user_id integer
    color integer
    use_quotations boolean
    invoiced_target double
}

Table res_groups {
    id integer [pk]
    name varchar [not null]
    comment text 
    category_id integer
    color integer
    share boolean
}

Table account_journal {
    id integer [pk]
    name varchar [not null]
    code varchar [not null, unique]
    active boolean
    type varchar [not null]
    default_account_id integer
    suspense_account_id integer
    restrict_mode_hash_table boolean
    sequence integer
    invoice_reference_type varchar [not null]
    invoice_reference_model varchar [not null]
    currency_id integer
    company_id integer [not null, unique]
    refund_sequence boolean
    sequence_override_regex text
    profit_account_id integer
    loss_account_id integer
    bank_account_id integer
    bank_statements_source varchar
    sale_activity_type_id integer
    sale_activity_user_id integer
    sale_activity_note text
    alias_id integer
    secure_sequence_id integer
    show_on_dashboard boolean
    color integer
    check_manual_sequencing boolean
    check_sequence_id integer
}

Ref: account_journal.alias_id > mail_alias.id
Ref: account_journal.bank_account_id > res_partner_bank.id
Ref: account_journal.default_account_id > account_account.id
Ref: account_journal.loss_account_id > account_account.id
Ref: account_journal.profit_account_id > account_account.id
Ref: account_journal.suspense_account_id > account_account.id
Ref: account_journal.sale_activity_type_id > mail_activity_type.id

Table account_payment_method {
    id integer [pk]
    name varchar [not null]
    code varchar [not null, unique]
    payment_type varchar [not null, unique]
}

Table account_payment {
    id integer [pk]
    move_id integer [not null]
    is_reconciled boolean
    is_matched boolean
    partner_bank_id integer
    is_internal_transfer boolean
    paired_internal_transfer_payment_id integer
    payment_method_line_id integer
    payment_method_id integer
    amount numeric
    payment_type varchar [not null]
    partner_type varchar [not null]
    payment_reference varchar
    currency_id integer
    partner_id integer
    outstanding_account_id integer
    destination_account_id integer
    destination_journal_id integer
    payment_transaction_id integer
    payment_token_id integer
    source_payment_id integer
    check_amount_in_words varchar
    check_number varchar
}

Ref: account_payment.destination_account_id > account_account.id
Ref: account_payment.destination_journal_id > account_journal.id
Ref: account_payment.move_id > account_move.id
Ref: account_payment.outstanding_account_id > account_account.id
Ref: account_payment.paired_internal_transfer_payment_id > account_payment.id
Ref: account_payment.partner_bank_id > res_partner_bank.id
Ref: account_payment.partner_id > res_partner.id
Ref: account_payment.payment_method_id > account_payment_method.id
REF: account_payment.payment_method_line_id > account_payment_method_line.id
Ref: account_payment.payment_token_id > payment_token.id
Ref: account_payment.payment_transaction_id > payment_transaction.id
Ref: account_payment.source_payment_id > account_payment.id

Table payment_acquirer {
    id integer [pk]
    name varchar [not null]
    sequence integer
    provider varchar [not null]
    state varchar [not null]
    company_id integer [not null]
    allow_tokenization boolean
    capture_manually boolean
    redirect_form_view_id integer
    inline_form_view_id integer
    fees_active boolean
    fees_dom_fixed double
    fees_dom_var double
    fees_int_fixed double
    fees_int_var double
    display_as varchar
    pre_msg text
    pending_msg text
    auth_msg text
    done_msg text
    cancel_msg text
    support_authorization boolean
    support_fees_computation boolean
    support_tokenization boolean
    support_refund varchar
    description text
    color integer
    module_id integer
    module_state varchar
    qr_code boolean
    so_reference_type varchar
}

Table payment_token {
    id integer [pk]
    acquirer_id integer [not null]
    name varchar [not null]
    partner_id integer [not null]
    company_id integer
    acquirer_ref varchar [not null]
    verified boolean
    active boolean
}

Ref: payment_token.acquirer_id > payment_acquirer.id
Ref: payment_token.partner_id > res_partner.id

Table payment_transaction {
    id integer [pk]
    acquirer_id integer [not null]
    company_id integer
    reference varchar [not null, unique]
    acquirer_reference varchar
    amount numeric [not null]
    currency_id integer [not null]
    fees numeric
    token_id integer
    state varchar [not null]
    state_message text
    last_state_change timestamp
    operation varchar
    payment_id integer
    source_transaction_id integer
    is_post_processed boolean
    tokenize boolean
    landing_route varchar
    callback_model_id integer
    callback_res_id integer
    callback_method varchar
    callback_hash varchar
    callback_is_done boolean
    partner_id integer [not null]
    partner_name varchar
    partner_lang varchar
    partner_email varchar
    partner_address varchar
    partner_zip varchar
    partner_city varchar
    partner_state_id integer
    partner_country_id integer
    partner_phone varchar
}

Ref: payment_transaction.acquirer_id > payment_acquirer.id
Ref: payment_transaction.partner_id > res_partner.id
Ref: payment_transaction.payment_id > account_payment.id
Ref: payment_transaction.source_transaction_id > payment_transaction.id
Ref: payment_transaction.token_id > payment_token.id

Table mail_alias {
    id integer [pk]
    alias_name varchar [unique]
    alias_model_id integer [not null]
    alias_user_id integer
    alias_defaults text [not null]
    alias_force_thread_id integer
    alias_parent_model_id integer
    alias_parent_thread_id integer
    alias_contact varchar [not null]
    alias_bounced_content text
}

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

Table mail_activity_type {
    id integer [pk]
    name varchar [not null]
    summary varchar
    sequence integer
    active boolean
    delay_count integer
    delay_unit varchar [not null]
    delay_from varchar [not null]
    icon varchar
    decoration_type varchar
    res_model varchar
    triggered_next_type_id integer
    chaining_type varchar [not null]
    category varchar
    default_user_id integer
    default_note text
}

Ref: mail_activity_type.triggered_next_type_id > mail_activity_type.id