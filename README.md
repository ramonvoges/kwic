# KeyWords In Context for Ruby

The program expects as a first argument a regex like "n.?vim" and then either one or more files or a stream where to look for the regex.

For example:
``` ruby
ruby kwic.rb "n.?vim" file1.txt file2.txt
```

The resulting output consists of a column with the filename, a second with the line number and word number, a third column with 4 words coming before the keyword, a middle column with the keyword and a column with 4 words coming after the keyword.

```
File            |    Line:Word |
test.txt        |       3:   5 |     In front of the  keyword  this comes after it
```

# Require 'kwic'

The actual class `Kwic` is included in a module with the same name so that it can be required and used in other programs. Creating an instance is straightforward, just pass the keyword as an argument: `concordance = Kwic::Kwic.new(keyword)`. After that take care to import the data to look through, to process it and to output the results. In the program this is done by

```ruby
concordance.read_file
# Alternatively, you can use the method `read_string` which takes a string as an argument.
# concordance.read_string(text)
concordance.process
concordance.print_keyword_in_context
concordance.print_summary
```


# Standalone

To use the program on its own on the command line, follow these steps:

1. Download it anywhere in your `$PATH`.
2. `mv kwic.rb kwic`
3. `chmod +x kwic`
4. Run it by `kwic "keyword" file1 file2 file3` or `echo 'This is a test.' | kwic "is" –`

# Licence

See [Licence](Licence.md)
