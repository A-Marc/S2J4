require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_the_email_of_a_deputy()
page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600&lang=fr"))
return tableau = page.xpath('//a[@class="ann_mail"]').map { |link| link['href']}.map{|x| x[7..-1] if /@/ =~ x && /nationale/ =~ x && /secretariat/ !~ x }.uniq[2..-1].insert(0, "damien.abad@assemblee-nationale.fr")
end

#get_the_email_of_a_deputy()

def get_name_and_first_name()
page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600&lang=fr"))
return page.search('h2').map{ |s| s.text.strip }[0..-9]
end
#get_name_or_first_name()

def split_name_and_first_name_and_create_hash()
first_name = []
name = []
    for i in get_name_and_first_name()
      integral_name = i.split(" ")
      if integral_name.count == 3
        first_name.push(integral_name[1])
        name.push(integral_name[2])
      end

    if integral_name.count == 4
        first_name.push(integral_name[1])
        name.push(integral_name[2..3].join(" "))
    end

    if integral_name.count == 5
      first_name.push(integral_name[1])
      name.push(integral_name[2..4].join(" "))
end
end

my_final_array = []
tab5 = get_the_email_of_a_deputy()
tab6 = first_name.zip name


for j in 0..575
  my_hash = Hash.new
  my_hash[tab5[j]] = tab6[j]
  my_final_array.push(my_hash)
end
return puts my_final_array
end


split_name_and_first_name_and_create_hash()
