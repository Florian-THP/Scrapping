def bonus 
require 'bundler/setup'
require 'nokogiri'
require 'open-uri'

base_url = "https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&lang=fr" # URL du site a scrapper

begin
  number = 0
  tab_final = []

  #####################--Recupere Name et Mail page 1 a page 58--#########################
  (1..58).each do |page_number| # boucle pour les 58 autres pages
    url = base_url + "&debut_deputes=#{number}pagination_deputes"  # Construire l'URL pour chaque page
    page = Nokogiri::HTML(URI.open(url))  # Charger la page HTML

    puts url #Affiche les url au fur et a mesure du scrapping :)
    elements = page.xpath('//ul[@class="no_puce list_ann"]//a[@class="ann_mail"] | //h2[@class="titre_normal"]')
    current_title = nil



   my_hash = Hash.new

    elements.each do |info|
      if info.name == 'h2' # Vérifie si info.name est un <h2>
        # Remplit le hash avec le prénom et le nom
        my_hash["first_name"] = info.text.split(" ")[0] #recuper seulement le premier mot qui contient le prenom et linsere dans firstname
        my_hash["last_name"] = info.text.split(" ")[1..-1].join(" ")#recupere tout apres le prenom qui contient le nom et linsere dans last_name
        my_hash["email"] = nil #Creer email vide
      elsif info.name == 'a' # Vérifie si info.name est un lien <a>
        # Remplit le hash avec l'email
        my_hash["email"] = info['href'].sub(/^mailto:/, '') #.sub(/^mailto:/, '') merci Chat GPT :) pour pourvoir enlever le mot mailto devant ladresse 
        
        # Ajouter le hash à tab_final seulement après avoir obtenu l'email
        tab_final << my_hash.clone # Clone le hash pour ajouter une nouvelle entrée
        my_hash.clear # Réinitialise le hash pour la prochaine entrée
      end
    end
    number += 10  # Augmente la pagination a chaque tour de each
  end
 
  
  # afficher le resultat final
 tab_final

rescue OpenURI::HTTPError => e # Verifie les erreurs OpenURI et HTTPError
  puts "Une erreur HTTP est survenue : #{e.message}"
rescue => e #renvoie les erreur de begin
  puts "Une erreur est survenue : #{e.message}"
end

end

