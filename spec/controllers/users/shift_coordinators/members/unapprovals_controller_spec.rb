require 'rails_helper'

RSpec.describe Users::ShiftCoordinators::Members::UnapprovalsController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }

  describe 'GET #index' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :index, params: { team_id: team.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context '自チームのメンバーである場合' do
        context 'マネージャーである場合' do
          let!(:my_member) { create(:member, :manager, team: team, user: subject.current_user) }
          it 'indexテンプレートがレンダリングされる' do
            get :index, params: { team_id: team.id }
            expect(response).to render_template :index
          end
        end
        context 'マネージャーでない場合' do
          let!(:my_member) { create(:member, :shift_coordinator, team: team, user: subject.current_user) }
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :index, params: { team_id: team.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :index, params: { team_id: team.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end


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
      context '自チームのメンバーである場合' do
        context 'マネージャーである場合' do
          let!(:member) { create(:member, approve: approve, team: team) }
          let!(:my_member) { create(:member, :manager, team: team, user: subject.current_user) }
          context 'メンバーが承認されていない場合' do
            let!(:approve) { false }
            it 'showテンプレートがレンダリングされる' do
              get :show, params: { id: member.id }
              expect(response).to render_template :show
            end
          end
          context 'メンバーが承認されている場合' do
            let!(:approve) { true }
            it 'ユーザー用のホーム画面にリダイレクトする' do
              get :show, params: { id: member.id }
              expect(response).to redirect_to users_home_index_url
            end
          end
        end
        context 'マネージャーでない場合' do
          let!(:my_member) { create(:member, :shift_coordinator, team: team, user: subject.current_user) }
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :show, params: { id: member.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :show, params: { id: member.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end


  describe 'GET #edit' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :edit, params: { id: member.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context '自チームのメンバーである場合' do
        context 'マネージャーである場合' do
          let!(:member) { create(:member, approve: approve, team: team) }
          let!(:my_member) { create(:member, :manager, team: team, user: subject.current_user) }
          context 'メンバーが承認されていない場合' do
            let!(:approve) { false }
            it 'editテンプレートがレンダリングされる' do
              get :edit, params: { id: member.id }
              expect(response).to render_template :edit
            end
          end
          context 'メンバーが承認されている場合' do
            let!(:approve) { true }
            it 'ユーザー用のホーム画面にリダイレクトする' do
              get :edit, params: { id: member.id }
              expect(response).to redirect_to users_home_index_url
            end
          end
        end
        context 'マネージャーでない場合' do
          let!(:my_member) { create(:member, :shift_coordinator, team: team, user: subject.current_user) }
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :edit, params: { id: member.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: member.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        delete :destroy, params: { id: member.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'マネージャーである場合' do
        let!(:my_member) { create(:member, :manager, team: team, user: subject.current_user) }
        context 'メンバーが承認されていない場合' do
          let!(:unapprove_member) { create(:member, team: team) }
          it 'メンバーが削除される' do
            expect {
              delete :destroy, params: { id: unapprove_member.id }
            }.to change(Member, :count).by(-1)
          end
          it '未承認メンバー一覧ページにリダイレクトされる' do
            delete :destroy, params: { id: unapprove_member.id }
            expect(response).to redirect_to users_shift_coordinators_team_members_unapprovals_url(unapprove_member.team)
          end
        end
        context 'メンバーが承認されている場合' do
          let!(:approve_member) { create(:member, :part_timer, team: team) }
          it 'メンバーが削除されない' do
            expect {
              delete :destroy, params: { id: approve_member.id }
            }.to change(Member, :count).by(0)
          end
          it 'ユーザー用のホーム画面にリダイレクトする' do
            delete :destroy, params: { id: approve_member.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context 'マネージャーでない場合' do
        let!(:my_member) { create(:member, :shift_coordinator, team: team, user: subject.current_user) }
        it 'メンバーが削除されない' do
          expect {
            delete :destroy, params: { id: member.id }
          }.to change(Member, :count).by(0)
        end
        it 'ユーザー用のホーム画面にリダイレクトする' do
          delete :destroy, params: { id: member.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'メンバーが削除されない' do
          expect {
            delete :destroy, params: { id: member.id }
          }.to change(Member, :count).by(0)
        end
        it 'ユーザー用のホーム画面にリダイレクトする' do
          delete :destroy, params: { id: member.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end
end
