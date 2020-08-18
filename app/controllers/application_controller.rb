# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :postal_code, :address, :introduction])
    end

  private
    def default_url_options
      { locale: I18n.locale }
    end

    def set_locale
      I18n.locale = locale_in_params || I18n.default_locale
    end

    def locale_in_params
      if params[:locale].present?
        params[:locale].to_sym.presence_in(I18n.available_locales)
      else
        nil
      end
    end
end
