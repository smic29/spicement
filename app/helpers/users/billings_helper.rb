module Users::BillingsHelper
  def convert_to_words(num)

    whole_num_part = num.to_i
    decimal_part = num.frac

    fraction = decimal_part.to_f.rationalize

    whole_number_words = I18n.with_locale(:en) { whole_num_part.to_words hundreds_with_union: true }

    numerator = fraction.numerator
    denominator = fraction.denominator
    fraction_words = "#{numerator}/#{denominator}"

    result = "#{whole_number_words} and #{fraction_words} pesos only"

    if numerator == 0
      result = "#{whole_number_words} pesos only"
    end

    return result.upcase
  end
end
