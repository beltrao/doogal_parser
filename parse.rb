export_sql = File.open('export.pgsql', 'w')

index = 0

File.open('doogal_postcodes_jun_2013/postcodes.csv').each do |line|
  if index == 0
    index += 1
    next
  end

  # AB1 0 AA, 57.101478, -2.242852, ...
  columns = line.split(',')
  code = columns[0].gsub(' ', '')
  lat = columns[1]
  lon = columns[2]

  export_sql.write "INSERT INTO doogal_postcodes_jun_2013(code, lat,lon) VALUES ('#{code}', #{lat}, #{lon});"

  index += 1
  puts index if index % 1000 == 0
end

export_sql.close

puts 'Exported to export.pgsql'



