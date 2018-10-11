require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_the_email_of_a_deputy_from_its_webpage(x)
page = Nokogiri::HTML(open(x))
return puts page.xpath('//a[@class="email"]').map { |link| link['href'] }.to_s[9..-3]
end
#get_the_email_of_a_deputy_from_its_webpage("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA724827")

def get_all_the_urls_of_the_deputy()
page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
return  puts page.xpath('//a').map { |link| "http://www2.assemblee-nationale.fr/deputes" + link['href'] if /fiche/ =~ link['href']}.uniq[1..-1].strip
end
get_all_the_urls_of_the_deputy()

def perform()
list_of_emails = []
my_array = get_all_the_urls_of_the_deputy()
for i in my_array
  puts get_the_email_of_a_deputy_from_its_webpage(i)
end
puts list_of_emails
#my_hash = Hash[Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html")).search('a').map{ |s| s.text.strip }[8..-2].zip list_of_emails]
end

perform()
