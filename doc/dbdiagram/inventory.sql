-- ============================================
-- Inventory Modules: Inventory, Purchase
-- ============================================

Table mail_compose_message {
    id integer [pk]
    lang varchar
    subject varchar
    body text
    template_id integer
    parent_id integer
    layout varchar
    add_sign boolean
    email_from varchar
    author_id integer
    composition_mode varchar
    model varchar
    res_id integer
    record_name varchar
    use_active_domain boolean
    active_domain text
    message_type varchar [not null]
    subtype_id integer
    mail_activity_type_id integer
    reply_to varchar
    reply_to_force_new boolean
    is_log boolean
    notify boolean
    auto_delete boolean
    auto_delete_message boolean
    mail_server_id integer
}

Ref: mail_compose_message.author_id > res_partner.id
Ref: mail_compose_message.mail_activity_type_id > mail_activity_type.id
Ref: mail_compose_message.parent_id > mail_message.id
Ref: mail_compose_message.subtype_id > mail_message_subtype.id
Ref: mail_compose_message.template_id > mail_template.id

Table mail_message {
    id integer [pk]
    subject varchar
    date timestamp
    body text
    parent_id integer
    model varchar
    res_id integer
    record_name varchar
    message_type varchar [not null]
    subtype_id integer
    mail_activity_type_id integer
    is_internal boolean
    email_from varchar
    author_id integer
    author_guest_id integer
    reply_to_force_new boolean
    reply_to varchar
    mail_server_id integer
    email_layout_xmlid varchar
    add_sign boolean
}

Ref: mail_message.author_guest_id > mail_guest.id
Ref: mail_message.author_id > res_partner.id
Ref: mail_message.mail_activity_type_id > mail_activity_type.id
Ref: mail_message.subtype_id > mail_message_subtype.id

Table purchase_order {
    id integer [pk]
    access_token varchar
    name varchar [not null]
    priority varchar
    origin varchar
    partner_ref varchar
    date_order timestamp [not null]
    date_approve timestamp
    partner_id integer [not null]
    dest_address_id integer
    currency_id integer [not null]
    state varchar
    notes text
    invoice_count integer
    invoice_status varchar
    date_planned timestamp
    date_calendar_start timestamp
    amount_untaxed numeric
    amount_tax numeric
    amount_total numeric
    fiscal_position_id integer
    payment_term_id integer
    incoterm_id integer
    user_id integer
    company_id integer [not null]
    currency_rate double
    mail_reminder_confirmed boolean
    mail_reception_confirmed boolean
    picking_type_id integer [not null]
    group_id integer
    effective_date timestamp
}

Ref: purchase_order.dest_address_id > res_partner.id
Ref: purchase_order.partner_id > res_partner.id
Ref: purchase_order.fiscal_position_id > account_fiscal_position.id
Ref: purchase_order.group_id > procurement_group.id
Ref: purchase_order.payment_term_id > account_payment_term.id
Ref: purchase_order.picking_type_id > stock_picking_type.id

Table procurement_group {
    id integer [pk]
    partner_id integer
    name varchar [not null]
    move_type varchar [not null]
    sale_id integer
}

Ref: procurement_group.parent_id > res_partner.id
Ref: procurement_group.sale_id > sale_order.id

Table stock_picking_type {
    id integer [pk]
    name varchar [not null]
    color integer
    sequence integer
    sequence_id integer
    sequence_code varchar [not null]
    default_location_src_id integer
    default_location_dest_id integer
    code varchar [not null]
    return_picking_type_id integer
    show_entire_packs boolean
    warehouse_id integer
    active boolean
    use_create_lots boolean
    use_existing_lots boolean
    print_label boolean
    show_operations boolean
    show_reserved boolean
    reservation_method varchar [not null]
    reservation_days_before integer
    reservation_days_before_priority integer
    barcode varchar
    company_id integer [not null]
}

Ref: stock_picking_type.default_location_dest_id > stock_location.id
Ref: stock_picking_type.default_location_src_id > stock_location.id
Ref: stock_picking_type.return_picking_type_id > stock_picking_type.id
Ref: stock_picking_type.warehouse_id > stock_warehouse.id

