require_relative '../lib/bonus'  
describe "bonus" do
  it "listDepute" do
    result = bonus #lance le code pour remplir le tableau 

    expect(result).to include(
      a_hash_including(
        "first_name" => "Caroline",
        "last_name" => "Yadan",
        "email" => "caroline.yadan@assemblee-nationale.fr" 
      )
    )

    expect(result).to include(
      a_hash_including(
        "first_name" => "Romain",
        "last_name" => "Tonussi",
        "email" => "romain.tonussi@assemblee-nationale.fr" 
      )
    )

    expect(result).to include(
      a_hash_including(
        "first_name" => "Vincent",
        "last_name" => "Descoeur",
        "email" => "contact@descoeur.com" 
      )
    )

    expect(result).not_to include(
      a_hash_including(
        "first_name" => "Florian",
        "last_name" => "Tribout",
        "email" => "Floriantest@gmail.com"
      )
    )
  end
end

