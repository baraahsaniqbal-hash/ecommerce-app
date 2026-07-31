class Product < ApplicationRecord
  
  belongs_to :category

  # has_many_attached :images

  enum status: {
    inactive: 0,
    active: 1
  }

  validates :name, presence: true
  validates :sku, presence: true, uniqueness: true

  validates :price,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :stock,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

end