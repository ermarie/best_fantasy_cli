class Scraper
  
  def self.scrape_page
    book_array = []
    doc = Nokogiri::HTML(open("http://bestfantasybooks.com/lists/list/Crowd/Best-Fantasy-Books-for-Women"))
    num = 0
    doc.css("div.list_item").each do |book|
    num += 1

    book = {
    :num => num,
    :name => book.css("h2").css("a").text,
    :author => book.css("h3").first.css("a").text,
    :link => "http://bestfantasybooks.com#{book.css("h2").css("a").attribute('href').value}"
    }

    book_array << book
    end

    Book.create_from_collection(book_array)
  end
  
  def self.scrape_book_page(book)
    doc = Nokogiri::HTML(open(book.link))

    book.rating = doc.css("div.item_rating").text
    book.list_ranking = doc.css("div.item_series").text
    book.description = doc.css("div.item_description").text

    also_liked_array = []
    doc.css("div.also_liked_book").each do |also_liked_book|

    book = {
      :name => also_liked_book.css("div.also_liked_text").css("a").text,
      :author => also_liked_book.css("div.also_liked_author").text
     }
   end

end