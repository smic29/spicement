require 'rails_helper'

RSpec.describe "Users::Profiles", type: :request do
  describe "Paths" do
    context "when a user is not logged in" do
      it "returns a 404 response" do
        get users_profile_path
        expect(response.status).to eq 404

        get users_profile_edit_path
        expect(response.status).to eq 404

        patch users_profile_path
        expect(response.status).to eq 404
      end
    end
  end

  let(:company) { create(:company) }
  let(:user) { create(:user, company_id: company.id) }

  describe "GET /users/profile" do

    it "shows logged-in user's details" do
      sign_in user
      get users_profile_path

      expect(response.status).to eq 200
      expect(response.body).to include user.email
      expect(response.body).to include user.first_name
      expect(response.body).to include user.last_name
    end
  end

  describe "GET users/profile/edit" do
    it "shows and allows for editing user details" do
      sign_in user
      get users_profile_edit_path

      expect(response.status).to eq 200
      expect(response.body).to include user.first_name
      expect(response.body).to include user.last_name
      expect(response.body).to include '<input type="submit" name="commit" value="Save" class="btn btn-outline-success" data-disable-with="Save" />'
      expect(response.body).not_to include user.email
    end
  end

  describe "PATCH users/profile" do
    let(:valid_attributes) { { first_name: "John", last_name: "Doe" } }

    before do
      sign_in user
    end

    it "updates the user and redirects to the profile page" do
      patch users_profile_path, params: { user: valid_attributes }
      user.reload

      expect(user.first_name).to eq "John"
      expect(user.last_name).to eq "Doe"
      expect(response).to redirect_to users_profile_path
    end
  end
end
