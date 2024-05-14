require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:client).optional }
    it { should belong_to(:forwarder).optional }
  end

  describe 'validations' do
    subject { FactoryBot.build(:person) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).scoped_to(:user_id) }
  end

  describe 'concerns' do
    describe 'Nameable' do
      describe '#full_name' do
        let(:person) { FactoryBot.build(:person, email: Faker::Internet.email, first_name: 'John', last_name: 'Doe') }

        it 'returns the full name of the person' do
          expect(person.full_name).to eq('John Doe')
        end
      end
    end
  end
end
