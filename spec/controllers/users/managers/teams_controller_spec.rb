require 'rails_helper'

RSpec.describe Users::Managers::TeamsController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  describe 'PATCH #update_identifier' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update_identifier, params: { id: team.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'ログイン済みユーザーがマネージャーである場合' do
        let!(:manager) { create(:member, :manager, team: team, user: subject.current_user) }
        it '認証コードが更新される' do
          patch :update_identifier, params: { id: team.id }
          identifier = team.identifier
          team.reload
          expect(team.identifier).not_to eq identifier
        end
        it 'メンバーのshowページにリダイレクトされる' do
          patch :update_identifier, params: { id: team.id }
          expect(response).to redirect_to users_member_url(manager)
        end
      end
      context 'ログイン済みユーザーがマネージャーでない場合' do
        it '認証コードが更新されない' do
          patch :update_identifier, params: { id: team.id }
          identifier = team.identifier
          team.reload
          expect(team.identifier).to eq identifier
        end
        it 'ユーザー用のホーム画面にリダイレクトする' do
          patch :update_identifier, params: { id: team.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context 'ログイン済みユーザーが他チームのマネージャーである場合' do
        let!(:other_manager) { create(:member, :manager, user: subject.current_user) }
        it '認証コードが更新されない' do
          patch :update_identifier, params: { id: team.id }
          identifier = team.identifier
          team.reload
          expect(team.identifier).to eq identifier
        end
        it 'ユーザー用のホーム画面にリダイレクトする' do
          patch :update_identifier, params: { id: team.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end
end
