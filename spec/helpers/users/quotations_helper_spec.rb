require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the Users::QuotationsHelper. For example:
#
# describe Users::QuotationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe Users::QuotationsHelper, type: :helper do
  describe "#headers_for" do
    it "returns a nested span within a div parent" do
      expect(helper.headers_for(one: 1, two: 2, three: 3)).to include "one", "two", "three", "col-1", "col-2", "col-3"
    end
  end

  describe "#field_title" do
    it "Wraps the string in span with lead class" do
      expect(helper.field_title("Test")).to eq '<span class="lead">Test</span>'
    end
  end
end
