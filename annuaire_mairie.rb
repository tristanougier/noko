require 'nokogiri'
require 'open-uri'
require 'pry'

def get_the_email_of_a_townhal_from_its_webpage(url)
	page = Nokogiri::HTML(open(url))
	email = ""
	#on parcout les sélecteurs p qui ont pour parent un tr et un td et on teste s'ils comprennent un "@"
	page.css('tr td p').each do |selector|
		if selector.text.include? "@"
			email = selector.text
			email.slice!(0)
		end
	end
	return email
end

get_the_email_of_a_townhal_from_its_webpage('http://annuaire-des-mairies.com/95/vaureal.html')

def get_all_the_urls_of_val_doise_townhalls(url)
	names_url_hash = Hash.new
	page = Nokogiri::HTML(open(url))
	#on parcourt tout les éléments de la page qui ont la classe lientxt et on va stocker le nom de la ville associée et l'URL du lien dans un hash
	page.css('a[class=lientxt]').each do |item|
		href = item['href']
		#on cleane le href pour pouvoir le concaténer avec le domaine principal
		2.times do 
			href.slice!(0)
		end
		url = "https://www.annuaire-des-mairies.com/" + href
		#on initialise chaque clé du hash avec le nom de la ville transformé en symbole et qui vaut un array vide (utile si on veut rajouter d'autres types d'infos)
		names_url_hash[item.text.to_sym]=[]
		#on pousse la valeur de l'URL dans l'array
		names_url_hash[item.text.to_sym] << url
	end 
	return names_url_hash
end

def towns_email_index(global_url)
	#on crée un hash avec toutes les villes et leurs url
	town_hash = get_all_the_urls_of_val_doise_townhalls(global_url)
	town_hash.each do |town, city_url|
		#on ajoute l'email comme 2e valeur dans l'array associé à chaque ville
		city_url << get_the_email_of_a_townhal_from_its_webpage(city_url[0])
	end 
	return town_hash
end

puts towns_email_index('http://annuaire-des-mairies.com/val-d-oise.html')