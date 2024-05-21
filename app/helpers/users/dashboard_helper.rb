module Users::DashboardHelper
  def badge_for(user)
    content_tag :span, class: "badge", style: "background-color: #769FCD" do
      user.manager? ? 'Manager' : 'User'
    end
  end
end
