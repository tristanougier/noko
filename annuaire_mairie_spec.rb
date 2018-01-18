require 'annuaire_mairie'

describe "annuaire des mairies" do 
  
  describe 'get_the_email_of_a_townhal_from_its_webpage' do
    it 'should retrieve the email of a townhall from the webpage' do
      expect(get_the_email_of_a_townhal_from_its_webpage('http://annuaire-des-mairies.com/95/vaureal.html')).to eq('communication@mairie-vaureal.fr')
    end
  end

  describe 'retrive the email of any town in val doise' do
    it 'should retrieve the href of' do
      expect(get_all_the_urls_of_val_doise_townhalls('http://annuaire-des-mairies.com/val-d-oise.html')[0]).to eq('http://annuaire-des-mairies.com/95/ableiges.html')
    end
  end

  describe 'store data in a hash' do
    it 'should the name of the town and email in a hash' do
      expect(towns_hash[:Ableiges]).to eq('mairie.ableiges95@wanadoo.fr')
    end
  end
end

