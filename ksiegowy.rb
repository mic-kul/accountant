require 'yaml'
require 'rubygems'
require 'faktura_parser'
require 'wfirma_expenses_add'

config = YAML.load_file('ksiegowy.yml')

invoice_file_path = ARGV[0]

faktura_parser = FakturaParser.new(invoice_file_path).to_hash
p faktura_parser
options = {
  wfirma_login: config['wfirma']['login'],
  wfirma_password: config['wfirma']['password'],
  nip: faktura_parser[:nip],
  document_number: faktura_parser[:document_number],
  amount_brutto: faktura_parser[:amount_brutto],
  date: faktura_parser[:date],
  date_purchase: faktura_parser[:date_purchase],
  pay_until: faktura_parser[:pay_until],
  expense_type: faktura_parser[:expense_type],
  paid: faktura_parser[:paid],
}

Wfirma::Expenses::Add.new(options).run!
puts "faktura #{faktura_parser[:document_number]} zaksiegowana"
