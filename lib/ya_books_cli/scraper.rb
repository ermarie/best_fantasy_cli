class Scraper
  
  def self.scrape_page(page_url)
    book_arr = []
    doc = Nokogiri::HTML(open_uri(page_url))
    doc.css("div.pagecontent").each do |book|
      book = {
        :num => book.css("span.recno").text 
        :name => book.css("div.pagehd_text.h1").text 
        :author => book.css("span.a.first").text.gsub("(","").gsub(")","")

      }
      
    end
  end
  

  
  
end