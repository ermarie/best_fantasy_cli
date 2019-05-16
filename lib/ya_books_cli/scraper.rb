 class Scraper
  
  def self.scrape_page

    doc = Nokogiri::HTML(open("http://bestfantasybooks.com/lists/list/Crowd/Best-Fantasy-Books-for-Women"))

    self.get_attributes_and_create(doc)
    
    # page = 1 
    # 5.times do
    #   page += 1
    #   doc = Nokogiri::HTML(open("http://bestfantasybooks.com/lists/list/Crowd/Best-Fantasy-Books-for-Women/page-#{page}"))
    #   get_attributes_and_create(doc)
    # end
  end
  
  def self.get_attributes_and_create(doc)
    book_array = []
        
    doc.css("div.list_item").each do |book|

    book = {
    :num => book.css("div.col-sm-3").text.to_i,
    :name => book.css("h2").css("a").text,
    :author => book.css("h3").first.css("a").text,
    :link => "http://bestfantasybooks.com#{book.css("h2").css("a").attribute('href').value}",
    :best => true
    }
    
    book_array << book
    end

    Book.create_from_collection(book_array)
    
  end
  
  def self.scrape_book_page(book)
    doc = Nokogiri::HTML(open(book.link))

    book.rating = doc.css("div.item_rating").text.gsub("\n","")
    book.list_ranking = doc.css("div.item_series").text.gsub("\n","")
    book.votes = doc.css("span.item_voters_icon").text

    if doc.css("div.item_description").text != "\n"
      book.description = doc.css("div.item_description").text.gsub("\n","")
    else
      book.description = "No description available."
    end

    also_liked_array = []
    doc.css("div.also_liked_book").each do |also_liked_book|

      liked_book = {
        :name => also_liked_book.css("div.also_liked_text").css("a").text,
        :author => also_liked_book.css("div.also_liked_author").text,
        :link => "http://bestfantasybooks.com/lists/list/item/#{also_liked_book.css("a").attribute('href').value}",
        :best => false
      }
     
      also_liked_array << Book.find_or_create(liked_book)
    end
    book.also_liked_books = also_liked_array
    book
  end

end