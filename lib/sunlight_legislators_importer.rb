require 'csv'
require 'date'
require_relative '../app/models/politician'
require 'debugger'

class SunlightLegislatorsImporter
  def self.import(filename)
    field_names =[]
    data = []
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      name = ""
      row.each do |field, value|
        case field
        when "title", "district", "in_office", "gender", "website", "webform", "twitter_id"
          field_names << field
          data << value
        when "firstname"
          field_names << "first_name"
          data << value
        when "lastname"
          field_names << "last_name"
          data << value
        when "party"
          field_names << field
          data << value.slice(0)
        when "state"
          field_names << field
          data << value.slice(0,2)
        when "phone", "fax"
          field_names << field
          data << value.gsub(/-/,'')
        when "birthdate"
          field_names << field
          data << DateTime.strptime(value, "%m/%d/%Y")
        end
      end
      attribute_hash = Hash[field_names.zip(data)]
      new_politician = Politician.create!(attribute_hash)
    end
  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
begin
  raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
  SunlightLegislatorsImporter.import(ARGV[0])
rescue ArgumentError => e
  $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
rescue NotImplementedError => e
  $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
end
