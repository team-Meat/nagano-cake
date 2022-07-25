class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        customers_id_path
    end


    def after_sign_out_path_for(resource)
        public_homes_top_path
    end
    
    # :configure_parmitted_parameters, if: :devise_controller?

  protected

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email, :last_name]) # 注目
    end

end


