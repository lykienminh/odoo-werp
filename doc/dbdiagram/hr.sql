-- ============================================
-- HR Modules: Employee, Attendance, Time off
-- ============================================

TABLE hr_plan_activity_type
{
  id integer [pk]
  activity_type_id integer
  summary varchar
  responsible varchar [not null]
  responsible_id integer
  note text
}

REF: hr_plan_activity_type.activity_type_id > mail_activity_type.id
REF: hr_plan_activity_type.responsible_id > res_users.id

TABLE hr_plan
{
  id integer [pk]
  name varchar [not null]
  active boolean
}

TABLE barcode_rule
{
  id integer [pk]
  name varchar [not null]
  barcode_nomenclature_id integer
  sequence integer
  encoding varchar [not null]
  type varchar [not null]
  pattern varchar [not null]
  alias varchar [not null]
}

REF: barcode_rule.barcode_nomenclature_id > barcode_nomenclature.id

TABLE barcode_nomenclature
{
  id integer [pk]
  name varchar [not null]
  upc_ean_conv varchar [not null]
}

Table hr_attendance {
    id integer [pk]
    employee_id integer [not null]
    check_in timestamp [not null]
    check_out timestamp
    worked_hours double
}

Ref: hr_attendance.employee_id > hr_employee.id

Table hr_attendance_overtime {
    id integer [pk]
    employee_id integer [not null]
    date date
    duration double [not null]
    duration_real double
    adjustment boolean
}

Ref: hr_attendance_overtime.employee_id > hr_employee.id

Table hr_employee {
    id integer [pk]
    resource_id integer [not null]
    company_id integer [not null, unique]
    resource_calendar_id integer
    name varchar
    active boolean
    color integer
    department_id integer
    job_id integer
    job_title varchar
    address_id integer
    work_phone varchar
    mobile_phone varchar
    work_email varchar
    work_location_id integer
    user_id integer [unique]
    coach_id integer
    employee_type varchar [not null]
    address_home_id integer
    country_id integer
    gender varchar
    marital varchar
    spouse_complete_name varchar
    spouse_birthdate date
    children integer
    place_of_birth varchar
    country_of_birth integer
    birthday date
    ssnid varchar
    sinid varchar
    identification_id varchar
    passport_id varchar
    bank_account_id integer
    permit_no varchar
    visa_no varchar
    visa_expire date
    work_permit_expiration_date date
    work_permit_scheduled_activity boolean
    additional_note text
    certificate varchar
    study_field varchar
    study_school varchar
    emergency_contact varchar
    emergency_phone varchar
    km_home_work integer
    notes text
    barcode varchar [unique]
    pin varchar
    departure_reason_id integer
    departure_description text
    departure_date date
    leave_manager_id integer
    last_attendance_id integer
    last_check_in timestamp
    last_check_out timestamp
}

Ref: hr_employee.address_home_id > res_partner.id
Ref: hr_employee.address_id > res_partner.id
Ref: hr_employee.bank_account_id > res_partner_bank.id
Ref: hr_employee.coach_id > hr_employee.id
Ref: hr_employee.department_id > hr_department.id
Ref: hr_employee.departure_reason_id > hr_departure_reason.id
Ref: hr_employee.job_id > hr_job.id
Ref: hr_employee.last_attendance_id > hr_attendance.id
Ref: hr_employee.leave_manager_id > res_users.id
Ref: hr_employee.resource_calendar_id > resource_calendar.id
Ref: hr_employee.resource_id > resource_resource.id
Ref: hr_employee.work_location_id > hr_work_location.id

Table hr_employee_category {
    id [pk]
}

Table employee_category_rel {
    emp_id integer
    category_id integer
    Indexes{
        (emp_id, category_id) [pk]
    }
}

Ref: employee_category_rel.emp_id - hr_employee.id
Ref: employee_category_rel.category_id - hr_employee_category.id

Table hr_department {
    id integer [pk]
    name varchar [not null]
    complete_name varchar
    active boolean
    company_id integer
    manager_id integer
    note text
    color integer
}

Ref: hr_department.manager_id > hr_employee.id

Table hr_departure_reason {
    id integer [pk]
    sequence integer
    name varchar [not null]
}

