require 'rails_helper'

RSpec.describe Api::V1::Users::MembersController, type: :controller do
  login_user

  let!(:member) { create(:member, user: subject.current_user) }
  let!(:other_member) { create(:member) }

  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: member.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのユーザーのものである場合' do
        it '200が返ってくる' do
          get :show, params: { id: member.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'メンバーがログイン済みのユーザーのものでない場合' do
        it '404が返ってくる' do
          get :show, params: { id: other_member.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end

  describe 'PATCH #update' do
    let!(:update_attributes) do
      { calendar_color: '#000000' }
    end
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update, params: { id: member.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのユーザーのものである場合' do
        it 'メンバーの登録内容が更新される' do
          patch :update, params: { id: member.id, member: update_attributes }
          member.reload
          expect(member.calendar_color).to eq '#000000'
        end
        it '200が返ってくる' do
          patch :update, params: { id: member.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'メンバーがログイン済みのユーザーのものでない場合' do
        it 'メンバーの登録内容が更新されない' do
          patch :update, params: { id: other_member.id, member: update_attributes }
          other_member.reload
          expect(other_member.calendar_color).to eq '#FFFFFF'
        end
        it '404が返ってくる' do
          patch :update, params: { id: other_member.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
