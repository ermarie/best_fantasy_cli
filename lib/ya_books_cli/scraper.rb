class Scraper
  
  def self.scrape_page
    book_array = []
    doc = Nokogiri::HTML(open("http://bestfantasybooks.com/best-young-adult-fantasy-books.html"))
    doc.css("div.pagecontent").each do |book|
      link_div = book.css("div.carousel_content").css("center")
      link = link_div.css("a").attribute('href').value
      book = {
        :num => book.css("span.recno").text, 
        :name => book.css("div.pagehd_text").css("h1").text, 
        :author => book.css("span").css("a").first.text.gsub("(","").gsub(")",""),
        #:description => get_description
        :link => link
      }
      book_array << book 
    end
    Book.create_from_collection(book_array)
  end
  

  
  
end