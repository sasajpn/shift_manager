require 'rails_helper'

RSpec.describe Owners::Members::UnapprovalsController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:other_member) { create(:member) }

  describe 'GET #index' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :index, params: { team_id: team.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'チームがログイン済みのオーナーのものである場合' do
        it 'indexテンプレートがレンダリングされる' do
          get :index, params: { team_id: team.id }
          expect(response).to render_template :index
        end
      end
      context 'チームがログイン済みのオーナーのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :index, params: { team_id: other_team.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end

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
      context 'メンバーがログイン済みのオーナーのものである場合' do
        it 'indexテンプレートがレンダリングされる' do
          get :show, params: { id: member.id }
          expect(response).to render_template :show
        end
      end
      context 'メンバーがログイン済みのオーナーのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :show, params: { id: other_member.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :edit, params: { id: member.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのオーナーのものである場合' do
        it 'editテンプレートがレンダリングされる' do
          get :edit, params: { id: member.id }
          expect(response).to render_template :edit
        end
      end
      context 'メンバーがログイン済みのオーナーのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: other_member.id }
          expect(response).to redirect_to owners_home_index_url
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
      context 'メンバーがログイン済みのオーナーのものである場合' do
        it 'メンバーの登録内容が更新される' do
          patch :update, params: { id: member.id, member: { role: 'manager', approve: true } }
          member.reload
          expect(member.role).to eq 'manager'
          expect(member.approve).to eq true
        end
        it 'メンバーのindexページにリダイレクトされる' do
          patch :update, params: { id: member.id }
          expect(response).to redirect_to owners_team_members_url(member.team)
        end
      end
      context 'メンバーがログイン済みのオーナーのものでない場合' do
        it  'メンバーの登録内容が更新されない' do
          patch :update, params: { id: other_member.id, member: { approve: true } }
          other_member.reload
          expect(member.approve).to eq false
        end
        it 'オーナー用のホーム画面にリダイレクトする' do
          patch :update, params: { id: other_member.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        delete :destroy, params: { id: member.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのオーナーのものである場合' do
        it 'メンバーが削除される' do
          expect {
            delete :destroy, params: { id: member.id }
          }.to change(Member, :count).by(-1)
        end
        it 'チームのshowページにリダイレクトされる' do
          delete :destroy, params: { id: member.id }
          expect(response).to redirect_to owners_team_url(member.team)
        end
      end
      context 'メンバーがログイン済みのオーナーのものでない場合' do
        it 'メンバーが削除されない' do
          expect {
            delete :destroy, params: { id: other_member.id }
          }.to change(Member, :count).by(0)
        end
        it 'オーナー用のホーム画面にリダイレクトする' do
          delete :destroy, params: { id: other_member.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end
end
