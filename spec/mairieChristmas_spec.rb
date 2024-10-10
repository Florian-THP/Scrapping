require_relative '../lib/mairieChristmas'  

describe "mairie" do
  it "listmairie" do
    base_url = "https://www.aude.fr/annuaire-mairies-du-departement" #entre URL
    result = get_townhall_urls(base_url) #Remplie le tab_final

    expect(result).to include(
      a_hash_including(
        name: "Mairie Antugnac",
        email: "mairiedantugnac@wanadoo.fr" 
      )
    )

    expect(result).to include(
      a_hash_including(
        name: "Mairie Azille",
        email: "contact@mairie-azille.com" 
      )
    )
  end
end
