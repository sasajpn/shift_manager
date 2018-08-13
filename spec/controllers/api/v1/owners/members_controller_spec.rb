require 'rails_helper'

RSpec.describe Api::V1::Owners::MembersController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:other_member) { create(:member) }

  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: member.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのオーナーのチームのものである場合' do
        it '200が返ってくる' do
          get :show, params: { id: member.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'メンバーがログイン済みのオーナーのチームのものでない場合' do
        it '404が返ってくる' do
          get :show, params: { id: other_member.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update, params: { id: member.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのオーナーのチームのものである場合' do
        it 'メンバーの登録内容が更新される' do
          patch :update, params: { id: member.id, member: { role: 'manager' } }
          member.reload
          expect(member.role).to eq 'manager'
        end
        it '200が返ってくる' do
          patch :update, params: { id: member.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'メンバーがログイン済みのオーナーのチームのものでない場合' do
        it 'メンバーの登録内容が更新されない' do
          patch :update, params: { id: other_member.id, member: { role: 'manager' } }
          other_member.reload
          expect(other_member.role).to eq 'part_timer'
        end
        it '404が返ってくる' do
          patch :update, params: { id: other_member.id, member: { role: 'manager' } }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
