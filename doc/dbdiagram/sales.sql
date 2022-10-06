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
  parent_id integer
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
  message_main_attachment_id integer
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
Ref: res_partner.parent_id > res_partner.id
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
  message_main_attachment_id integer
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
  message_main_attachment_id integer
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

Table account_account {
  id integer [pk]
}