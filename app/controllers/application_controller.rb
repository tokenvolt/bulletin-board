class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a? User
      advertisements_path
    else
      super
    end
  end
end
