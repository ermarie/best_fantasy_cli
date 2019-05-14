class Scraper
  
  def self.scrape_page(page_url)
    book_array = []
    doc = Nokogiri::HTML(open(page_url))
    doc.css("div.pagecontent").each do |book|
      book = {
        :num => book.css("span.recno").text, 
        :name => book.css("div.pagehd_text.h1").text, 
        :author => book.css("span.a.first").text.gsub("(","").gsub(")",""),
        #:description => get_description
        :link => book.css("div.varousel_content.a").attribute('href').value
      }
      book_array << book 
    end
    Student.create_from_collection(book_array)
  end
  

  
  
end