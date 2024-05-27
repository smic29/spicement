class Users::Quotation::Create
  def initialize(user)
    @user = user
  end

  def create_quotation(params)
    # This will use the client_attributes params to check if the current user already has the name of the client.
    # Then it should delete the client_attribute params to prevent it from being saved when the params are back in
    # the controller.
    # It will instead created a new param client_id for the quotation_params.
    # This is done this way since I haven't figured out how to attach the current_user ID while building client_attributes
    process_client(params)

    process_quote_line_items(params)

    quotation = @user.quotations.new(params)

    return quotation
  end

  private

  def process_client(params)
    client_params = params[:client_attributes]
    client_params[:name].downcase!
    client_params[:address].downcase!

    client = @user.clients.find_by_name(client_params[:name])

    if client.nil?
      client = @user.clients.create(client_params)
      params.delete(:client_attributes)

      params[:client_id] = client.id
    end

    params.delete(:client_attributes)
    params[:client_id] = client.id
  end

  def process_quote_line_items(params)
    qli_params = params[:quote_line_items_attributes]
    exchange_rate = params[:exchange_rate].to_f
    running_total = 0

    qli_params.each do |k,v|
      line_total = v[:cost].to_f * v[:quantity].to_f
      true_total = v[:currency] == 'PHP' ? line_total : line_total * exchange_rate.to_f
      params_total = v[:total].to_f

      unless true_total == params_total
        params[:quote_line_items_attributes][k][:total] = true_total
      end

      running_total += true_total
    end

    params[:total_price] = running_total
  end
end
