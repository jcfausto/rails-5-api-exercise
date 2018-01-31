require 'rails_helper'

RSpec.describe Item, type: :model do
  # Association test
  it { should belong_to(:todo) }

  # Validation test
  it {should validate_presence_of(:name) }
end
