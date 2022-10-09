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



