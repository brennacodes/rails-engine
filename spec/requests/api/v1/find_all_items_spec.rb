require 'rails_helper'

RSpec.describe 'find all items' do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:item1) { Item.create!(name: "Dip", description: "Hot", unit_price: 3.99, merchant_id: merchant1.id) }
  let!(:item2) { Item.create!(name: "Burger", description: "Yummy", unit_price: 10.99, merchant_id: merchant1.id) }
  let!(:item3) { Item.create!(name: "Bundle of hay", description: "Yowzas!", unit_price: 29.50, merchant_id: merchant1.id) }

  it 'returns all items that match a search param' do
    GET api_v1_items_find_all_path, params: { name: 'bu' }

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq 2
  end

  it 'has a sad path' do
    GET api_v1_items_find_all_path, params: { name: '' }

    expect(response.status).to eq(204)
  end
end
