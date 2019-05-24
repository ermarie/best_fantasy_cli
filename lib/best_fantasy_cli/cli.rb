
class CLI 
  
#run at beginning of program
  def run 
    main_menu
  end
  
## section of menus for the CLI

#initial menu 
  def main_menu
    puts "\n\nWelcome to the Best Fantasy Books for Women!".colorize(:blue)
    puts "To view the list enter" + " 'list books'".colorize(:green)
    puts "To quit, enter" + " 'exit'".colorize(:green)
    puts "What would you like to do?\n".colorize(:yellow)
    puts "----------------------".colorize(:green)
    
    get_input
    main_reply
  end
  
  def main_reply
    if @input == "exit"
      exit_cli
    elsif @input == "list books"
       #scrape website for book list if it has not already been done
      if Book.all == []
        puts "Loading...".colorize(:red) + "this may take a few moments.".colorize(:light_blue)
        Scraper.scrape_page
        @total = Book.all.length
      end
      #display list of books
      list_books
    else
      puts "Sorry, that command is not recognized. Please try again."
      get_input
      main_reply
    end
  end
  
  #method for getting the user input
  def get_input
    @input = gets.strip.downcase
  end
  
  def exit_cli
    puts "-\n-\n-\n".colorize(:green) + "Thank you".colorize(:red) + " for ".colorize(:blue) + "joining us!".colorize(:yellow)
    puts "\n----------------------".colorize(:green)
  end
  
#menu after a list of books are displayed
  def list_menu
    puts "----------------------".colorize(:green)
    puts "Please enter a " + "book number".colorize(:green) + " for further information on that book."
    puts "Or enter " + "'exit'".colorize(:green) + " to exit."
    puts "\n----------------------".colorize(:green)

    get_input
    list_reply
  end
  
  def list_reply
    input = @input.to_i
    
    #ensure number entered is a vlid number from the book list
    if input < @total && input > 0
      #find book object
      book = Book.all.find { |book| book.num == input }
      #if found book does not have full details, scrape the website for that book
      if book.rating == nil 
        Scraper.scrape_book_page(book)
      end
      
    list_books(book)
      
    elsif input > @total || input < 0
      puts "That number is not recognized. Please pick a number " + "between 1 and #{@total}".colorize(:green) + "."
      get_input
      list_reply
    elsif @input == "exit"
      exit_cli
    else
      puts "Please enter " + "numbers between 1 and #{@total}".colorize(:green) + " only."
      get_input
      list_reply
    end
  end
  
#menu after the full information about a book is displayed
  def book_menu(book=nil)
    puts "\n----------------------".colorize(:green)
    puts "\nTo view books other readers also liked, please enter " + "'list books'".colorize(:green) + "."
    puts "To return to the main menu, please enter " + " 'main menu'".colorize(:green)
    puts "Or enter " + "'exit'".colorize(:green) + " to exit."
    puts "----------------------".colorize(:green)

    get_input

    book_reply(book.also_liked_books)
  end
  
  def book_reply(also_liked_books)
    if @input == "list books"
      list_books(also_liked_books)
    elsif @input == "main menu"
      main_menu
    elsif @input == "exit"
      exit_cli
    else
      puts "Sorry, that command is not recognized. Please try again."
      get_input
      book_reply(also_liked_books)
    end
  end
  
#menu displayed after the list of also liked books is displayed
  def also_liked_menu(also_liked_array)
    puts "\n----------------------".colorize(:green)
    puts "\nTo view information about one of the also liked books, enter the " + "'book number'".colorize(:green) + "."
   # puts "\nTo return to the book information, enter " + "'book info'".colorize(:green) + "."
    puts "To return to the main menu, please enter " + " 'main menu'".colorize(:green)
    puts "Or enter " + "'exit'".colorize(:green) + " to exit."
    puts "\n----------------------".colorize(:green)
    
    get_input
    also_liked_reply(also_liked_array)
  end
  
  def also_liked_reply(also_liked_array)
    input = @input.to_i
    book = also_liked_array[input - 1]
    if @input == "exit"
      exit_cli
    elsif @input == "main menu"
      main_menu
    elsif input > 0 && input < 7
      if book.rating == nil 
        Scraper.scrape_book_page(book)
      end
      list_books(book)
    elsif input > @total || input < 0
      puts "That number is not recognized. Please pick a number " + "between 1 and #{@total}".colorize(:green) + "."
      get_input
      also_liked_reply(book)
    else
      puts "Please enter " + "numbers between 1 and #{@total}".colorize(:green) + " only."
      get_input
      also_liked_reply(book)
    end
  end
   
#method used to display books, whether list of best books, also liked books, or book descriptions
  def list_books(book=nil)
    #if no book argument was handed in, display list of best books
    if book == nil
      Book.all.each do |book| 
        if book.num != nil
          puts "#{book.num}. ".colorize(:red) + "#{book.name} ".colorize(:blue) + "by #{book.author}"
        end
      end
      list_menu
    #if book argument handed in is an array, display also-liked books
    elsif book.is_a? Array
      order = 0
      
      book.each do |liked_book| 
        order += 1
        puts "#{order}. ".colorize(:red) + "#{liked_book.name} ".colorize(:blue) + "by #{liked_book.author}"
      end

      also_liked_menu(book)
    #display book details
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
  
end