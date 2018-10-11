require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_the_crypto()
  list_of_crypto = []
  list_of_price = []
  my_final_array =[]
  tableau = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")).search('a').map{ |s| s.text.strip}[196..-1]
  puts tableau.length()
for i in 0..tableau.length()
  if i%11 == 0
    list_of_crypto.push(tableau[i])
  end
  if i%11 == 2
    list_of_price.push(tableau[i])
  end
end

for j in 0..list_of_crypto.length()
  my_hash = Hash.new
  my_hash[list_of_crypto[j]] = list_of_price[j]
  my_final_array.push(my_hash)
end
return puts my_final_array[0..-4]
end

get_the_crypto()