Table hr_job {
    id integer [pk]
    name varchar [not null]
    sequence integer
    expected_employees integer
    no_of_employee integer
    no_of_recruitment integer
    no_of_hired_employee integer
    description text
    requirements text
    department_id integer [unique]
    company_id integer [unique]
    state varchar [not null]
}

Ref: hr_job.department_id > hr_department.id

Table hr_work_location {
    id integer [pk]
    active boolean
    name varchar [not null]
    company_id integer [not null]
    address_id integer [not null]
    location_number varchar
}

Ref: hr_work_location.address_id > res_partner.id

Table hr_leave_accrual_plan_level {
    id integer [pk]
    sequence integer
    accrual_plan_id integer [not null]
    start_count integer
    start_type varchar [not null]
    is_based_on_worked_time boolean
    added_value double [not null]
    added_value_type varchar [not null]
    frequency varchar [not null]
    week_day varchar [not null]
    first_day integer
    second_day integer
    first_month_day integer
    first_month varchar
    second_month_day integer
    second_month varchar
    yearly_month varchar
    yearly_day integer
    maximum_leave double
    action_with_unused_accruals varchar [not null]
}

Ref: hr_leave_accrual_plan_level.accrual_plan_id > hr_leave_accrual_plan.id

Table hr_leave_accrual_plan {
    id integer [pk]
    name varchar [not null]
    time_off_type_id integer
    transition_mode varchar [not null]
}

Table hr_leave_allocation {
    id integer [pk]
    active boolean
    private_name varchar
    state varchar
    date_from date [not null]
    date_to date
    holiday_status_id integer [not null]
    employee_id integer
    employee_company_id integer
    manager_id integer
    notes text
    number_of_days double
    approver_id integer
    holiday_type varchar [not null]
    multi_employee boolean
    mode_company_id integer
    department_id integer
    category_id integer
    lastcall date
    nextcall date
    allocation_type varchar [not null]
    accrual_plan_id integer
    overtime_id integer
}

Ref: hr_leave_allocation.employee_id > hr_employee.id
Ref: hr_leave_allocation.approver_id > hr_employee.id
Ref: hr_leave_allocation.manager_id > hr_employee.id
Ref: hr_leave_allocation.accrual_plan_id > hr_leave_accrual_plan.id
Ref: hr_leave_allocation.department_id > hr_department.id
Ref: hr_leave_allocation.holiday_status_id > hr_leave_type.id
Ref: hr_leave_allocation.overtime_id > hr_attendance_overtime.id

Table hr_leave_type {
    id integer [pk]
    name varchar [not null]
    sequence integer
    create_calendar_meeting boolean
    color_name varchar [not null]
    color integer
    icon_id integer
    active boolean
    company_id integer
    responsible_id integer
    leave_validation_type varchar
    requires_allocation varchar [not null]
    employee_requests varchar [not null]
    allocation_validation_type varchar
    time_type varchar
    request_unit varchar [not null]
    unpaid boolean
    leave_notif_subtype_id integer
    allocation_notif_subtype_id integer
    support_document boolean
    overtime_deductible boolean
}

Ref: hr_leave_type.allocation_notif_subtype_id > mail_message_subtype.id
Ref: hr_leave_type.leave_notif_subtype_id > mail_message_subtype.id
Ref: hr_leave_type.responsible_id > res_users.id

Table hr_leave {
    id integer [pk]
    private_name varchar
    state varchar
    report_note text
    user_id integer
    manager_id integer
    holiday_status_id integer [not null]
    holiday_allocation_id integer
    employee_id integer
    employee_company_id integer
    department_id integer
    notes text
    date_from timestamp [not null]
    date_to timestamp [not null]
    number_of_days double
    duration_display varchar
    meeting_id integer
    parent_id integer
    holiday_type varchar [not null]
    multi_employee boolean
    category_id integer
    mode_company_id integer
    first_approver_id integer
    second_approver_id integer
    request_date_from date
    request_date_to date
    request_hour_from varchar
    request_hour_to varchar
    request_date_from_period varchar
    request_unit_half boolean
    request_unit_hours boolean
    request_unit_custom boolean
    overtime_id integer
}

