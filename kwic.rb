#!/usr/bin/env ruby

# Returns the 7-gram of a given keyword in the given files.
class Kwic
  def initialize
    @index = []
    @keyword = ARGV.shift
    @lines = []
    @wordlist = []
  end

  def read_file
    ARGF.each do |line|
      @lines << line.split
      # puts ARGF.file.lineno
    end
    # print @lines
    # puts @lines.join(' ')
    # puts @keyword
  end

  def split_lines_into_word
    # @lines.each { |line| @wordlist << line.split }
    @wordlist = @lines.flatten
    # print @wordlist
  end

  def search_keyword
    @wordlist.each_index { |i| @index << i if @wordlist[i].match(@keyword) }
    # puts @index
  end

  def print_keywords_in_context
    @index.each { |i| puts "# #{i}: #{@wordlist[i - 5, 11].join(' ')}" }
  end
end

ngram = Kwic.new
ngram.read_file
ngram.split_lines_into_word
ngram.search_keyword
ngram.print_keywords_in_context
