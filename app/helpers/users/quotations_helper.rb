module Users::QuotationsHelper
  def headers_for(options={})
    options.map do |k,v|
      col_value = v == 0 ? "col" : "col-#{v}"
      content_tag(:div, class: "#{col_value} text-center") do
        content_tag(:span, k, class: "bg-secondary-subtle text-center align-middle rounded-pill p-1 px-4")
      end
    end.join.html_safe
  end

  def field_title(string)
    content_tag :span, string, class: "lead"
  end
end
