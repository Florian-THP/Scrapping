def darktrader 
require 'bundler/setup'
require 'nokogiri'
require 'open-uri'

url = "https://coinmarketcap.com/all/views/all/" #URL du site a Scrapper

begin
  page = Nokogiri::HTML(URI.open(url))


  name_crypto = page.xpath('//a[@class="cmc-table__column-name--name cmc-link"]') #Recupere tout les lien avec la bonne Class
  price_crypto = page.xpath('//div[contains(@class, "sc-b3fc6b7-0 dzgUIj")]//span')  #Recupere tout les Span qui sont dans les div avec la class
   
  tab_name = [] #Nouveau Tableau
  tab_price = [] #Nouveau Tableau
  tab_final = []

  name_crypto.each do |name| #met dans le tableau "tab_name" tout les nom des crypto
    tab_name << name.text #Ajoute au tableau tab_name le Nom de la crypto
  end

  price_crypto.each do |price| #met dans le tableau "tab_price" tout les prix des crypto
    tab_price << price.text #Ajoute au tableau tab_price le prix de la crypto
  end

  

  tab_name.each.with_index do |name, index|  
    my_hash = Hash.new #Declare un nouveau Hash
    my_hash[name] = tab_price[index]  #Insere dans le Hash le nom et le prix de tab_price

    tab_final << my_hash
  end

 tab_final



 

rescue OpenURI::HTTPError => e #Verifie les erreur  OpenURI et HTTPError
  puts "Une erreur HTTP est survenue : #{e.message}"
rescue => e
  puts "Une erreur est survenue : #{e.message}"
end



end