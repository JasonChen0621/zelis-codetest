require 'httparty'
url = 'https://codetest.services.mdxdata.com'
url2 = 'https://codetest2.services.mdxdata.com'

class CodeTestSolution

  attr_reader :url
  def initialize(url)
    @url = url
  end

  def visit(subdirectory = '', cookie_string = '', redirect = false)
    headers = { 'Cookie' => cookie_string }
    HTTParty.get(url + subdirectory, { headers: headers, follow_redirects: redirect })
  end
  
  def pcookie(res)
    res.headers.to_h['set-cookie'].last.split(';')[0].to_s
  end
  
end

class Problem1 < CodeTestSolution

  def initialize(url = 'https://codetest.services.mdxdata.com')
    @url = url
  end

  def solve
    res = visit('/login', '', false)
    cookie_string = pcookie(res)
    res = visit('', cookie_string, false)
    cookie_string = pcookie(res)
	res = visit('/download', cookie_string, true)
	filename = res.headers.to_s.match('filename=\\\".+\.json\\\"')
  end
end

class Problem2 < CodeTestSolution
  def initialize(url = 'https://codetest2.services.mdxdata.com')
    @url = url
  end
  
  def visit(subdirectory = '', cookie_string = '', redirect = false)
    headers = { 'Cookie' => cookie_string, 'Sec-Fetch-Site' => 'same-origin' }
    HTTParty.get(url + subdirectory, { headers: headers, follow_redirects: redirect })
  end
  
  def solve
    res = visit('', '', false)
	cookie_string = pcookie(res)
    res = visit('/urls', cookie_string, false)
	download_list = res.body.scan(/\/file\/\w+.json/)
	download_list.each { | filepath |
	  # filename = filepath.match('\w+.json').to_s
	  contents = visit(filepath, cookie_string, true)
	  print(contents)
	  # f = File.open(filename, "w")
	  # f.write(contents.body)
	  # f.close
	}
  end
end
