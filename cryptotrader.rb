require 'nokogiri'
require 'open-uri'
require 'pry'

array_of_prices_hash = []
i = 0

def get_crypto_prices(url)
	prices_hash = Hash.new
	page = Nokogiri::HTML(open(url))
	#on définit une variable rows qui renvoie un array de tous les tr dans tbody
	rows = page.css('tbody tr')
	#on va chercher le prix et le symbole dans chaque ligne
	rows.each do |row|
		#les colonnes sont les sélecteurs td 
		columns = row.css('td')
		#on prend le symbole de la crypto (3e colonne) que l'on transforme en symbole, puis on lui attribue le prix (5e colonne et contenu dans un a)
		prices_hash[columns[2].text.to_sym] = columns[4].css('a').text
	end
	return prices_hash
end

#on ajoute un prices_hash toutes les heures pendant 24h
while i < 23
	#on exécute la méthode get_crypto_prices
	array_of_prices_hash << get_crypto_prices('https://coinmarketcap.com/all/views/all/')
	print array_of_prices_hash
	#on attend une heure
	sleep(3600)
	i += 1
	#on recommence :) 
end

