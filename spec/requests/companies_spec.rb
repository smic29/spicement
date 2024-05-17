require 'rails_helper'

RSpec.describe "Companies", type: :request do
  let(:company) { create :company }

  describe "GET /companies/new" do
    it "returns http success and contains the correct content" do
      get new_company_path
      expect(response).to have_http_status :success

      expect(response.body).to include "Apply for Company Login"
      expect(response.body).to include "Company Name"
      expect(response.body).to include "Email Address"
    end
  end

  describe "POST /companies" do
    context "with valid parameters" do
      let(:valid_attributes) do
        { company: { name: "New Company", email: "new@example.com" } }
      end

      it "creates a new company and redirects to the success page" do
        post companies_path, params: valid_attributes

        company = Company.last
        expect(company.name).to eq "New Company"
        expect(company.email).to eq "new@example.com"

        expect(response).to redirect_to(success_new_company_path(company.id))
        follow_redirect!

        expect(response.body).to include "Application Successful"
        expect(response.body).to include "#{company.email}"
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) do
        { company: { name: "", email: "invalidemail" } }
      end

      it "does not create a new company and re-renders the new template" do
        post companies_path, params: invalid_attributes

        expect(Company.count).to eq 0

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include "#{invalid_attributes[:company][:email]}"
      end
    end
  end

  describe "GET companies/:id/success" do
    context "with unapproved company status" do
      it "returns a successful response" do
        get success_new_company_path(company)
        expect(response).to be_successful
        expect(response.body).to include company.email
      end
    end

    context "with approved company status" do
      it "redirects to company login process" do
        company.update(approved: true)
        get success_new_company_path(company)
        expect(response).to redirect_to search_companies_path
      end
    end
  end

  describe "GET companies/search" do
    it "returns a successful response" do
      get search_companies_path
      expect(response).to be_successful
      expect(response.body).to include "Enter Company Code"
    end
  end

  describe "POST companies/verify" do
    context "with valid company code" do
      it "redirects to the new user session path" do
        post verify_companies_path, params: { company_code: company.company_code }
        expect(response).to redirect_to new_user_session_path(id: company.id)
      end
    end

    context "with an invalid company code" do
      it "renders the search template with an error status" do
        post verify_companies_path, params: { company_code: "INVALID" }
        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to include "INVALID"
        expect(response.body).to include "Invalid Company Code or Not Approved"
      end
    end
  end

end