Table stock_location {
    id integer [pk]
    name varchar [not null]
    complete_name varchar
    active boolean
    usage varchar [not null]
    location_id integer
    comment text
    posx integer
    posy integer
    posz integer
    parent_path varchar
    company_id integer [unique]
    scrap_location boolean
    return_location boolean
    removal_strategy_id integer
    barcode varchar [unique]
    cyclic_inventory_frequency integer
    last_inventory_date date
    next_inventory_date date
    storage_category_id integer
    valuation_in_account_id integer
    valuation_out_account_id integer
}

Ref: stock_location.location_id > stock_location.id
Ref: stock_location.removal_strategy_id > product_removal.id
Ref: stock_location.storage_category_id > stock_storage_category.id
Ref: stock_location.valuation_in_account_id > account_account.id
Ref: stock_location.valuation_out_account_id > account_account.id

Table stock_warehouse {
    id integer [pk]
    name varchar [not null, unique]
    active boolean
    company_id integer [not null. unique]
    partner_id integer
    view_location_id integer [not null]
    lot_stock_id integer [not null]
    code varchar [not null, unique]
    reception_steps varchar [not null]
    delivery_steps varchar [not null]
    wh_input_stock_loc_id integer
    wh_qc_stock_loc_id integer
    wh_output_stock_loc_id integer
    wh_pack_stock_loc_id integer
    mto_pull_id integer
    pick_type_id integer
    pack_type_id integer
    out_type_id integer
    in_type_id integer
    int_type_id integer
    return_type_id integer
    crossdock_route_id integer
    reception_route_id integer
    delivery_route_id integer
    sequence integer
    buy_to_resupply boolean
    buy_pull_id integer
}

Ref: stock_warehouse.mto_pull_id > stock_rule.id
Ref: stock_warehouse.buy_pull_id > stock_rule.id
Ref: stock_warehouse.partner_id > res_partner.id
Ref: stock_warehouse.crossdock_route_id > stock_location_route.id
Ref: stock_warehouse.delivery_route_id > stock_location_route.id
Ref: stock_warehouse.reception_route_id > stock_location_route.id
Ref: stock_warehouse.in_type_id > stock_picking_type.id
Ref: stock_warehouse.int_type_id > stock_picking_type.id
Ref: stock_warehouse.out_type_id > stock_picking_type.id
Ref: stock_warehouse.pack_type_id > stock_picking_type.id
Ref: stock_warehouse.pick_type_id > stock_picking_type.id
Ref: stock_warehouse.return_type_id > stock_picking_type.id
Ref: stock_warehouse.lot_stock_id > stock_location.id
Ref: stock_warehouse.view_location_id > stock_location.id
Ref: stock_warehouse.wh_input_stock_loc_id > stock_location.id
Ref: stock_warehouse.wh_output_stock_loc_id > stock_location.id
Ref: stock_warehouse.wh_pack_stock_loc_id > stock_location.id
Ref: stock_warehouse.wh_qc_stock_loc_id > stock_location.id

Table stock_rule {
    id integer [pk]
    name varchar [not null]
    active boolean
    group_propagation_option varchar
    group_id integer
    action varchar [not null]
    sequence integer
    company_id integer
    location_id integer [not null]
    location_src_id integer
    route_id integer [not null]
    procure_method varchar [not null]
    route_sequence integer
    picking_type_id integer [not null]
    delay integer
    partner_address_id integer
    propagate_cancel boolean
    propagate_carrier boolean
    warehouse_id integer
    propagate_warehouse_id integer
    auto varchar [not null]
}

Ref: stock_rule.group_id > procurement_group.id
Ref: stock_rule.location_id > stock_location.id
Ref: stock_rule.location_src_id > stock_location.id
Ref: stock_rule.route_id > stock_location_route.id
Ref: stock_rule.partner_address_id > res_partner.id
Ref: stock_rule.picking_type_id > stock_picking_type.id
Ref: stock_rule.propagate_warehouse_id > stock_warehouse.id
Ref: stock_rule.warehouse_id > stock_warehouse.id

Table stock_location_route {
    id integer [pk]
    name varchar [not null]
    active boolean
    sequence integer
    product_selectable boolean
    product_categ_selectable boolean
    warehouse_selectable boolean
    packaging_selectable boolean
    supplied_wh_id integer
    supplier_wh_id integer
    company_id integer
    sale_selectable boolean
}

Ref: stock_location_route.supplied_wh_id > stock_warehouse.id
Ref: stock_location_route.supplier_wh_id > stock_warehouse.id

