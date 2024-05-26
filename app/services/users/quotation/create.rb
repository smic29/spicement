class Users::Quotation::Create
  def initialize(user)
    @user = user
  end

  def create_quotation(params)
    process_client(params)

    process_quote_line_items(params)

    test_result = @user.quotations.new(params)

    puts test_result.errors.full_messages.empty?
  end

  private

  def process_client(params)
    client_params = params[:client]
    client_params[:name].downcase!
    client_params[:address].downcase!

    client = @user.clients.find_by_name(client_params[:name])

    if client.nil?
      client = @user.clients.create(client_params)
    end

    params.delete(:client)
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
