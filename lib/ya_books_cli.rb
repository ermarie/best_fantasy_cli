require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative "./ya_books_cli/cli"
require_relative "./ya_books_cli/version"
require_relative "./ya_books_cli/book"
require_relative "./ya_books_cli/scraper"


module YaBooksCli
  class Error < StandardError; end
  # Your code goes here...
end
