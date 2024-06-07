class Users::Billing::Create
  def initialize(user)
    @user = user
  end

  def create_billing(params)
    process_line_items(params)

    billing = @user.billings.create(params)

    return billing
  end

  def process_line_items(params)
    line_items = params[:billing_line_items_attributes]
    exchange_rate = params[:ex_rate].to_f
    sub_total = 0

    line_items.each do |k,v|
      line_total = v[:cost].to_f * v[:quantity].to_f
      real_total = v[:currency] == 'PHP' ? line_total : line_total * exchange_rate
      params_total = v[:total].to_f

      unless real_total == params_total
        params[:billing_line_items_attributes][k][:total] = real_total
      end

      sub_total += real_total
    end

    params[:total_amount] = sub_total
  end
end
