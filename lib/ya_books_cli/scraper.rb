class Scraper
  
  def self.scrape_page
    book_array = []
    doc = Nokogiri::HTML(open("http://bestfantasybooks.com/best-young-adult-fantasy-books.html"))
    doc.css("div.pagecontent").each do |book|
      
      num = book.css("span.recno").text
      if num.include?("0") && num.split("")[0] == "0"
          num = num.split("")[1].to_i
      end

      book = {
        :num => num, 
        :name => book.css("div.pagehd_text").css("h1").text, 
        :author => book.css("span").css("a").first.text.gsub("(","").gsub(")",""),
        #:description => get_description
        :link => book.css("div.carousel_content").css("center").css("a").attribute('href').value
      }
      
      book_array << book 
    end
    
    Book.create_from_collection(book_array)
  end
  

  
  
end