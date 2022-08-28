class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def self.find_by_input(type = "id", input)
    return find(input) if type == "id"
    return where("name ILIKE ?", "%#{input}%").order(name: :asc).first if type == "name"
  end

  def self.find_all_by_input(type = "id", input)
    where("name ILIKE ?", "%#{input}%").order(name: :asc) if type == "name"
  end
end
