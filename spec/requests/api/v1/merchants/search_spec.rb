require 'rails_helper'

RSpec.describe 'merchant search controller', type: :request do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:merchant2) { Merchant.create!(name: "Jumpin' Jack's Jams") }
  let!(:merchant3) { Merchant.create!(name: "Bobby's BBQ") }

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

  it 'returns a 400 error if an empty string is input' do
    get api_v1_merchants_find_path, params: { name: ''}

    expect(response.status).to eq(400)
  end

  it 'raises error when there is no match' do
    get api_v1_merchants_find_path, params: { name: '99' }

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:errors]).to eq("Could not find merchant with a name matching 99.")
  end
end