Table stock_storage_category {
    id integer [pk]
    name varchar [not null]
    max_weight numeric
    allow_new_product varchar [not null]
    company_id integer
}

Table product_removal {
    id integer [pk]
    name varchar [not null]
    method varchar [not null]
}

TABLE product_removal
{
  id integer [pk]
  name varchar [not null]
  method varchar [not null]
}

TABLE stock_putaway_rule
{
  id integer [pk]
  product_id integer
  category_id integer
  location_in_id integer [not null]
  location_out_id integer [not null]
  sequence integer
  company_id integer [not null]
  storage_category_id integer
  active boolean
}

REF: stock_putaway_rule.category_id > product_category.id
REF: stock_putaway_rule.company_id > res_company.id
REF: stock_putaway_rule.location_in_id > stock_location.id
REF: stock_putaway_rule.location_out_id > stock_location.id
REF: stock_putaway_rule.product_id > product_product.id
REF: stock_putaway_rule.storage_category_id > stock_storage_category.id

TABLE stock_location
{
  id integer [pk]
  name varchar [not null]
  complete_name varchar
  active boolean
  usage varchar [not null]
  location_id integer
  comment text
  posx integer
  posy integer
  posz integer
  parent_path varchar
  company_id integer [unique]
  scrap_location boolean
  return_location boolean
  removal_strategy_id integer
  barcode varchar [unique]
  cyclic_inventory_frequency integer
  last_inventory_date date
  next_inventory_date date
  storage_category_id integer
}

REF: stock_location.company_id > res_company.id
REF: stock_location.location_id > stock_location.id
REF: stock_location.removal_strategy_id > product_removal.id
REF: stock_location.storage_category_id > stock_storage_category.id

TABLE stock_location_route
{
  id integer [not null]
  name varchar [not null]
  active boolean
  sequence integer
  product_selectable boolean
  product_categ_selectable boolean
  warehouse_selectable boolean
  packaging_selectable boolean
  supplied_wh_id integer
  supplier_wh_id integer
  company_id integer
}

REF: stock_location_route.company_id > res_company.id
REF: stock_location_route.supplied_wh_id > stock_warehouse.id
REF: stock_location_route.supplier_wh_id > stock_warehouse.id

TABLE stock_move_line
{
  id integer [pk]
  picking_id integer
  move_id integer
  company_id integer [not null]
  product_id integer
  product_uom_id integer [not null]
  product_qty numeric
  product_uom_qty numeric [not null]
  qty_done numeric
  package_id integer
  package_level_id integer
  lot_id integer
  lot_name varchar
  result_package_id integer
  date timestamp [not null]
  owner_id integer
  location_id integer [not null]
  location_dest_id integer [not null]
  state varchar
  reference varchar
  description_picking text
}

REF: stock_move_line.company_id > res_company.id
REF: stock_move_line.location_dest_id > stock_location.id
REF: stock_move_line.location_id > stock_location.id
REF: stock_move_line.lot_id > stock_production_lot.id
REF: stock_move_line.move_id > stock_move.id
REF: stock_move_line.owner_id > res_partner.id
REF: stock_move_line.package_id > stock_quant_package.id
REF: stock_move_line.package_level_id > stock_package_level.id
REF: stock_move_line.picking_id > stock_picking.id
REF: stock_move_line.product_id > product_product.id
REF: stock_move_line.product_uom_id > uom_uom.id
REF: stock_move_line.result_package_id > stock_quant_package.id

TABLE stock_move
{
  id integer [pk]
  name varchar [not null]
  sequence integer
  priority varchar
  date timestamp [not null]
  date_deadline timestamp
  company_id integer [not null]
  product_id integer [not null]
  description_picking text
  product_qty numeric
  product_uom_qty numeric [not null]
  product_uom integer [not null]
  location_id integer [not null]
  location_dest_id integer [not null]
  partner_id integer
  picking_id integer
  state varchar
  price_unit double
  origin varchar
  procure_method varchar [not null]
  scrapped boolean
  group_id integer
  rule_id integer
  propagate_cancel boolean
  delay_alert_date timestamp
  picking_type_id integer
  is_inventory boolean
  origin_returned_move_id integer
  restrict_partner_id integer
  warehouse_id integer
  additional boolean
  reference varchar
  package_level_id integer
  next_serial varchar
  next_serial_count integer
  orderpoint_id integer
  reservation_date date
  product_packaging_id integer
}

