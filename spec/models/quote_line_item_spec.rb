require 'rails_helper'

RSpec.describe QuoteLineItem, type: :model do
  describe 'associations' do
    it { should belong_to(:quotation) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:quote_line_item) }

    it { should validate_length_of(:description).is_at_most(255) }
    it { should validate_length_of(:currency).is_equal_to(3) }
    it { should validate_inclusion_of(:currency).in_array(QuoteLineItem::ISO_CURRENCIES) }
    it { should validate_numericality_of(:cost).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
    it { should validate_length_of(:frequency).is_at_most(50) }
  end
end
