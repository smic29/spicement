require 'rails_helper'

RSpec.describe "Admin::Companies", type: :request do
  let(:admin) { create(:user, admin: true) }
  let(:non_admin) { create(:user) }
  let!(:approved_company) { create(:company) }
  let!(:unapproved_companies) { create_list(:company, 3) }
  let(:company) { unapproved_companies.first }

  describe "GET /admin/companies" do
    context "when user is an admin" do
      before do
        admin.company.update(approved: true)
        sign_in admin
        get admin_companies_path
      end

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "assigns unapproved companies to @companies" do
        unapproved_companies.each do |company|
          expect(response.body).to include(company.name)
        end
      end
    end

    context "when user is not an admin" do
      before do
        non_admin.company.update(approved: true)
        sign_in non_admin
        get admin_companies_path
      end

      it "redirects to the root path" do
        expect(response).to redirect_to root_path
      end

      it "sets a flash alert message" do
        expect(flash[:alert]).to eq "You are not authorized to access this page."
      end
    end

    context "when user is not signed in" do
      before do
        get admin_companies_path
      end

      it "returns an unsuccessful response" do
        expect(response).not_to be_successful
      end
    end
  end

  # This is for implementation, the show action has no associated view yet.
  # describe "GET /admin/companies/:id" do
  #   context "when user is an admin" do
  #     before do
  #       admin.company.update(approved: true)
  #       sign_in admin
  #       get admin_company_path(company)
  #     end
  #   end
  # end

  describe "PATCH /admin/companies/:id" do
    context "when user is an admin" do
      before do
        admin.company.update(approved: true)
        sign_in admin
        patch admin_company_path(company), params: { company: { approved: true } }
      end

      it "approves the company" do
        company.reload
        expect(company.approved).to be_truthy
      end

      it "creates the first user with the company's email" do
        expect(company.users.first.email).to eq company.email
      end

      it "redirects to the root path with a success notice" do
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eq "Company Approved. User Created. Email Sent"
      end
    end

    context "when user is not an admin" do
      before do
        non_admin.company.update(approved: true)
        sign_in non_admin
        patch admin_company_path(company), params: { company: { approved: true } }
      end

      it "does not approve the company" do
        company.reload
        expect(company.approved).to be_falsey
      end

      it "redirects to the root path" do
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash alert message" do
        expect(flash[:alert]).to eq "You are not authorized to access this page."
      end
    end

    context "when user is not signed in" do
      before do
        patch admin_company_path(company), params: { company: { approved: true } }
      end

      it "does not approve the company" do
        company.reload
        expect(company.approved).to be_falsey
      end

      it "returns an unsuccessful response" do
        expect(response).not_to be_successful
      end
    end
  end
end
