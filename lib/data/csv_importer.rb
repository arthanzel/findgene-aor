require "csv"

module CSVImporter
  def self.import(file)
    CSV.read(file).each_with_index do |row, i|
      if i == 0 # Forget about the header row
        next
      end

      code = row[0]
      name = row[1]
      sequence = row[2]

      if code && name && sequence
        Primer.create(code: code, name: name, sequence: sequence)
      end
    end
  end
end