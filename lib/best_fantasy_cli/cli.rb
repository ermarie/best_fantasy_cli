
class CLI 
  
  def run 
    main_menu
    get_input
    input_reply
  end
  
  def main_menu
    puts "\n\nWelcome to the Best Fantasy Books for Women!".colorize(:blue)
    puts "To view the list enter" + " 'list books'".colorize(:green)
    puts "To quit, enter" + " 'exit'".colorize(:green)
    puts "What would you like to do?\n".colorize(:yellow)
    puts "----------------------".colorize(:green)
  end
  
  def get_input
    @input = gets
  end
  
  def input_reply(book=nil)

    if @input == "exit\n"
      puts "-\n-\n-\n".colorize(:green) + "Thank you".colorize(:red) + " for ".colorize(:blue) + "joining us!".colorize(:yellow)
      puts "\n----------------------".colorize(:green)
    elsif @input == "main menu\n"
      main_menu
      get_input
      input_reply
    # elsif @input == "book info\n"
    elsif @input == "list books\n"
      if Book.all == []
        puts "Loading...".colorize(:red) + "this may take a few moments.".colorize(:light_blue)
        Scraper.scrape_page
        @total = Book.all.length
      end
      list_books(book)
    elsif @input.to_i != 0
      find_book(book)
    else
      puts "Sorry, that command is not recognized. Please try again."
      get_input
      input_reply(book)
    end
  end
  
  def list_menu
    puts "----------------------".colorize(:green)
    puts "Please enter a " + "book number".colorize(:green) + " for further information on that book."
    puts "Or enter " + "'exit'".colorize(:green) + " to exit."
    puts "\n----------------------".colorize(:green)

    get_input
    input_reply
  end
  
  def book_menu(book=nil)
    puts "\n----------------------".colorize(:green)
    puts "\nTo view books other readers also liked, please enter " + "'list books'".colorize(:green) + "."
    puts "To return to the main main_menu, please enter " + " 'main menu'".colorize(:green)
    puts "Or enter " + "'exit'".colorize(:green) + " to exit."
    puts "----------------------".colorize(:green)

    get_input

    also_liked = book.also_liked_books
    input_reply(also_liked)
  end
  
  def also_liked_menu(also_liked_array)
    puts "\n----------------------".colorize(:green)
    puts "\nTo view information about one of the also liked books, enter the " + "'book number'".colorize(:green) + "."
   # puts "\nTo return to the book information, enter " + "'book info'".colorize(:green) + "."
    puts "To return to the main main_menu, please enter " + " 'main menu'".colorize(:green)
    puts "Or enter " + "'exit'".colorize(:green) + " to exit."
    puts "\n----------------------".colorize(:green)
    
    get_input
    
    input = @input.to_i
    if input > 0
      input_reply(also_liked_array[(input - 1)])
    else
      input_reply
    end
  end
  
  def list_books(book=nil)
    if book == nil
      Book.all.each do |book| 
        if book.num != nil
          puts "#{book.num}. ".colorize(:red) + "#{book.name} ".colorize(:blue) + "by #{book.author}"
        end
      end
      list_menu
    elsif book.is_a? Array
      order = 0
      
      book.each do |liked_book| 
        order += 1
        puts "#{order}. ".colorize(:red) + "#{liked_book.name} ".colorize(:blue) + "by #{liked_book.author}"
      end

      also_liked_menu(book)
    else
      if book.num != nil
        number = "#{book.num}. "
      else
        number = ""
      end

      puts "\n#{number}".colorize(:red) + "#{book.name} ".colorize(:blue) + "by #{book.author}"
      puts "\n----------------------".colorize(:green)
      puts "\n#{book.rating}".colorize(:yellow)
      puts "#{book.list_ranking}".colorize(:light_red)
      puts "#{book.votes}".colorize(:light_blue)
      puts "\n----------------------".colorize(:green)
      puts "\n#{book.description}"

      book_menu(book)
    end
  end
  
  def find_book(book=nil)
    input = @input.to_i

    if input < @total && input > 0

      if book != nil
        new_book = Scraper.scrape_book_page(book)
      else 
          new_book = Book.all.find { |book| book.num == input }
        # else
        #   new_book = book
        # end
        
        if new_book.rating == nil 
          Scraper.scrape_book_page(new_book)
        end
      end

      list_books(new_book)
      
    elsif input > @total || input < 0
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
  
end