REF: stock_move.company_id > res_company.id
REF: stock_move.group_id > procurement_group.id
REF: stock_move.location_dest_id > stock_location.id
REF: stock_move.location_id > stock_location.id
REF: stock_move.orderpoint_id > stock_warehouse_orderpoint.id
REF: stock_move.origin_returned_move_id > stock_move.id
REF: stock_move.package_level_id > stock_package_level.id
REF: stock_move.partner_id > res_partner.id
REF: stock_move.picking_id > stock_picking.id
REF: stock_move.picking_type_id > stock_picking_type.id
REF: stock_move.product_id > product_product.id
REF: stock_move.product_packaging_id > product_packaging.id
REF: stock_move.product_uom > uom_uom.id
REF: stock_move.restrict_partner_id > res_partner.id
REF: stock_move.rule_id > stock_rule.id
REF: stock_move.warehouse_id > stock_warehouse.id

TABLE stock_warehouse_orderpoint
{
  id integer [pk]
  name varchar [not null]
  trigger varchar [not null]
  active boolean
  snoozed_until date
  warehouse_id integer [not null]
  location_id integer [not null, unique]
  product_id integer [not null, unique]
  product_category_id integer
  product_min_qty numeric [not null]
  product_max_qty numeric [not null]
  qty_multiple numeric [not null]
  group_id integer
  company_id integer [not null, unique]
  route_id integer
  qty_to_order double
}

REF: stock_warehouse_orderpoint.company_id > res_company.id
REF: stock_warehouse_orderpoint.group_id > procurement_group.id
REF: stock_warehouse_orderpoint.location_id > stock_location.id
REF: stock_warehouse_orderpoint.product_category_id > product_category.id
REF: stock_warehouse_orderpoint.product_id > product_product.id
REF: stock_warehouse_orderpoint.route_id > stock_location_route.id
REF: stock_warehouse_orderpoint.warehouse_id > stock_warehouse.id

TABLE stock_package_level
{
  id integer [pk]
  package_id integer [not null]
  picking_id integer
  location_dest_id integer
  company_id integer [not null]
}

REF: stock_package_level.company_id > res_company.id
REF: stock_package_level.location_dest_id > stock_location.id
REF: stock_package_level.package_id > stock_quant_package.id
REF: stock_package_level.picking_id > stock_picking.id

TABLE stock_package_type
{
  id integer [pk]
  name varchar [not null]
  sequence integer
  height integer
  width integer
  packaging_length integer
  max_weight double
  barcode varchar [unique]
  company_id integer
}

REF: stock_package_type.company_id > res_company.id

TABLE stock_picking
{
  id integer [pk]
  message_main_attachment_id integer
  name varchar [unique]
  origin varchar
  note text
  backorder_id integer
  move_type varchar [not null]
  state varchar
  group_id integer
  priority varchar
  scheduled_date timestamp
  date_deadline timestamp
  has_deadline_issue boolean
  date timestamp
  date_done timestamp
  location_id integer [not null]
  location_dest_id integer [not null]
  picking_type_id integer [not null]
  partner_id integer
  company_id integer [unique]
  user_id integer
  owner_id integer
  printed boolean
  is_locked boolean
  immediate_transfer boolean
}

REF: stock_picking.backorder_id > stock_picking.id
REF: stock_picking.company_id > res_company.id
REF: stock_picking.group_id > procurement_group.id
REF: stock_picking.location_dest_id > stock_location.id
REF: stock_picking.location_id > stock_location.id
REF: stock_picking.message_main_attachment_id > ir_attachment.id
REF: stock_picking.owner_id > res_partner.id
REF: stock_picking.partner_id > res_partner.id
REF: stock_picking.picking_type_id > stock_picking_type.id

TABLE stock_picking_type
{
  id integer [pk]
  name varchar [not null]
  color integer
  sequence integer
  sequence_id integer
  sequence_code varchar [not null]
  default_location_src_id integer
  default_location_dest_id integer
  code varchar [not null]
  return_picking_type_id integer
  show_entire_packs boolean
  warehouse_id integer
  active boolean
  use_create_lots boolean
  use_existing_lots boolean
  print_label boolean
  show_operations boolean
  show_reserved boolean
  reservation_method varchar [not null]
  reservation_days_before integer
  reservation_days_before_priority integer
  barcode varchar
  company_id integer [not null]
}

