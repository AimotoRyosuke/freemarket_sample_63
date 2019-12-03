class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    info = User.find_oauth(request.env["omniauth.auth"])
    user = info[:user]
    snsauth = info[:snsauth]
    binding.pry
    if snsauth.blank? && user.blank? #新規登録
      @user = User.new(
        nickname: request.env["omniauth.auth"].info.name,
        email: request.env["omniauth.auth"].info.email,
        password: ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(15).join
      )
      session[:provider] = request.env["omniauth.auth"].provider
      session[:uid] = request.env["omniauth.auth"].uid
      render template: "sign_ups/user_baseinfo", layout: "application_sub"
    else
      if user.present? && snsauth.blank? && user_signed_in? #会員登録済、ログイン済 ※認証追加のため 
        if SnsAuth.create( provider: request.env["omniauth.auth"].provider, uid: request.env["omniauth.auth"].uid, user_id: user.id)
          redirect_to mypage_SNS_path # ※認証追加機能実装まで仮のパス
        else
          render template: "users/SNS" # ※認証追加機能実装までの仮のパス
        end
      elsif user.present? && snsauth.blank?
        render template: "sign_in/signin",layout: "application_sub" # *既に登録されているメールアドレスのためエラー→パスワードとメールアドレスでログインするよう促す。
      elsif user.present? && snsauth.present?
        if sign_in user 
          redirect_to root_path
        else
          render template: "sign_in/signin",layout: "application_sub" # *エラー
        end
      end
    end
  end
end