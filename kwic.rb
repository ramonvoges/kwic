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
    puts "You are looking for '#{@keyword}' in #{ARGV.length} file(s)."
    puts
    ARGF.each do |line|
      @lines << line.split
    end
  end

  def split_lines_into_words
    # @lines.each { |line| @wordlist << line.split }
    @wordlist = @lines.flatten
  end

  def search_keyword
    @wordlist.each_index { |i| @index << i if @wordlist[i].match(@keyword) }
  end

  def print_keywords_in_context
    @index.each do |i|
      printf '# %*d: ', number_length, i + 1
      if i <= 4
        start = 4 - i
        printf '%*s', width_text_snippet, @wordlist[start, start + i].join(' ')
      else
        printf '%*s', width_text_snippet, @wordlist[i - 4, 4].join(' ')
      end
      printf '  %s  ', @wordlist[i]
      printf "%-*s\n", width_text_snippet, @wordlist[i + 1, 4].join(' ')
    end
  end

  private

  def number_length
    @wordlist.length.to_s.length
  end

  def width_text_snippet
    (80 - @keyword.length - number_length) / 2
  end
end

ngram = Kwic.new
ngram.read_file
ngram.split_lines_into_words
ngram.search_keyword
ngram.print_keywords_in_context
