require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_the_email_of_a_townhal_from_its_webpage(x)
page = Nokogiri::HTML(open(x))
return page.search('td').map{ |s| s.text.strip.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8').gsub(/dr/i,'med') }.map{ |x| x if /@/ =~ x  }.join()
end

def get_all_the_urls_of_val_doise_townhalls()
page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
return page.search('a').map{ |s| s.text.strip }[8..-2].map{|x| "http://annuaire-des-mairies.com/95/" + x.downcase.tr(" ","-").to_s}
end

def perform()
list_of_emails = []
for i in get_all_the_urls_of_val_doise_townhalls()
  list_of_emails.push(get_the_email_of_a_townhal_from_its_webpage(i))
end
my_hash = Hash[Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html")).search('a').map{ |s| s.text.strip }[8..-2].zip list_of_emails]
puts my_hash
end

perform()
