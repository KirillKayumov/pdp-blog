class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery

  protected

  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def require_permission
    redirect_to root_path, alert: t('app.messages.access_denied') unless access_allowed?
  end
end
