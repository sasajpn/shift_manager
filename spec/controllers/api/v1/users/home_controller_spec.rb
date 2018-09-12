require 'rails_helper'

RSpec.describe Api::V1::Users::HomeController, type: :controller do
  login_user

  describe 'GET #index' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :index
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      it '200が返ってくる' do
        get :index
        expect(response).to be_success
        expect(response.status).to eq 200
      end
    end
  end
end
