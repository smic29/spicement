require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
    it { should have_many(:clients) }
    it { should have_many(:forwarders) }
    it { should have_many(:quotations) }
    it { should have_many(:bookings) }
    it { should have_many(:billings) }
  end

  describe 'methods' do
    describe '#full_name' do
      let(:user) { FactoryBot.build(:user, first_name: 'John', last_name: 'Doe') }

      it 'returns the full name of the user' do
        expect(user.full_name).to eq('John Doe')
      end
    end
  end

  describe 'creating a user' do
    let(:user) { create(:user) }
    let(:invalid_user) { build(:user, company_id: nil) }

    it 'creates a user with associated company' do
      expect(user).to be_valid
      expect(user.company).to be_present
    end

    it 'has company_id present in the user record' do
      expect(user.company_id).to be_present
    end

    it 'does not allow creation without a company' do
      expect(invalid_user).not_to be_valid
    end
  end
end
