require 'rails_helper'

RSpec.describe Quotation, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:client) }
    it { should have_many(:quote_line_items) }
    it { should have_many(:billings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:client_id) }
    it { should validate_inclusion_of(:status).in_array(%w(draft approved rejected)) }
    it { should validate_numericality_of(:total_price) }
  end
end
