 class Scraper
  
#scraping initial pages displaying full list of Best Fantasy Books for Women
  def self.scrape_page
    
    #get HTML from webpage and set to doc variable
    doc = Nokogiri::HTML(open("http://bestfantasybooks.com/lists/list/Crowd/Best-Fantasy-Books-for-Women"))

    self.get_attributes_and_create(doc)
    
    #scrape all the pages of website that display the book list
    page = 1 
    5.times do
      page += 1
      doc = Nokogiri::HTML(open("http://bestfantasybooks.com/lists/list/Crowd/Best-Fantasy-Books-for-Women/page-#{page}"))
      get_attributes_and_create(doc)
    end
  end
  
#gets attributes for each individual book, add to an array for creating book objects from the full collection
  def self.get_attributes_and_create(doc)
    book_array = []
        
    #make array of appropriate HTML elements and interate through array    
    doc.css("div.list_item").each do |book|

    #set book attributes from appropriate HTML elements
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
  
#scraping individual book pages to get further information on the book to display
  def self.scrape_book_page(book)
    
    #get HTML for book's detail page and set to doc variable
    doc = Nokogiri::HTML(open(book.link))

    #set book attributes from appropriate HTMl elements
    book.rating = doc.css("div.item_rating").text.gsub("\n","")
    book.list_ranking = doc.css("div.item_series").text.gsub("\n","")
    book.votes = doc.css("span.item_voters_icon").text

    #handle setting book description attribute whether description is provided or not
    if doc.css("div.item_description").text != "\n"
      book.description = doc.css("div.item_description").text.gsub("\n","")
    else
      book.description = "No description available."
    end

    also_liked_array = []
    
    #create array of also-liked books from appropriate HTML elements and interate through them
    doc.css("div.also_liked_book").each do |also_liked_book|

      #set book attributes from appropriate HTML elements
      liked_book = {
        :name => also_liked_book.css("div.also_liked_text").css("a").text,
        :author => also_liked_book.css("div.also_liked_author").text,
        :link => "http://bestfantasybooks.com/lists/list/item/#{also_liked_book.css("a").attribute('href').value}",
        :best => false
      }
     
      #add instance of book to array
      also_liked_array << Book.find_or_create(liked_book)
    end
    #set also_liked_books attribute to array
    book.also_liked_books = also_liked_array
    book
  end

end