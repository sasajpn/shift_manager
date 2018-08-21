require 'rails_helper'

RSpec.describe Users::FullTimers::ShiftSubmissionsController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:manager) { create(:member, :manager, team: team) }

  let!(:shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm, member: member) }
  let!(:manager_shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm, member: manager) }

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
      context 'ログイン済みユーザーが正社員である場合' do
        let!(:full_timer) { create(:member, :full_timer, team: team, user: subject.current_user) }
        it 'indexテンプレートがレンダリングされる' do
          get :index, params: { team_id: team.id }
          expect(response).to render_template :index
        end
      end
      context 'ログイン済みユーザーが正社員でない場合' do
        let!(:part_timer) { create(:member, team: team, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :index, params: { team_id: team.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context 'ログイン済みユーザーが他チームの正社員である場合' do
        let!(:other_full_timer) { create(:member, :full_timer, user: subject.current_user) }
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
      context 'ログイン済みユーザーが正社員である場合' do
        let!(:full_timer) { create(:member, :full_timer, team: team, user: subject.current_user) }
        context 'アクセス先のシフト希望が正社員またはアルバイトの場合' do
          it 'showテンプレートがレンダリングされる' do
            get :show, params: { id: shift_submission.id }
            expect(response).to render_template :show
          end
        end
        context 'アクセス先のメンバーがマネージャーの場合' do
          it 'ユーザー用のホーム画面にリダイレクトする' do
            get :show, params: { id: manager_shift_submission.id }
            expect(response).to redirect_to users_home_index_url
          end
        end
      end
      context 'ログイン済みユーザーが正社員でない場合' do
        let!(:part_timer) { create(:member, team: team, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :show, params: { id: shift_submission.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
      context 'ログイン済みユーザーが他チームの正社員である場合' do
        let!(:other_full_timer) { create(:member, :full_timer, user: subject.current_user) }
        it 'ユーザー用のホーム画面にリダイレクトする' do
          get :show, params: { id: shift_submission.id }
          expect(response).to redirect_to users_home_index_url
        end
      end
    end
  end
end
