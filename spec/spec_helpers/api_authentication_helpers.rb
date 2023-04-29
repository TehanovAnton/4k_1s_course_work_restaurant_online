module SpecHelpers
  module ApiAuthenticationHelpers
    def login(user)
      login_path = Rails.application.routes.url_helpers.user_session_path
      headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      params = { email: user.email, password: 'ewqqwe', headers: headers }  
    
      auth_controller = DeviseTokenAuth::SessionsController.new
      old_controller = @controller
    
      @controller = auth_controller
      @request.env["devise.mapping"] = Devise.mappings[:user]
    
      login_response = post(:create, params: params)
    
      @controller = old_controller
    
      login_response
    end
    
    def get_auth_params_from_login_response_headers(response)
      client = response.headers['client']
      token = response.headers['access-token']
      expiry = response.headers['expiry']
      token_type = response.headers['token-type']
      uid = response.headers['uid']
    
      auth_params = {
        'access-token' => token,
        'client' => client,
        'uid' => uid,
        'expiry' => expiry,
        'token-type' => token_type
      }
      auth_params
    end
  end
end
