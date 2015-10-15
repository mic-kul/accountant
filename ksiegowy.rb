require 'yaml'
require 'rubygems'
require 'faktura_parser'
require 'wfirma_expenses_add'

config = YAML.load_file('ksiegowy.yml')

invoice_file_path = ARGV[0]

faktura_parser = FakturaParser.new(invoice_file_path).to_hash
#nip, document_number, amount_brutto, purchase_date
Wfirma::Expenses::Add.new(config['wfirma']['login'], config['wfirma']['password'], faktura_parser[:nip], faktura_parser[:document_number], faktura_parser[:amount_brutto], faktura_parser[:date]).run!
puts "faktura zaksiegowana"
