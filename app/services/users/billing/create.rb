class Users::Billing::Create
  def initialize(user)
    @user = user
  end

  def create_billing(params)
    process_line_items(params)

    billing = @user.billings.create(params)

    return billing
  end

  def update_billing(params, billing)
    process_line_items(params)
    process_deleted_line_items(params, billing)

    return params
  end

  private

  def process_deleted_line_items(params, billing)
    bli_params = params[:billing_line_items_attributes]
    bli_index = bli_params.keys.length
    id_array = []
    existing_blis = billing.billing_line_items

    existing_blis.each do |bli|
      id_array << bli.id
    end

    bli_params.each do |k,v|
      next if v[:id].nil?
      id = v[:id].to_i

      id_array.delete(id) if id_array.include? id
    end

    id_array.each do |id|
      params[:billing_line_items_attributes][bli_index.to_s] = { id: id, _destroy: 1 }
      bli_index += 1
    end unless id_array.empty?

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
