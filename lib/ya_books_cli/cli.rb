class CLI 
  
  def run 
    main_menu
    get_input
    input_reply
  end
  
  def main_menu
    puts "Welcome to the Best Young Adult Fantasy Books!".colorize(:blue)
    puts "To view the list of the Best Young Adult Fantasy Books enter" + " 'list books'".colorize(:green)
    puts "To quit, enter" + " 'exit'".colorize(:green)
    puts 'What would you like to do?'.colorize(:yellow)
  end
  
  def list_menu
    puts "----------------------".colorize(:green)
    puts "Please enter a " + "book number".colorize(:green) + " for further information on that book."
    puts "Or enter " + "'exit'".colorize(:green) + " to exit."

    get_input
    find_book
  end
  
  def book_menu
      puts "\n----------------------".colorize(:green)
      puts "\nTo view books other readers also liked, please enter " + "'list books'".colorize(:green) + "."
      puts "\nTo return to the main main_menu, please enter " + " 'return'".colorize(:green)
      puts "Or enter " + "'exit'".colorize(:green) + " to exit."
  end
  
  def also_liked_menu
    
  end
  
  def list_books(book=nil)
    if book == nil
      Book.all.each { |book| puts "#{book.num}. ".colorize(:red) + "#{book.name} ".colorize(:blue) + "by #{book.author}"}
    elsif book.is_a? Array
      book.also_liked_books.each_with_index { |book| puts "#{index}. ".colorize(:red) + "#{book.name} ".colorize(:blue) + "by #{book.author}"}
    else
      number = "#{book.num}. "
      puts "\n#{number}".colorize(:red) + "#{book.name} ".colorize(:blue) + "by #{book.author}"
      puts "\n----------------------".colorize(:green)
      puts "\n#{book.rating}".colorize(:yellow)
      puts "#{book.list_ranking}".colorize(:light_red)
      puts "#{book.votes}".colorize(:light_blue)
      puts "\n----------------------".colorize(:green)
      puts "\n#{book.description}"
    end
  end
  
  def get_input
    @input = gets
  end
  
  def input_reply(book=nil)
    if @input == "list books\n"
      if Book.all == []
        puts "Loading...".colorize(:red) + "this may take a few moments.".colorize(:light_blue)
        Scraper.scrape_page
        @total = Book.all.length
      end
      list_books
    elsif @input == "exit\n"
      puts "Thank you for joining us!"
    elsif @input == "also liked books\n"
    binding.pry
      book.also_liked_books.each_with_index do |liked_book|
        binding.pry
        puts "#{index + 1}.".colorize(:red) + "#{liked_book.name} ".colorize(:blue) + "by #{liked_book.author}"
      end
    else
      puts "Sorry, that command is not recognized. Please try again."
      get_input
      input_reply
    end
  end
  
  def find_book
    input = @input.to_i

    if input < (@total) && input > 0
      
      book = Book.all.find { |book| book.num == input }
      if book.rating == nil
        Scraper.scrape_book_page(book)
      end
      
      list_books(book)
      book_menu
      get_input
      input_reply(book)
      
    elsif input > (@total) || input < 0
      puts "That number is not recognized. Please pick a number " + "between 1 and #{@total}".colorize(:green) + "."
      get_input
      find_book
    elsif @input == "exit\n"
      puts "Thank you for joining us!"
    else
      puts "Please enter " + "numbers between 1 and #{@total}".colorize(:green) + " only."
      get_input
      find_book
    end
  end
  
  def print_book
    
  end
  
  
end