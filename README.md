# KeyWords In Context for Ruby

The program expects as a first argument a regex like "n.?vim" and then either one or more files or a stream to search in.

For example:
``` ruby
ruby kwic.rb "n.?vim" file1.txt file2.txt
```

The resulting output consists of a column with the word number, a column with 4 words coming before the keyword, a middle column with the keyword and a column with 4 words coming after the keyword.

```
# 5       In front of the  keyword  this comes after it
```

# Require 'kwic'

The actual class `Kwic` is included in a module with the same name so that it can be required and used in other apps. Creating an instance is straightforward, just pass the keyword as an argument: `ngram = Kwic::Kwic.new(keyword)`. After that take care to import the data to look through, to process it and to output the results. In the program this is done by

```ruby
ngram.read_file
ngram.process
ngram.print_keyword_in_context
ngram.print_summary
```

# Standalone

To use the program on its own, follow these steps:

1. Download it anywhere in your `$PATH`.
2. `mv kwic.rb kwic`
3. `chmod +x kwic.rb`
4. Run it by `kwic keyword file1 file2 file3`

# Licence

See [Licence](Licence.md)
