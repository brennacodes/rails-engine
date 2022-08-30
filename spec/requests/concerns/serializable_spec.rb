require 'rails_helper'

RSpec.describe 'serializable module' do
  include Serializable
  include Statusable

  let!(:merchant1) { Merchant.create!(name: "Billy Bob's Burgers") }


  it 'can serialize a merchant' do
    get api_v1_merchant_path(merchant1.id)
    expect(response).to be_successful
    plain = response.body

    serializer = MerchantSerializer.new(plain)
    serialized = serialize_merchant(response)

    expect(serializer).to eq(serialized)
  end
end

# Returns:
#   The type of attribute that is being searched for.
# def find_type
#   return type = "name" if params[:name]
#   return type = "description" if params[:description]
#   return type = "unit_price" if params[:unit_price]
#   return type = "merchant_id" if params[:merchant_id]
# end