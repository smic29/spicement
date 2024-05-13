require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'associations' do
    it { should have_many(:users) }
    it { should have_many(:clients).through(:users) }
    it { should have_many(:forwarders).through(:users) }
    it { should have_many(:quotations).through(:users) }
    it { should have_many(:bookings).through(:users) }
    it { should have_many(:billings).through(:users) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it "ensures approved is not present on creation" do
      company = FactoryBot.build(:company, approved: true)
      expect(company).to be_invalid
      expect(company.errors[:approved]).to include("should not be present on creations")
    end
  end

  describe 'callbacks' do
    describe '#generate_company_code' do
      let(:company) { create(:company, name: 'Example Company') }

      it 'generates a company code before creation' do
        expect(company.company_code).not_to be_nil
      end

      it 'generates a company code with correct format' do
        expect(company.company_code).to match(/[A-Z]{4}\h{2}/)
      end
    end
  end
end
