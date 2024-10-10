require 'bundler/setup'
require 'nokogiri'
require 'open-uri'

# Fonction pour obtenir les URLs des mairies et les emails
def get_townhall_urls(base_url)
  tab_final = [] 
  begin
    page = Nokogiri::HTML(URI.open(base_url)) # Ouvre la page
    names = page.xpath('//div[@class="directory-block__content-wrap"]//a[@class="directory-block__img-link composite-link"]')

    names.each do |i|
      townhall_url = "https://www.aude.fr" + i['href'] #ajoute au lien de base lurl de chaque mairie
      townhall_name = i.text.strip #recupere que le nom du lien
      email = get_townhall_email(townhall_url) # Appelle la fonction pour obtenir l'email

      #stock les donne dans le tableau
      tab_final << { name: townhall_name, email: email }
    end

  rescue OpenURI::HTTPError => e
    puts "Une erreur HTTP est survenue : #{e.message}"
  rescue => e
    puts "Une erreur est survenue : #{e.message}"
  end

  return tab_final # Retourner le tableau final
end










# Fonction pour obtenir l'email d'une mairie
def get_townhall_email(townhall_url)
  begin
    page = Nokogiri::HTML(URI.open(townhall_url)) 

   
    mail = page.xpath('//p[contains(@class, "infos__item -email")]//a')
    
    #verifie si il existe une adresse mail
    if mail.any?
      return mail.first['href'].sub(/^mailto:/, '') #affiche email sans mailto devant
    else
      return "Aucun email trouvé."
    end

  rescue OpenURI::HTTPError => e # Vérifie les erreurs OpenURI et HTTPError
    puts "Une erreur HTTP est survenue pour #{townhall_url}: #{e.message}"
    return "Erreur de récupération de l'email."
  rescue => e
    puts "Une erreur est survenue pour #{townhall_url}: #{e.message}"
    return "Erreur de récupération de l'email."
  end
end


base_url = "https://www.aude.fr/annuaire-mairies-du-departement"


