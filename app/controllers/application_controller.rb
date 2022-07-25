class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        root_path
    end

    def after_sign_out_path_for(resource)
        root_path
    end
  #  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  private

    private
     def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys:[:email,:last_name,:first_name,:last_name_kana,:first_name_kana,:postcode,:address,:phone_number]) # 注目
     end

end


