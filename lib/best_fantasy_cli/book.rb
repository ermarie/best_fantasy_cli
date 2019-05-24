class Book
  
  @@all = []
  
  attr_accessor :description, :rating, :list_ranking, :votes, :also_liked_books, :best
  attr_reader :num, :name, :author, :link
  
#book object initializes with num, name, author & link attributes - added to class' all array
  def initialize(book_hash)
    @num = book_hash[:num]
    @name = book_hash[:name]
    @author = book_hash[:author]
    @link = book_hash[:link]
    @@all << self 
  end
  
#method used to find or create individual book objects - from the also liked books list
  def self.find_or_create(also_liked_book)
    if self.all.include? also_liked_book[:name]
      self.all.find { |book| book.name == also_liked_book[:name] }
    else
      self.new(also_liked_book)
    end
  end
  
#method used to create book objects from the initial pages scraped
  def self.create_from_collection(book_array)
    book_array.each { |book| Book.new(book) }
  end
  
  #display array of all instances of Book class
  def self.all 
    @@all 
  end
  
end