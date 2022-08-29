require 'rails_helper'

RSpec.describe 'merchant find controller', type: :request do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:merchant2) { Merchant.create!(name: "Jumpin' Jack's Jams") }
  let!(:merchant3) { Merchant.create!(name: "Bobby's BBQ") }
  
  describe 'merchant search' do
    it 'returns a single merchant that matches search input' do
      get api_v1_merchants_find_path, params: { name: 'Bob' }

      expect(response).to be_successful
      response = JSON.parse(response.body, symbolize_names: true)
      merchant = response[:data].first

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)
      expect(merchant[:id]).to eq(merchant1.id)

      expect(merchant[:attributes]).to have_key(:name)
      epxect(merchant[:attributes][:name]).to be_a(String)
      expect(merchant[:attributes][:name]).to eq("Billy Bob's Burgers")
    end

    it 'raises a 400 error if there are no params' do
      get api_v1_merchants_find_path, params: { name: ''}

      expect(response.status).to eq(400)
    end
  end

  describe 'sad path' do
    it 'raises error when there is no match' do
      get api_v1_merchants_find_path, params: { name: 'X' }

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:errors]).to eq("Could not find merchant that matched with X")
    end
  end
end
