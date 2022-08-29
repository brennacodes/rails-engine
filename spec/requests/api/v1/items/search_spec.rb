require 'rails_helper'

RSpec.describe 'item find controller', type: :request do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:item1) { Item.create!(name: "Dip", description: "Hot", unit_price: 3.99, merchant_id: merchant1.id) }
  let!(:item2) { Item.create!(name: "Burger", description: "Yummy", unit_price: 10.99, merchant_id: merchant1.id) }
  let!(:item3) { Item.create!(name: "Bundle of hay", description: "Yowzas!", unit_price: 29.50, merchant_id: merchant1.id) }

  describe 'item search' do
    it 'can return all matches for a search parameter' do
      get api_v1_items_find_all_path, params: { name: 'bu' }

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry 

      expect(items[:data].count).to eq 2
    end

    it 'returns a 400 error if an empty string is input' do
      get api_v1_items_find_all_path, params: { name: '' }

      expect(response.status).to eq(400)
    end
  end

  describe 'item search' do
    xit 'can return a single match for a search parameter' do
      get api_v1_items_find_path, params: { name: 'bu' }

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq 2
    end

    xit 'returns an error if an empty string is input' do
      get api_v1_items_find_path, params: { name: '' }

      expect(response.status).to eq(204)
    end
  end
end
