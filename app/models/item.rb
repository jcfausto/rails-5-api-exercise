class Item < ApplicationRecord
  # Model association
  belongs_to :todo

  # validations
  validates_presence_of :name
end
