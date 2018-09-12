require 'rails_helper'

RSpec.describe Api::V1::Owners::ShiftAdjustmentsController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  let!(:member) { create(:member, team: team) }

  let!(:shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm, member: member) }
  let!(:other_shift_submission) { create(:shift_submission, :tomorrow, :eight_am_to_three_pm) }

  
  describe 'GET #show' do
    let!(:shift_adjustment) { create(:shift_adjustment, :eight_am_to_three_pm, shift_submission: shift_submission) }
    let!(:other_shift_adjustment) { create(:shift_adjustment, :eight_am_to_three_pm, shift_submission: other_shift_submission) }

    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: shift_adjustment.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト調整がログイン済みのオーナーのものである場合' do
        it '200が返ってくる' do
          get :show, params: { id: shift_adjustment.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'シフト調整がログイン済みのオーナーのチームのものでない場合' do
        it '404が返ってくる' do
          get :show, params: { id: other_shift_adjustment.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end

  describe 'POST #create' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        post :create, params: { shift_submission_id: shift_submission.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト希望がログイン済みのオーナーのものである場合' do
        it 'シフト調整が作成される' do
          expect{
            post :create, params: { shift_submission_id: shift_submission.id, shift_adjustment: { start_time: '10:00', end_time: '12:00' } }
          }.to change(Shift::Adjustment, :count).by(1)
        end
        it '200が返ってくる' do
          post :create, params: { shift_submission_id: shift_submission.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'シフト希望がログイン済みのオーナーのチームのものでない場合' do
        it 'シフト調整が作成されない' do
          expect{
            post :create, params: { shift_submission_id: other_shift_submission.id, shift_adjustment: { start_time: '10:00', end_time: '12:00' } }
          }.to change(Shift::Adjustment, :count).by(0)
        end
        it '404が返ってくる' do
          post :create, params: { shift_submission_id: other_shift_submission.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end

  describe 'PATCH #update' do
    let!(:shift_adjustment) { create(:shift_adjustment, :eight_am_to_three_pm, shift_submission: shift_submission) }
    let!(:other_shift_adjustment) { create(:shift_adjustment, :eight_am_to_three_pm, shift_submission: other_shift_submission) }

    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update, params: { id: shift_adjustment.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト希望がログイン済みのオーナーのものである場合' do
        it 'シフト調整が更新される' do
          patch :update, params: { id: shift_adjustment.id, shift_adjustment: { start_time: '11:00' } }
          shift_adjustment.reload
          expect(shift_adjustment.start_time).to eq '11:00'
        end
        it '200が返ってくる' do
          patch :update, params: { id: shift_adjustment.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'シフト希望がログイン済みのオーナーのチームのものでない場合' do
        it 'シフト調整が更新されない' do
          patch :update, params: { id: other_shift_adjustment.id, shift_adjustment: { start_time: '11:00' } }
          shift_adjustment.reload
          expect(shift_adjustment.start_time).to eq '08:00'
        end
        it '404が返ってくる' do
          patch :update, params: { id: other_shift_adjustment.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
