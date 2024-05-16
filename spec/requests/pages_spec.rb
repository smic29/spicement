require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    it 'returns a success response' do
      get root_path
      expect(response).to be_successful
    end
  end

  describe "GET /login_signup" do
    it 'returns a success response' do
      get auth_path
      expect(response).to be_successful
    end
  end
end
