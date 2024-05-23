require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe "GET /index" do
    context "when a user is not logged in" do
      it "redirects to the landing page" do
        get user_root_path

        expect(response.body).not_to include "users_frame"
      end
    end

    context "when a user is logged in" do
      let(:company) { create(:company) }
      let(:user) { create(:user, company_id: company.id) }

      it "displays the user dashboard" do
        sign_in user
        get user_root_path

        expect(response.body).to include "users_frame"
      end
    end

    context "when user is an admin" do
      let(:company) { create(:company) }
      let(:admin) { create(:user, company_id: company.id, admin: true) }

      it "does not display the user dashboard" do
        sign_in admin
        get user_root_path

        expect(response.body).not_to include "users_frame"
        expect(response.body).to include "admin_frame"
      end

    end
  end

  describe "GET /show" do
    let(:company) { create(:company) }
    let(:user) { create(:user, company_id: company.id) }
    let(:manager) { create(:user, company_id: company.id, email: company.email) }

    context "when a user is logged in" do
      it "displays the current user details" do
        sign_in user
        get users_welcome_path

        expect(response.body).to include "You are viewing this page as a User"
        expect(response.body).to include user.email
        expect(response.body).to include user.full_name
      end
    end

    context "when a manager is logged in" do
      it "displays the manager's details" do
        sign_in manager
        get users_welcome_path

        expect(response.body).to include "You are viewing this page as a Manager"
        expect(response.body).to include manager.email
        expect(response.body).to include manager.full_name
      end
    end

    context "when a user is not logged in" do
      it "returns a 404 response" do
        get users_welcome_path

        expect(response.status).to eq 404
      end
    end
  end
end
