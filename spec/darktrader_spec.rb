require_relative '../lib/darkTrader'  
describe 'Crypto Scraper' do
  it 'Valeur' do
    result = darktrader #lance le code pour que le tableau ce remplie
    
    expect(result).to include(
      a_hash_including(
        "Bitcoin" 
      )
    )
   
    expect(result).to include(
      a_hash_including(
        "USDC" 
      )
    )
  end
end