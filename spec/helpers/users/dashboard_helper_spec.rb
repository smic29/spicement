require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe Users::DashboardHelper, type: :helper do
  describe "badge_for" do
    let(:company) { create(:company) }
    let(:manager) { create(:user, email: company.email, company_id: company.id) }
    let(:user) { create(:user, company_id: company.id) }

    context "when user is a manager" do
      it "creates a span with manager" do
        expect(helper.badge_for(manager)).to include('Manager')
      end
    end

    context "when user is a normal user" do
      it "creates a span with user" do
        expect(helper.badge_for(user)).to include('User')
      end
    end
  end
end
