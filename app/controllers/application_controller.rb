class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
      if current_customer
        flash[:notice] = "ログインに成功しました" 
        root_path
      else
        flash[:notice] = "新規登録完了しました。次は名前の入力が必要です" 
        root_path
      end
    end
end
