require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:company) { create :company }
  let(:user) { create :user }

  describe "GET users/sign_in" do
    context 'when company is approved' do
      it 'returns a succesful response and renders login' do
        company.update(approved: true)

        get new_user_session_path(id: company.id)
        expect(response).to be_successful
        expect(response.body).to include "#{company.name}"
        expect(response.body).to include "Password"
      end
    end

    context 'when company is unapproved' do
      it 'redirects back to initial step of login process' do
        get new_user_session_path(id: company.id)
        expect(response).to redirect_to search_companies_path(fail: company.company_code)
      end
    end
  end

  describe "POST users/sign_in" do
    context "with unapproved company" do
      it "redirects back to the start of the login process" do
        post user_session_path, params: { user: { email: user.email, password: user.password, company_id: user.company_id } }

        expect(response).to redirect_to new_user_session_path(id: user.company_id)
        follow_redirect!
        expect(response).to redirect_to search_companies_path(fail: user.company.company_code)
      end
    end

    context "with valid credentials and company approved" do
      it "authenticates the user and redirects to the after sign-in path" do
        user.company.update(approved: true)
        post user_session_path, params: { user: { email: user.email, password: user.password, company_id: user.company_id } }

        expect(response).to redirect_to root_path
        follow_redirect!

        expect(response.body).to include "Log Out"
      end
    end

    context "with invalid credentials and company approved" do
      it "re-renders the new template with unprocessable_entity status" do
        user.company.update(approved: true)
        post user_session_path, params: { user: { email: user.email, password: 'wrongpass', company_id: user.company_id } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("#{user.company.name}")
      end
    end
  end
end
