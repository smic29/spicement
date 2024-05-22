module Users::ProfileHelper

  def value_if_blank(string)
    string.blank? ? "None" : string
  end
end
