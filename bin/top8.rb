require 'benchmark'
require 'csv'

if ARGV.any? 
  Benchmark.bm do |x|
    x.report {
      result = Hash.new(0)
      CSV.foreach(ARGV[0]) do |row|
        company_slug = row.first ? row.first.split("/")[1] : ""
        company_pageviews = row[2] ? row[2].delete(".").to_i : 0

        result[company_slug] += company_pageviews
      end
      CSV.open("total.csv", "wb") do |csv|
        result.to_a.sort { |a,b| a[1] <=> b[1] }.reverse.each do |company|
          csv << company
        end
      end
    }
  end
else
  puts "The script needs parameters to work"
  puts "usage example: #{$0} filename.csv"
end

