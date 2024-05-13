require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'associations' do
    it { should belong_to(:quotation) }
    it { should belong_to(:user) }
    it { should belong_to(:forwarder) }
    it { should have_many(:quote_line_items).through(:quotation) }
    it { should have_many(:billings) }
    it { should delegate_method(:client).to(:quotation) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quotation_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:cost) }
    it { should validate_numericality_of(:receivable) }
    it { should validate_numericality_of(:profit) }
    it { should validate_inclusion_of(:status).in_array(%w(Ongoing Completed Cancelled)) }
  end
end
