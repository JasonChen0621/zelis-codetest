Written in ruby 3.1.2p20
Names the file from https://codetest.services.mdxdata.com
Prints the content in each file from https://codetest2.services.mdxdata.com

## Dependencies
```bash
gem install httparty
```

## Usage
Using IRB:
```ruby
load CodeTestSolution.rb
Solution1 = Problem1.new
Solution1.solve
# Filename of final path will be printed
Solution2 = Problem2.new
Solution2.solve
# Content of each file will be printed, followed by a list of the paths
```
