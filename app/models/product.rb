class Product < ApplicationRecord
  
  belongs_to :category

  has_many_attached :images

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
  
  scope :search, ->(query) {
    if query.present?
          where(
          "products.name ILIKE :query OR products.sku ILIKE :query",
          query: "%#{query.strip}%"
          )
    end
  }

  scope :filter_by_status, ->(status) {
    if status.present?
          where(status: statuses[status])
    end
  }

  scope :filter_by_category, ->(category_id) {
    if category_id.present?
          where(category_id: category_id)
    end
  }

  scope :sorted, ->(sort) {
    case sort
          when "name_asc"
          order(name: :asc)

          when "name_desc"
          order(name: :desc)

          when "price_asc"
          order(price: :asc)

          when "price_desc"
          order(price: :desc)

          when "stock_asc"
          order(stock: :asc)

          when "stock_desc"
          order(stock: :desc)

          when "oldest"
          order(created_at: :asc)

          else
          order(created_at: :desc)
    end
  }

end