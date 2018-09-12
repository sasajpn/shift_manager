require 'rails_helper'

RSpec.describe Api::V1::Users::Members::UnapprovalsController, type: :controller do
  login_user

  let!(:team) { create(:team, identifier: '000000') }

  describe 'POST #create' do
    let!(:create_attributes) do
      { identifier: '000000', calendar_color: '#FFFFFF' }
    end
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        post :create
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      it '200が返ってくる' do
        post :create, params: { join_team_form: create_attributes }
        expect(response).to be_success
        expect(response.status).to eq 200
      end
    end
  end
end
