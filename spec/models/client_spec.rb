require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:people) }
    it { should have_many(:bookings).through(:user) }
    it { should have_many(:quotations) }
    it { should have_many(:billings).through(:quotations) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:client) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
  end
end
