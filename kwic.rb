#!/usr/bin/env ruby

# Returns the 7-gram of a given keyword in the given files.
class Kwic
  def initialize(keyword)
    @index = []
    @keyword ||= keyword
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

  def read_string(text)
    @lines = text.split
  end

  def process
    split_lines_into_words
    search_keyword
    print_keyword_in_context
  end

  def print_keyword_in_context
    @index.each do |i|
      printf '# %*d: ', number_length, i + 1
      if i <= 4
        start = 4 - i
        printf '%*s', width_text_snippet, @wordlist[start, start + i].join(' ')
      else
        printf '%*s', width_text_snippet, @wordlist[i - 4, 4].join(' ')
      end
      # printf '  %s  ', @wordlist[i]
      print "  #{@wordlist[i]}  "
      printf "%-*s\n", width_text_snippet, @wordlist[i + 1, 4].join(' ')
    end
  end

  private

  def split_lines_into_words
    @wordlist = @lines.flatten
  end

  def search_keyword
    @wordlist.each_index { |i| @index << i if @wordlist[i].match(@keyword) }
  end

  def number_length
    @wordlist.length.to_s.length
  end

  def width_text_snippet
    (80 - @keyword.length - number_length) / 2
  end
end

ngram = Kwic.new(ARGV.shift)
ngram.read_file
ngram.process
