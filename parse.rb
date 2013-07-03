require 'debugger'
require 'csv'

POSTCODES_FILE = 'doogal_postcodes_jun_2013/postcodes.csv'

puts "Working on file #{POSTCODES_FILE}"

export_sql = File.open('export.pgsql', 'w')

puts 'Opening CSV file'

csv_table = CSV.read(POSTCODES_FILE, quote_char: '"', col_sep: ',', row_sep: :auto, headers: true)

puts 'Opened CSV file'

i = 0
csv_table.each do |row|
  # format is Postcode,Latitude,Longitude
  code = row[0].gsub(' ', '')
  lat = row[1]
  lon = row[2]

  export_sql.write "INSERT INTO doogal_postcodes_jun_2013(code, lat,lon) VALUES ('#{code}', #{lat}, #{lon});"
  i += 1
  puts i if i % 1000 == 0
end

puts "Successfully parsed file #{POSTCODES_FILE}"

export_sql.close

puts 'Exported to export.pgsql'



