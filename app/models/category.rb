class Category < ApplicationRecord

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  enum status: {
    active: 0,
    inactive: 1
  }
  
end
