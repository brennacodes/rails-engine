class Item < ApplicationRecord
  before_destroy :delete_empty_invoices

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id

  def self.find_by_input(type = "id", input)
    return find(input) if type == "id"
    return where(merchant_id: input).order(merchant_id: :asc).first if type == "merchant_id"
    return where("name ILIKE ?", "%#{input}%").order(name: :asc).first if type == "name"
    return where("description ILIKE ?", "%#{input}%").order(description: :asc).first if type == "description"
    return where(unit_price: input).order(unit_price: :asc).first if type == "unit_price"
  end

  def self.find_all_by_input(type = "id", input)
    return find(input) if type == "id"
    return where(merchant_id: input).order(merchant_id: :asc) if type == "merchant_id"
    return where("name ILIKE ?", "%#{input}%").order(name: :asc) if type == "name"
    return where("description ILIKE ?", "%#{input}%").order(description: :asc) if type = "description"
    return where("unit_price < ?", input).order(unit_price: :asc).maximum if type == "unit_price_max"
    return where("unit_price > ?", input).order(unit_price: :asc).minimum if type == "unit_price_min"
  end

  def delete_empty_invoices
    invoices.each do |invoice|
      if invoice.items.count == 1
        InvoiceItem.find_by(id: invoice.id).destroy
        invoice.destroy
      end
    end
  end
end
