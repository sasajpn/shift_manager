require 'rails_helper'

RSpec.describe Owners::HomeController, type: :controller do
  login_owner

  describe 'GET #index' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :index
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      it 'indexテンプレートがレンダリングされる' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

end
