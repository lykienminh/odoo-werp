TABLE hr_department
{
  id integer [pk]
  message_main_attachment_id integer
  name varchar [not null]
  complete_name varchar
  active boolean
  company_id integer
  parent_id integer
  manager_id integer
  note text
  color integer
}

REF: hr_department.company_id > res_company.id
REF: hr_department.manager_id > hr_employee.id
REF: hr_department.parent_id > hr_department.id

TABLE hr_departure_reason
{
  id integer [pk]
  sequence integer
  name varchar [not null]
}

TABLE hr_employee_category
{
  id integer [pk]
  name varchar [not null, unique]
  color integer
}

-- hr_employee_public

TABLE hr_employee
{
  id integer [pk]
  resource_id integer [not null]
  company_id integer [not null, unique]
  resource_calendar_id integer
  message_main_attachment_id integer
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
  parent_id integer
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
}

REF: hr_employee.address_home_id > res_partner.id
REF: hr_employee.address_id > res_partner.id
REF: hr_employee.bank_account_id > res_partner_bank.id
REF: hr_employee.coach_id > hr_employee.id
REF: hr_employee.company_id > res_company.id
REF: hr_employee.country_id > res_country.id
REF: hr_employee.country_of_birth > res_country.id
REF: hr_employee.department_id > hr_department.id
REF: hr_employee.departure_reason_id > hr_departure_reason.id
REF: hr_employee.job_id > hr_job.id
REF: hr_employee.parent_id > hr_employee.id
REF: hr_employee.resource_calendar_id > resource_calendar.id
REF: hr_employee.resource_id > resource_resource.id
REF: hr_employee.work_location_id > hr_work_location.id

TABLE hr_job
{
  id integer [pk]
  message_main_attachment_id integer
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

REF: hr_job.company_id > res_company.id
REF: hr_job.department_id > hr_department.id

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

TABLE hr_work_location
{
  id integer [pk]
  active boolean
  name varchar [not null]
  company_id integer [not null]
  address_id integer [not null]
  location_number varchar
}

REF: hr_work_location.address_id > res_partner.id
REF: hr_work_location.company_id > res_company.id

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