Ref: hr_leave.department_id > hr_department.id
Ref: hr_leave.employee_id > hr_employee.id
Ref: hr_leave.first_approver_id > hr_employee.id
Ref: hr_leave.second_approver_id > hr_employee.id
Ref: hr_leave.manager_id > hr_employee.id
Ref: hr_leave.holiday_allocation_id > hr_leave_allocation.id
Ref: hr_leave.holiday_status_id > hr_leave_type.id
Ref: hr_leave.meeting_id > calendar_event.id
Ref: hr_leave.overtime_id > hr_attendance_overtime.id

Table mail_message_subtype {
    id integer [pk]
    name varchar [not null]
    description text
    internal boolean
    relation_field varchar
    res_model varchar
    default boolean
    sequence integer
    hidden boolean
}

Table resource_resource {
    id integer [pk]
    name varchar [not null]
    active boolean
    company_id integer
    resource_type varchar [not null]
    user_id integer
    time_efficiency double [not null]
    calendar_id integer [not null]
    tz varchar [not null]
}

Ref: resource_resource.calendar_id > resource_calendar.id

Table resource_calendar {
    id integer [pk]
    name varchar [not null]
    active boolean
    company_id integer
    hours_per_day double
    tz varchar [not null]
    two_weeks_calendar boolean
}

Table calendar_alarm {
    id integer [pk]
    name varchar [not null]
    alarm_type varchar [not null]
    duration integer [not null]
    interval varchar [not null]
    duration_minutes integer
    mail_template_id integer
    body text
    sms_template_id integer
}

Ref: calendar_alarm.mail_template_id > mail_template.id
Ref: calendar_alarm.sms_template_id > sms_template.id

Table calendar_attendee {
    id integer [pk]
    event_id integer [not null]
    partner_id integer [not null]
    common_name varchar
    access_token varchar
    state varchar
    availability varchar
}

Ref: calendar_attendee.event_id > calendar_event.id
Ref: calendar_attendee.partner_id > res_partner.id

Table calendar_event {
    id integer [pk]
    name varchar [not null]
    description text
    user_id integer
    location varchar
    videocall_location varchar
    privacy varchar [not null]
    show_as varchar [not null]
    active boolean
    start timestamp [not null]
    stop timestamp [not null]
    allday boolean
    start_date date
    stop_date date
    duration double
    res_id integer
    res_model_id integer
    res_model varchar
    recurrency boolean
    recurrence_id integer
    follow_recurrence boolean
}

Ref: calendar_event.recurrence_id > calendar_recurrence.id

Table calendar_filters {
    id integer [pk]
    user_id integer [not null, unique]
    partner_id integer [not null, unique]
    active boolean
    partner_checked boolean
}

Ref: calendar_filters.partner_id > res_partner.id

Table calendar_recurrence {
    id integer [pk]
    name varchar
    base_event_id integer
    event_tz varchar
    rrule varchar
    rrule_type varchar
    end_type varchar
    interval integer
    count integer
    mon boolean
    tue boolean
    wed boolean
    thu boolean
    fri boolean
    sat boolean
    sun boolean
    month_by varchar
    day integer
    weekday varchar
    byday varchar
    until date
}

Ref: calendar_recurrence.base_event_id > calendar_event.id

Table mail_activity {
    id integer [pk]
    res_model_id integer [not null]
    res_model varchar
    res_id integer [not null]
    res_name varchar
    activity_type_id integer
    summary varchar
    note text
    date_deadline date [not null]
    automated boolean
    user_id integer [not null]
    request_partner_id integer
    recommended_activity_type_id integer
    previous_activity_type_id integer
    calendar_event_id integer
}

Ref: mail_activity.activity_type_id > mail_activity_type.id
Ref: mail_activity.previous_activity_type_id > mail_activity_type.id
Ref: mail_activity.recommended_activity_type_id > mail_activity_type.id
Ref: mail_activity.request_partner_id > res_partner.id
Ref: mail_activity.calendar_event_id > calendar_event.id

Table sms_template {
    id integer [pk]
    lang varchar
    name varchar
    model_id integer [not null]
    model varchar
    body varchar [not null]
    sidebar_action_id integer
}