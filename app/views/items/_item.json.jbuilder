json.extract! item, :id, :name, :description, :unit_price, :precision, :merchant_id, :created_at, :updated_at
json.url item_url(item, format: :json)
