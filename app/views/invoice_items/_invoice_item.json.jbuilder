json.extract! invoice_item, :id, :item_id, :invoice_id, :quantity, :unit_price, :precision, :created_at, :updated_at
json.url invoice_item_url(invoice_item, format: :json)
