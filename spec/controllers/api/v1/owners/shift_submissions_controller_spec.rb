require 'rails_helper'

RSpec.describe Api::V1::Owners::ShiftSubmissionsController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:other_member) { create(:member) }

  let!(:shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm, member: member) }
  let!(:other_shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm) }

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
        it '200が返ってくる' do
          get :index, params: { team_id: team.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'チームがログイン済みのオーナーのものでない場合' do
        it '404が返ってくる' do
          get :index, params: { team_id: other_team.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
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
        get :show, params: { id: shift_submission.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト調整がログイン済みのオーナーのものである場合' do
        it '200が返ってくる' do
          get :show, params: { id: shift_submission.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'シフト調整がログイン済みのオーナーのチームのものでない場合' do
        it '404が返ってくる' do
          get :show, params: { id: other_shift_submission.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
