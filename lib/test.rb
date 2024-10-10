require 'bundler/setup'
require 'nokogiri'
require 'open-uri'

def get_townhall_urls(townhall_url)
  begin
    page = Nokogiri::HTML(URI.open(townhall_url)) # Ouvre la page
    name = page.xpath('//div[@class="directory-block__content-wrap"]//a[@class="directory-block__img-link composite-link"]')

    # Affichez les liens trouvés
    name.each do |i|
      puts i['href'] # Affichez l'attribut href du lien
    end

  rescue OpenURI::HTTPError => e
    puts "Une erreur HTTP est survenue : #{e.message}"
  rescue => e
    puts "Une erreur est survenue : #{e.message}"
  end
end

# Exemple d'appel à la méthode
townhall_url = "https://www.aude.fr/annuaire-mairies-du-departement"
get_townhall_urls(townhall_url)
