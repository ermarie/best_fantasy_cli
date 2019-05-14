class Book
  
  @@all = []
  
  attr_reader :num, :name, :author, :link
  
  def initialize(book_hash)
    @num = book_hash[:num]
    @name = book_hash[:name]
    @author = book_hash[:author]
    @link = book_hash[:link]
    @@all << self 
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