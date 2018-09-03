require 'rails_helper'

RSpec.describe Owners::ShiftSubmissionsController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  let!(:member) { create(:member, team: team) }

  let!(:shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm, member: member) }
  let!(:other_shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm) }


  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: shift_submission.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト希望がログイン済みのオーナーのものである場合' do
        it 'showテンプレートがレンダリングされる' do
          get :show, params: { id: shift_submission.id }
          expect(response).to render_template :show
        end
      end
      context 'シフト希望がログイン済みのオーナーのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :show, params: { id: other_shift_submission.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end
end
