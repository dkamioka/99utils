require 'nokogiri'
require 'benchmark'
require 'csv'

Benchmark.bm do |x|
  x.report {
    CSV.open("total.csv", "wb") do |csv|
      csv << ["Empresa", "Setor", "Quantidade de Reviews", "Média", "Arquivo"]
      Dir.foreach('.') do |f|
        next if f == "." or f == ".."
        doc = Nokogiri::HTML(File.open(f))
        name = doc.xpath("//section/h1[contains(@itemprop,'name')]").text.to_s
        setor = (doc.xpath("//section[contains(@class,'company-header__text')]/a").first or doc.xpath ).text.to_s
        total_reviews = doc.xpath("//span[contains(@class,'review-total__reviews')]/span[contains(@class,'count')]").text.to_i
        average_score = doc.xpath("//span[contains(@class,'average')]").text.to_f
        file = f.to_s
        csv << [name, setor, total_reviews, average_score, file]
      end
    end
  }
end
