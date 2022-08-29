require 'rails_helper'

RSpec.describe Merchant, type: :model do
  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }
  let!(:merchant2) { Merchant.create!(name: "Jumpin' Jack's Jams") }
  let!(:merchant3) { Merchant.create!(name: "Bobby's BBQ") }
  
  let!(:item1) { create(:item, merchant_id: merchant1.id) }
  let!(:item2) { create(:item, merchant_id: merchant1.id) }
  let!(:item3) { create(:item, merchant_id: merchant2.id) }
  
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'class methods' do
    it 'can find a merchant by user input' do
      expect(Merchant.find_by_input("Billy Bob's Burgers")).to eq(merchant1)
      expect(Merchant.find_by_input("bill")).to eq(merchant1)
      expect(Merchant.find_by_input("Bob")).to eq(merchant1)
    end

    it 'can find all matching merchants by user input' do
      expect(Merchant.find_all_by_input("Bob")).to eq([merchant1, merchant3])
    end
  end
end