REF: stock_picking_type.company_id > res_company.id
REF: stock_picking_type.default_location_dest_id > stock_location.id
REF: stock_picking_type.default_location_src_id > stock_location.id
REF: stock_picking_type.return_picking_type_id > stock_picking_type.id
REF: stock_picking_type.sequence_id > ir_sequence.id
REF: stock_picking_type.warehouse_id > stock_warehouse.id

TABLE stock_production_lot
{
  id integer [pk]
  message_main_attachment_id integer
  name varchar [not null]
  ref varchar
  product_id integer [not null]
  product_uom_id integer
  note text
  company_id integer [not null]
}

REF: stock_production_lot.company_id > res_company.id
REF: stock_production_lot.message_main_attachment_id > ir_attachment.id
REF: stock_production_lot.product_id > product_product.id
REF: stock_production_lot.product_uom_id > uom_uom.id

TABLE stock_quant
{
  product_id integer [not null]
  company_id integer
  location_id integer [not null]
  lot_id integer
  package_id integer
  owner_id integer
  quantity numeric
  reserved_quantity numeric [not null]
  in_date timestamp [not null]
  inventory_quantity numeric
  inventory_diff_quantity numeric
  inventory_date date
  inventory_quantity_set boolean
  user_id integer
}

REF: stock_quant.company_id > res_company.id
REF: stock_quant.location_id > stock_location.id
REF: stock_quant.lot_id > stock_production_lot.id
REF: stock_quant.owner_id > res_partner.id
REF: stock_quant.package_id > stock_quant_package.id
REF: stock_quant.product_id > product_product.id

TABLE stock_quant_package
{
  id integer [pk]
  name varchar [not null]
  package_type_id integer
  location_id integer
  company_id integer
  package_use varchar [not null]
}

REF: stock_quant_package.company_id > res_company.id
REF: stock_quant_package.location_id > stock_location.id
REF: stock_quant_package.package_type_id > stock_package_type.id

TABLE stock_rule
{
  id integer [pk]
  name varchar [not null]
  active boolean
  group_propagation_option varchar
  group_id integer
  action varchar [not null]
  sequence integer
  company_id integer
  location_id integer [not null]
  location_src_id integer
  route_id integer [not null]
  procure_method varchar [not null]
  route_sequence integer
  picking_type_id integer [not null]
  delay integer
  partner_address_id integer
  propagate_cancel boolean
  propagate_carrier boolean
  warehouse_id integer
  propagate_warehouse_id integer
  auto varchar [not null]
}

REF: stock_rule.company_id > res_company.id
REF: stock_rule.group_id > procurement_group.id
REF: stock_rule.location_id > stock_location.id
REF: stock_rule.location_src_id > stock_location.id
REF: stock_rule.partner_address_id > res_partner.id
REF: stock_rule.picking_type_id > stock_picking_type.id
REF: stock_rule.propagate_warehouse_id > stock_warehouse.id
REF: stock_rule.route_id > stock_location_route.id
REF: stock_rule.warehouse_id > stock_warehouse.id

TABLE procurement_group
{
  id integer [pk]
  partner_id integer
  name varchar [not null]
  move_type varchar [not null]
}

REF: procurement_group.partner_id > res_partner.id

TABLE stock_scrap
{
  id integer [pk]
  message_main_attachment_id integer
  name varchar [not null]
  company_id integer [not null]
  origin varchar
  product_id integer [not null]
  product_uom_id integer [not null]
  lot_id integer
  package_id integer
  owner_id integer
  move_id integer
  picking_id integer
  location_id integer [not null]
  scrap_location_id integer [not null]
  scrap_qty numeric [not null]
  state varchar
  date_done timestamp
}

REF: stock_scrap.company_id > res_company.id
REF: stock_scrap.location_id > stock_location.id
REF: stock_scrap.lot_id > stock_production_lot.id
REF: stock_scrap.message_main_attachment_id > ir_attachment.id
REF: stock_scrap.move_id > stock_move.id
REF: stock_scrap.owner_id > res_partner.id
REF: stock_scrap.package_id > stock_quant_package.id
REF: stock_scrap.picking_id > stock_picking.id
REF: stock_scrap.product_id > product_product.id
REF: stock_scrap.product_uom_id > uom_uom.id
REF: stock_scrap.scrap_location_id > stock_location.id

