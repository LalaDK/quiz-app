class AdminApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_out_path_for(resource_or_scope)
    head :ok
    return
  end
end
