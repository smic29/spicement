require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the Users::ProfileHelper. For example:
#
# describe Users::ProfileHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe Users::ProfileHelper, type: :helper do
  describe "#value_if_blank" do
    let(:user) { create(:user, first_name: nil, last_name: nil) }
    let(:user_with_blanks) { create(:user, first_name: " ", last_name: " ")}

    it "returns 'Not set yet' if name is blank or nil" do
      expect(helper.value_if_blank user.first_name).to eq "None"
      expect(helper.value_if_blank user_with_blanks.first_name).to eq "None"
    end
  end
end
