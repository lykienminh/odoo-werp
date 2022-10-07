import os
from functools import reduce

odoo_dir = os.getcwd()
os.chdir(odoo_dir + '/.vscode')

rules = [
  (' COLLATE pg_catalog."default"', ''),
  # ('NOT NULL DEFAULT nextval(\'account_account_id_seq\'::regclass)', '[pk]'),
  ('CREATE TABLE IF NOT EXISTS public.', 'TABLE '),
  ('character varying', 'varchar'),
  ('NOT NULL', '[not null]'),
  ('timestamp without time zone', 'timestamp'),
  ('(', '{'),
  (')', '}'),
  (',', '')
]

string_constraint = ''
TABLE_NAME = ''

def includeOf(string, criteria):
  return any(item in string for item in criteria)

def output_ref(input):
  output = ''

  list_item_ignore = [
    'create_uid',
    'create_date',
    'write_uid',
    'write_date',
    'res_users',
  ]

  for line in input.splitlines():
    if includeOf(line, list_item_ignore):
      continue

    foreignKeyIndex = line.find('FOREIGN KEY')
    if foreignKeyIndex >= 0:
      index = foreignKeyIndex + 13
      column = line[index: -1]
      output += 'REF: ' + TABLE_NAME + '.' + column + ' > '
    refTableIndex = line.find('REFERENCES public.')
    if(refTableIndex >= 0):
      index = refTableIndex + 18
      table = line[index:]
      output += table.split()[0] + '.id\n'
  return output

def is_ref(input):
  list_item_ignore = [
    'PRIMARY KEY',
    # 'UNIQUE',
    'ON UPDATE',
    'ON DELETE',
    'create_uid',
    'create_date',
    'write_uid',
    'write_date',
  ]
  list_item_ref = ['FOREIGN KEY', 'REFERENCES']
  if includeOf(input, list_item_ignore):
    return (True, '')
  if includeOf(input, list_item_ref):
    return (True, line)
  return (False, line)

with open("sql.sql", "r") as fin:
  with open("sql-output.txt", "wt") as fout:
    for line in fin:
      (isRef, ref_line) = is_ref(line)
      if isRef:
        string_constraint += ref_line
        continue
      new_line = reduce(lambda a, kv: a.replace(*kv), rules, line)
      if 'TABLE' in new_line:
        TABLE_NAME = new_line[6:-1]
      fout.write(new_line)
    fout.write('\n' + output_ref(string_constraint))
