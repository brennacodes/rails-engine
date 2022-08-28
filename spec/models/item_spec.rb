require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:item1) { Item.create!(name: "Dip", description: "Hot", unit_price: 3.99, merchant_id: merchant1.id) }
  let!(:item2) { Item.create!(name: "Burger", description: "Yummy", unit_price: 10.99, merchant_id: merchant1.id) }
  let!(:item3) { Item.create!(name: "Bundle of hay", description: "Yowzas!", unit_price: 29.50, merchant_id: merchant1.id) }
  let!(:customer1) { Customer.create!(first_name: "Bob", last_name: "Bobberson") }
  let!(:invoice1) { Invoice.create!(status: 0, merchant_id: merchant1.id, customer_id: customer1.id) }
  let!(:invoice2) { Invoice.create!(status: 0, merchant_id: merchant1.id, customer_id: customer1.id) }
  let!(:invoice_item1) { InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 1, unit_price: 10.00) }
  
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:merchant_id) }
  end

  describe 'class methods' do
    it 'can find an item by user input' do
      expect(Item.find_by_input(item1.id)).to eq(item1)
      expect(Item.find_by_input("merchant_id", merchant1.id)).to eq(item1)
      expect(Item.find_by_input("name", item1.name)).to eq(item1)
      expect(Item.find_by_input("description", item1.description)).to eq(item1)
      expect(Item.find_by_input("unit_price", item1.unit_price)).to eq(item1)
    end

    it 'can find all matching items by user input' do
      expect(Item.find_all_by_input("merchant_id", merchant1.id)).to eq([item1, item2, item3])
      expect(Item.find_all_by_input("name", "Burg")).to eq([item2])
      expect(Item.find_all_by_input("name", "Bu")).to eq([item3, item2])
      expect(Item.find_all_by_input("description", "Yum")).to eq([item2])
      expect(Item.find_all_by_input("description", "Y")).to eq([item3, item2])
      expect(Item.find_all_by_input("unit_price_max", 15.00)).to eq([item1, item2])
      expect(Item.find_all_by_input("unit_price_min", 15.00)).to eq([item3])
    end
  end
end
