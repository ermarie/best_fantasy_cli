class Scraper
  
  def self.scrape_page(page_url)
    book_arr = []
    doc = Nokogiri::HTML(open_uri(page_url))
    binding.pry
    doc.css("div.pagecontent").each do |book|
      book = {
        :num => book.css("span.recno").text, 
        :name => book.css("div.pagehd_text.h1").text, 
        :author => book.css("span.a.first").text.gsub("(","").gsub(")",""),
        #:description => get_description
        :book_link => book.css("div.varousel_content.a").attribute('href').value
      }
      book_arr << book 
    end
    book_arr
  end
  

  
  
end