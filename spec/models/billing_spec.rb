require 'rails_helper'

RSpec.describe Billing, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:booking) }
    it { should belong_to(:quotation) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:booking) }
    it { should validate_presence_of(:quotation) }

    it { should validate_numericality_of(:total_amount).allow_nil }
    it { should validate_numericality_of(:ex_rate).allow_nil }
    it { should validate_inclusion_of(:status).in_array(%w(Draft Sent Paid)) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(FactoryBot.build(:billing)).to be_valid
    end
  end
end
