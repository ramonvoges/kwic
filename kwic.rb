#!/usr/bin/env ruby

module Kwic
  # Returns the context of a given keyword in the given files or stream.
  class Kwic
    def initialize(keyword)
      @keyword ||= keyword
      @wordlist = []
      @line_count = 0
      @word_count = 0
      @number_of_hits = 0
    end

    def print_start
      puts "You are looking for '#{@keyword}' in #{ARGV.length} file(s)."
      puts
      printf "%-15s | %7s:%4s |\n", 'File', 'Line', 'Word'
    end

    def read_stream
      @processing_file = ARGF.filename
      ARGF.each do |line|
        process(line)
      end
    end

    def read_string(text)
      text.split(/\n/).each do |line|
        process(line)
      end
    end

    def print_summary
      puts
      puts "The keyword '#{@keyword}' was found #{@number_of_hits} times among #{@word_count} words."
      printf "Its absolute frequency is %.5f.\n", frequency
    end

    private

    def process(line)
      @wordlist = line.split
      # @wordlist.flatten!
      count_lines
      count_words
      search_keyword
      @wordlist.clear
    end

    def count_lines
      if @processing_file == ARGF.filename
        @line_count += 1
      else
        @processing_file = ARGF.filename
        @line_count = 1
      end
    end

    def count_words
      @word_count += @wordlist.length
    end

    def search_keyword
      @wordlist.each_index do |i|
        if @wordlist[i] =~ /#{@keyword}/i
          print_keyword_in_context(i)
          @number_of_hits += 1
        end
      end
    end

    def print_keyword_in_context(i)
      printf '%-15.15s | %7d:%4d |', file_name, @line_count, i + 1
      print_before_keyword(i)
      print "  #{@wordlist[i]}  "
      print_after_keyword(i)
    end

    def file_name
      File.basename(ARGF.filename)
    end

    def print_before_keyword(i)
      if i < 4
        printf '%*s', width_text_snippet, @wordlist[0, i].join(' ')
      else
        printf '%*s', width_text_snippet, @wordlist[i - 4, 4].join(' ')
      end
    end

    def print_after_keyword(i)
      if i + 4 >= @wordlist.length
        last = @wordlist.length - i
        printf "%-*s\n", width_text_snippet, @wordlist[i + 1, last].join(' ')
      else
        printf "%-*s\n", width_text_snippet, @wordlist[i + 1, 4].join(' ')
      end
    end

    def width_text_snippet
      (100 - @keyword.length) / 2
    end

    def frequency
      @number_of_hits.to_f / @word_count.to_f
    end
  end
end

concordance = Kwic::Kwic.new(ARGV.shift)
concordance.print_start
concordance.read_stream
concordance.print_summary

# test = "Das ist ein Neovim\nString, der\n über mehrere Neovim Zeilen\n geht."
# ngram.read_string(test)
