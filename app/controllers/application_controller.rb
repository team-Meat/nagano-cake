class ApplicationController < ActionController::Base
<<<<<<< HEAD
    def after_sign_in_path_for(resource)
      if current_customer
        flash[:notice] = "ログインに成功しました" 
        root_path
      else
        flash[:notice] = "新規登録完了しました。次は名前の入力が必要です" 
        root_path
      end
    end
=======
#     def after_sign_in_path_for(resource)
#         customers_id_path
#     end


#     def after_sign_out_path_for(resource)
#         public_homes_top_path
#     end


#   protected

#   private

#     def configure_permitted_parameters
#       devise_parameter_sanitizer.permit(:sign_up,keys:[:email]) # 注目
#     end

>>>>>>> origin/develop
end


