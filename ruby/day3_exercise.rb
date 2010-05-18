module ActsAsCsv

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def read
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      @csv_contents = []
      @alt_csv_contents = []
      file.each do |row|
        columns = row.chomp.split(', ')
        @csv_contents << columns
        @alt_csv_contents << CsvRow.new(@headers, columns)
      end
    end

    attr_accessor :headers, :csv_contents, :alt_csv_contents

    def initialize
      read
    end

    def each
      @csv_contents.each {|row| yield CsvRow.new(@headers, row) }
    end

    def alt_each(&block)
      @alt_csv_contents.each &block
    end
  end

  class CsvRow
    def initialize(headers, values)
      @headers = headers
      @values = values
    end

    def method_missing(sym, *args, &block)
      index = @headers.index(sym.to_s)
      return "No column titled #{sym}" unless index

      @values[index] 
    end
  end
end


class RubyCsv
  include ActsAsCsv
  acts_as_csv

end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
puts m.alt_csv_contents.inspect


puts "Exercise Results"

csv = RubyCsv.new
csv.each {|row| puts "one = #{row.one}, two = #{row.two}" }
puts "Dealing with invalid"
csv.each { |row| puts row.does_not_exist }


puts "Alternate Each"
csv.alt_each {|row| puts "one = #{row.one}, two = #{row.two}" }
puts "Dealing with invalid"
csv.alt_each { |row| puts row.does_not_exist }
