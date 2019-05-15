class CLI 

  attr_reader :input
  
  def run 
    puts "Welcome to the Best Young Adult Fantasy Books!"
    puts "To view the list of the Best Young Adult Fantasy Books enter" + " 'list books'".colorize(:green)
    puts "To quit, enter" + " 'exit'".colorize(:green)
    puts 'What would you like to do?'

    get_input
    input_reply
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
  
  def input_reply
    if @input == "list books\n"
      if Book.all == []
        puts "Loading...".colorize(:red) + "this may take a few moments.".colorize(:light_blue)
        Scraper.scrape_page
      end
      list_books
    elsif @input == "exit\n"
      puts "Thank you for joining us!"
    else
      puts "Sorry, that command is not recognized. Please try again."
      get_input
      input_reply
    end
  end
  
  def find_book
    list_length = Book.all.last.num.to_i
    input = @input.to_i

    if input < (list_length + 1) && input > 0
      
      book = Book.all.find { |book| book.num == input }
      if book.rating == nil
        Scraper.scrape_book_page(book)
      end

      puts "\n#{book.num}. ".colorize(:red) + "#{book.name} ".colorize(:blue) + "by #{book.author}"
      puts "\n----------------------".colorize(:green)
      puts "\n#{book.rating}".colorize(:yellow)
      puts "#{book.list_ranking}".colorize(:red)
      puts "#{book.votes}".colorize(:purple)
      puts "\n----------------------".colorize(:green)
      puts "\n#{book.description}"
      puts "\n----------------------".colorize(:green)
      puts "\nTo view the list again, please enter " + " 'list books'".colorize(:green)
      puts "Or enter " + "'exit'".colorize(:green) + " to exit."
      
      get_input
      input_reply
      
    elsif input > (list_length + 1) || input < 0
      puts "That number is not recognized. Please pick a number " + "between 1 and #{list_length}".colorize(:green) + "."
      get_input
      find_book
    elsif @input == "exit\n"
      puts "Thank you for joining us!"
    else
      puts "Please enter " + "numbers between 1 and #{list_length}".colorize(:green) + " only."
      get_input
      find_book
    end
  end
  
  
end