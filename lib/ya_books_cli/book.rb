class Book
  
  @@all = []
  
  attr_accessor :description, :rating, :list_ranking, :votes, :also_liked_books, :best
  attr_reader :num, :name, :author, :link
  
  def initialize(book_hash)
    @num = book_hash[:num]
    @name = book_hash[:name]
    @author = book_hash[:author]
    @link = book_hash[:link]
    @@all << self 
  end
  
  def find_or_create(also_liked_book)
    if Book.all.include? also_liked_book.name
      Book.all.find { |book| book.name == also_liked_book.name }
    else
      Book.new(also_liked_book)
    end
  end
  
  def self.create_from_collection(book_array)
    book_array.each do |book| 
      Book.new(book) 
    end
  end
  
  def self.all 
    @@all 
  end
  
end