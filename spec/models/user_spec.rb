require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
    it { should have_many(:clients) }
    it { should have_many(:forwarders) }
    it { should have_many(:quotations) }
    it { should have_many(:bookings) }
    it { should have_many(:billings) }
    it { should have_many(:people) }
  end

  describe 'validations' do
    let!(:company1) { FactoryBot.create(:company) }
    let!(:company2) { FactoryBot.create(:company) }

    let!(:user1) { FactoryBot.create(:user, email: 'test@example.com', company_id: company1.id) }

    context 'when creating a user with the same email but different company_id' do
      let(:user2) { FactoryBot.build(:user, email: 'test@example.com', company_id: company2.id) }

      it 'should validate uniqueness within the scope of company_id' do
        expect(user2).to be_valid
      end
    end

    context 'when creating a user with an already existing email on the same company_id' do
      let(:user4) { FactoryBot.build(:user, email: 'test@example.com', company_id: company1.id) }

      it 'should not be valid' do
        expect(user4).not_to be_valid
        expect(user4.errors[:email]).to include('has already been taken')
      end
    end

    context 'when creating a user with a unique email within the same company' do
      let(:user3) { FactoryBot.build(:user, email: 'another_test@example.com', company_id: company1.id) }

      it 'should be valid' do
        expect(user3).to be_valid
      end
    end
  end

  describe 'concerns' do
    describe 'Nameable' do
      describe '#full_name' do
        let(:user) { FactoryBot.build(:user, first_name: 'John', last_name: 'Doe') }

        it 'returns the full name of the user' do
          expect(user.full_name).to eq('John Doe')
        end
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
