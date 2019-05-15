class CLI 

  attr_reader :input
  
  def run 

    
    puts "Welcome to the Best Young Adult Fantasy Books!"
    puts "To view the list of the Best Young Adult Fantasy Books enter" + " 'list books'".colorize(:green)
    puts "To quit, enter" + " 'exit'".colorize(:green)
    puts 'What would you like to do?'

    get_input
    
    if @input == "list books\n"
      if Book.all == []
        puts "Loading...".colorize(:red) + "this may take a few moments.".colorize(:light_blue)
        Scraper.scrape_page
      end
      list_books
    elsif @input == "exit\n"
      puts "Thank you for joining us!"
    else
      puts "Sorry, that command is not recognized. Please try again"
    end
  end
  
  def list_books
    Book.all.each { |book| puts "#{book.num}. ".colorize(:red) + "#{book.name} ".colorize(:blue) + "by #{book.author}"}
    puts "----------------------".colorize(:green)
    puts "Please enter a " + "book number".colorize(:green) + " for further information on that book."
    puts "Or enter " + "'exit'".colorize(:green) + " to exit."

    get_input
    find_book
  end
  
  def get_input
    @input = gets
  end
  
  def find_book
    list_length = Book.all.last.num.to_i
    
    if input < (list_length + 1) && input > 0
      
      book = Book.all.find { |book| book.num == @input }
      
      puts "#{book.num}. ".colorize(:red) + "#{book.name} ".colorize(:blue) + "by #{book.author}\n"
      puts "----------------------\n".colorize(:green)
      puts "#{book.rating}".colorize(:yellow)
      puts "#{book.list_ranking}\n".colorize(:red)
      puts "----------------------\n".colorize(:green)
      puts "#{book.description}\n"
      puts "----------------------\n".colorize(:green)
      puts "To view the list again, please enter " + " 'list books'".colorize(:green)
      puts "Or enter " + "'exit'".colorize(:green) + " to exit."
      
      get_input

      end
      
    elsif input > (list_length + 1) || input < 0
      puts "That number is not recognized. Please pick a number " + "between 1 and #{list_length}".colorize(:green) + "."
      get_input
      find_book
    else
      puts "Please enter " + "numbers between 1 and #{list_length}".colorize(:green) + " only."
      get_input
      find_book
    end
  end
  
  
end