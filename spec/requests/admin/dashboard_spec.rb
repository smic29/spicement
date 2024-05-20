require 'rails_helper'

RSpec.describe "Admin::Dashboards", type: :request do
  let(:admin) { create(:user, admin: true) }
  let(:non_admin) { create(:user) }
  let!(:companies) { create_list(:company, 3) }

  describe "GET /admin/dashboard" do
    context "when user is an admin" do

      before do
        admin.company.update(approved: true)
        sign_in admin
        get admin_root_path
      end

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "displays all companies" do
        companies.each do |company|
          expect(response.body).to include company.name
        end
      end
    end

    context "when user is not an admin" do
      before do
        non_admin.company.update(approved: true)
        sign_in non_admin
        get admin_root_path
      end

      it "redirects to the user root path" do
        expect(response.body).not_to include "Admin"
      end
    end

    context "when user is not signed in" do
      it "redirects to the the welcome page" do
        get admin_root_path
        expect(response.body).to include 'Welcome to Spicement'
      end
    end
  end
end