TABLE stock_storage_category
{
  id integer [pk]
  name varchar [not null]
  max_weight numeric
  allow_new_product varchar [not null]
  company_id integer
}

REF: stock_storage_category.company_id > res_company.id

TABLE stock_storage_category_capacity
{
  id integer [pk]
  storage_category_id integer [not null]
  product_id integer
  package_type_id integer
  quantity double [not null]
}

REF: stock_storage_category_capacity.package_type_id > stock_package_type.id
REF: stock_storage_category_capacity.product_id > product_product.id
REF: stock_storage_category_capacity.storage_category_id > stock_storage_category.id

TABLE stock_warehouse
{
  id integer [pk]
  name varchar [not null]
  active boolean
  company_id integer [not null]
  partner_id integer
  view_location_id integer [not null]
  lot_stock_id integer [not null]
  code varchar{5} [not null]
  reception_steps varchar [not null]
  delivery_steps varchar [not null]
  wh_input_stock_loc_id integer
  wh_qc_stock_loc_id integer
  wh_output_stock_loc_id integer
  wh_pack_stock_loc_id integer
  mto_pull_id integer
  pick_type_id integer
  pack_type_id integer
  out_type_id integer
  in_type_id integer
  int_type_id integer
  return_type_id integer
  crossdock_route_id integer
  reception_route_id integer
  delivery_route_id integer
  sequence integer
}

REF: stock_warehouse.company_id > res_company.id
REF: stock_warehouse.crossdock_route_id > stock_location_route.id
REF: stock_warehouse.delivery_route_id > stock_location_route.id
REF: stock_warehouse.in_type_id > stock_picking_type.id
REF: stock_warehouse.int_type_id > stock_picking_type.id
REF: stock_warehouse.lot_stock_id > stock_location.id
REF: stock_warehouse.mto_pull_id > stock_rule.id
REF: stock_warehouse.out_type_id > stock_picking_type.id
REF: stock_warehouse.pack_type_id > stock_picking_type.id
REF: stock_warehouse.partner_id > res_partner.id
REF: stock_warehouse.pick_type_id > stock_picking_type.id
REF: stock_warehouse.reception_route_id > stock_location_route.id
REF: stock_warehouse.return_type_id > stock_picking_type.id
REF: stock_warehouse.view_location_id > stock_location.id
REF: stock_warehouse.wh_input_stock_loc_id > stock_location.id
REF: stock_warehouse.wh_output_stock_loc_id > stock_location.id
REF: stock_warehouse.wh_pack_stock_loc_id > stock_location.id
REF: stock_warehouse.wh_qc_stock_loc_id > stock_location.id

TABLE barcode_rule
{
  id integer [pk]
  name varchar{32} [not null]
  barcode_nomenclature_id integer
  sequence integer
  encoding varchar [not null]
  type varchar [not null]
  pattern varchar{32} [not null]
  alias varchar{32} [not null]
}

REF: barcode_rule.barcode_nomenclature_id > barcode_nomenclature.id

TABLE barcode_nomenclature
{
  id integer [pk]
  name varchar{32} [not null]
  upc_ean_conv varchar [not null]
}

TABLE digest_tip
{
  id integer [pk]
  sequence integer
  name varchar
  tip_description text
  group_id integer
}

REF: digest_tip.group_id > res_groups.id

TABLE digest_digest
{
  id integer [pk]
  name varchar [not null]
  periodicity varchar [not null]
  next_run_date date
  company_id integer
  state varchar
  kpi_res_users_connected boolean
  kpi_mail_message_total boolean
}

REF: digest_digest.company_id > res_company.id

TABLE product_attribute
{
  id integer [pk]
  name varchar [not null]
  sequence integer
  create_variant varchar [not null]
  display_type varchar [not null]
}

TABLE product_attribute_value
{
  id integer [pk]
  name varchar [not null]
  sequence integer
  attribute_id integer [not null]
  is_custom boolean
  html_color varchar
  color integer
}

REF: product_attribute_value.attribute_id > product_attribute.id

TABLE product_template_attribute_line
{
  id integer [pk]
  active boolean
  product_tmpl_id integer [not null]
  attribute_id integer [not null]
  value_count integer
}

REF: product_template_attribute_line.attribute_id > product_attribute.id
REF: product_template_attribute_line.product_tmpl_id > product_template.id

