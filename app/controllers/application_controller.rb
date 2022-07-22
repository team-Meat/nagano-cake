class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        customers_id_path
    end


    def after_sign_out_path_for(resource)
         public_homes_top_path
    end


  protected

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email]) # 注目
    end

end


