class CLI 

  attr_reader :input
  
  def run 
    Scraper.scrape_page
    
    puts "Welcome to the Best Young Adult Fantasy Books!"
    puts "To view the list of the Best Young Adult Fantasy Books enter 'list books'"
    puts "To quit, enter 'exit'"
    puts 'What would you like to do?'

    @input = gets

    if @input == "list books\n"
      list_books
    elsif @input == "exit\n"
      puts "Thank you for joining us!"
    else
      puts "Sorry, that command is not recognized."
    end
  end
  
  def list_books
    Book.all.each { |book| puts "#{book.num}. ".colorize(:red) + "#{book.name} ".colorize(:blue) + "by #{book.author}"}
    puts "----------------------".colorize(:green)
    puts "Please enter a book number for further information on that book."
    puts "Or enter 'exit' to exit."

    get_input

    if @input == "exit\n"
      return puts "Thank you for using our app!"
    else
      @input = @input.to_i
      find_book
    end
  end
  
  def get_input
    @input = gets
  end
  
  def find_book
    list_length = Book.all.last.num.to_i + 1
    
    if input < list_length && input > 0
      book = Book.all.find { |book| book.num == @input }
      puts "#{book.num}. ".colorize(:red) + "#{book.name} ".colorize(:blue) + "by #{book.author}"
    elsif input > list_length || input < 0
      puts "That number is not recognized. Please pick a number between 1 and #{list_length - 1}."
      get_input
      find_book
    else
      puts "Please enter numbers only."
      get_input
      find_book
    end
  end
  
  
end