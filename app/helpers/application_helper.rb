module ApplicationHelper
  def number_to_currency_php(number, options = {})
    options[:unit] ||= '₱'
    options[:separator] ||= '.'
    options[:delimiter] ||= ','
    number_to_currency number, options
  end
end