TABLE product_template_attribute_value
{
  id integer [pk]
  ptav_active boolean
  product_attribute_value_id integer [not null]
  attribute_line_id integer [not null]
  price_extra numeric
  product_tmpl_id integer
  attribute_id integer
  color integer
}

REF: product_template_attribute_value.product_attribute_value_id > product_attribute_value.id
REF: product_template_attribute_value.attribute_id > product_attribute.id
REF: product_template_attribute_value.attribute_line_id > product_template_attribute_line.id
REF: product_template_attribute_value.product_tmpl_id > product_template.id

TABLE product_template_attribute_exclusion
{
  id integer [pk]
  product_template_attribute_value_id integer
  product_tmpl_id integer [not null]
}

REF: product_template_attribute_exclusion.product_template_attribute_value_id > product_template_attribute_value.id
REF: product_template_attribute_exclusion.product_tmpl_id > product_template.id

TABLE product_attribute_custom_value
{
  id integer [pk]
  custom_product_template_attribute_value_id integer [not null]
  custom_value varchar
}

REF: product_attribute_custom_value.custom_product_template_attribute_value_id > product_template_attribute_value.id

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

REF: product_pricelist.company_id > res_company.id
REF: product_pricelist.currency_id > res_currency.id

TABLE product_pricelist_item
{
  id integer [pk]
  product_tmpl_id integer
  product_id integer
  categ_id integer
  min_quantity numeric
  applied_on varchar [not null]
  base varchar [not null]
  base_pricelist_id integer
  pricelist_id integer [not null]
  price_surcharge numeric
  price_discount numeric
  price_round numeric
  price_min_margin numeric
  price_max_margin numeric
  company_id integer
  currency_id integer
  active boolean
  date_start timestamp
  date_end timestamp
  compute_price varchar [not null]
  fixed_price numeric
  percent_price double
}

REF: product_pricelist_item.base_pricelist_id > product_pricelist.id
REF: product_pricelist_item.categ_id > product_category.id
REF: product_pricelist_item.company_id > res_company.id
REF: product_pricelist_item.currency_id > res_currency.id
REF: product_pricelist_item.pricelist_id > product_pricelist.id
REF: product_pricelist_item.product_id > product_product.id
REF: product_pricelist_item.product_tmpl_id > product_template.id

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
  sale_delay double
  tracking varchar [not null]
  description_picking text
  description_pickingout text
  description_pickingin text
}

REF: product_template.categ_id > product_category.id
REF: product_template.company_id > res_company.id
REF: product_template.message_main_attachment_id > ir_attachment.id
REF: product_template.uom_id > uom_uom.id
REF: product_template.uom_po_id > uom_uom.id

TABLE product_category
{
  id integer [pk]
  name varchar [not null]
  complete_name varchar
  parent_id integer
  parent_path varchar
  removal_strategy_id integer
  packaging_reserve_method varchar
}

REF: product_category.parent_id > product_category.id
REF: product_category.removal_strategy_id > product_removal.id

TABLE product_product
{
  id integer [pk]
  message_main_attachment_id integer
  default_code varchar
  active boolean
  product_tmpl_id integer [not null]
  barcode varchar [unique]
  combination_indices varchar
  volume numeric
  weight numeric
  can_image_variant_1024_be_zoomed boolean
}

REF: product_product.message_main_attachment_id > ir_attachment.id
REF: product_product.product_tmpl_id > product_template.id

TABLE product_packaging
{
  id integer [pk]
  name varchar [not null]
  sequence integer
  product_id integer
  qty numeric
  barcode varchar
  company_id integer
  package_type_id integer
}

REF: product_packaging.company_id > res_company.id
REF: product_packaging.package_type_id > stock_package_type.id
REF: product_packaging.product_id > product_product.id

TABLE product_supplierinfo
{
  id integer [pk]
  name integer [not null]
  product_name varchar
  product_code varchar
  sequence integer
  min_qty numeric [not null]
  price numeric [not null]
  company_id integer
  currency_id integer [not null]
  date_start date
  date_end date
  product_id integer
  product_tmpl_id integer
  delay integer [not null]
}

REF: product_supplierinfo.company_id > res_company.id
REF: product_supplierinfo.currency_id > res_currency.id
REF: product_supplierinfo.name > res_partner.id
REF: product_supplierinfo.product_id > product_product.id
REF: product_supplierinfo.product_tmpl_id > product_template.id

