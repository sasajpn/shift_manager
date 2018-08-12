require 'rails_helper'

RSpec.describe Owners::ShiftAdjustmentsController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  let!(:member) { create(:member, team: team) }

  let!(:shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm, member: member) }
  let!(:other_shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm) }

  let!(:shift_adjustment) { create(:shift_adjustment, :eight_am_to_three_pm, shift_submission: shift_submission) }
  let!(:other_shift_adjustment) { create(:shift_adjustment, :eight_am_to_three_pm, shift_submission: other_shift_submission) }

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

  describe 'GET #new' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :new, params: { shift_submission_id: shift_submission.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト希望がログイン済みのオーナーのチームのものである場合' do
        it 'newテンプレートがレンダリングされる' do
          get :new, params: { shift_submission_id: shift_submission.id }
          expect(response).to render_template :new
        end
      end
      context 'シフト希望がログイン済みのオーナーのチームのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :new, params: { shift_submission_id: other_shift_submission.id }
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
        get :edit, params: { id: shift_adjustment.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト調整がログイン済みのオーナーのチームのものである場合' do
        it 'editテンプレートがレンダリングされる' do
          get :edit, params: { id: shift_adjustment.id }
          expect(response).to render_template :edit
        end
      end
      context 'シフト調整がログイン済みのオーナーのチームのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: other_shift_adjustment.id }
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
        delete :destroy, params: { id: shift_adjustment.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト調整がログイン済みのオーナーのチームのものである場合' do
        it 'シフト調整が削除される' do
          expect {
            delete :destroy, params: { id: shift_adjustment.id }
          }.to change(Shift::Adjustment, :count).by(-1)
        end
        it 'シフト調整のindexページにリダイレクトされる' do
          delete :destroy, params: { id: shift_adjustment.id }
          expect(response).to redirect_to owners_team_shift_adjustments_url(shift_adjustment.team)
        end
      end
      context 'シフト調整がログイン済みのオーナーのチームのものでない場合' do
        it 'シフト調整が削除されない' do
          expect {
            delete :destroy, params: { id: other_shift_adjustment.id }
          }.to change(Shift::Adjustment, :count).by(0)
        end
        it 'オーナー用のホーム画面にリダイレクトする' do
          delete :destroy, params: { id: other_shift_adjustment.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end
end
