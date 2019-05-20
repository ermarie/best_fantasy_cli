require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'

require_relative "./best_fantasy_cli/cli"
require_relative "./best_fantasy_cli/version"
require_relative "./best_fantasy_cli/book"
require_relative "./best_fantasy_cli/scraper"


module BestFantasyCli
  class Error < StandardError; end
end
