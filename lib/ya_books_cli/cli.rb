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
    Book.all.each { |book| puts "#{book.num}. #{book.name} by #{book.author}" }
  end
  
  
end