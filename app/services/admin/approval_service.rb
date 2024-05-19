class Admin::ApprovalService
  def initialize(company)
    @company = company
  end

  def call
    Company.transaction do
      approve_company
      create_user
    end
    true
  end

  private

  def approve_company
    @company.update!(approved: true)
  end

  def create_user
    @company.users.create!(email: @company.email, password: '123456', password_confirmation: '123456')
  end
end
