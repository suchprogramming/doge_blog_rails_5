module ApplicationHelper
  include FormErrorsHelper
  include TableBuilderHelper

  def safe_user_attrs
    [
      "id",
      "email",
      "created_at",
      "sign_in_count",
      "last_sign_in_at",
      "last_sign_in_ip"
    ]
  end
  
end
