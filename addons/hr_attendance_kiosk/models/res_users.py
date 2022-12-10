# -*- coding: utf-8 -*-

from odoo import models, fields, _

HR_WRITABLE_FIELDS = [
    'additional_note',
    'private_street',
    'private_street2',
    'private_city',
    'private_state_id',
    'private_zip',
    'private_country_id',
    'address_id',
    'barcode',
    'birthday',
    'category_ids',
    'children',
    'coach_id',
    'country_of_birth',
    'department_id',
    'display_name',
    'emergency_contact',
    'emergency_phone',
    'employee_bank_account_id',
    'employee_country_id',
    'gender',
    'identification_id',
    'is_address_home_a_company',
    'job_title',
    'private_email',
    'km_home_work',
    'marital',
    'mobile_phone',
    'notes',
    'employee_parent_id',
    'passport_id',
    'permit_no',
    'employee_phone',
    'pin',
    'place_of_birth',
    'spouse_birthdate',
    'spouse_complete_name',
    'visa_expire',
    'visa_no',
    'work_email',
    'work_location_id',
    'work_phone',
    'certificate',
    'study_field',
    'study_school',
    'private_lang',
    'employee_type',
]

class User(models.Model):
    _inherit = ['res.users']

    barcode = fields.Char(related='employee_id.barcode', readonly=False, related_sudo=False)
    pin = fields.Char(related='employee_id.pin', readonly=False, related_sudo=False)