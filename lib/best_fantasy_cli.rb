require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'

require_relative "./ya_books_cli/cli"
require_relative "./ya_books_cli/version"
require_relative "./ya_books_cli/book"
require_relative "./ya_books_cli/scraper"


module BestFantasyCli
  class Error < StandardError; end
end
