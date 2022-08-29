class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def self.find_by_input(input)
    where("name ILIKE ?", "%#{input}%").order(name: :asc).first
  end

  def self.find_all_by_input(input)
    where("name ILIKE ?", "%#{input}%").order(name: :asc)
  end
end
