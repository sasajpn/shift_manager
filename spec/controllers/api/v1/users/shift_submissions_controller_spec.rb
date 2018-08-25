require 'rails_helper'

RSpec.describe Api::V1::Users::ShiftSubmissionsController, type: :controller do
  login_user

  let!(:member) { create(:member, user: subject.current_user) }
  let!(:other_member) { create(:member) }

  let!(:shift_submission) { create(:shift_submission, member: member) }
  let!(:other_shift_submission) { create(:shift_submission) }

  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: { id: shift_submission.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト希望がログイン済みのユーザーのものである場合' do
        it '200が返ってくる' do
          get :show, params: { id: shift_submission.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'シフト希望がログイン済みのユーザーのものでない場合' do
        it '404が返ってくる' do
          get :show, params: { id: other_shift_submission.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end


  describe 'POST #create' do
    let!(:create_attributes) do
      { submitted_date: Date.tomorrow + 1, start_time: '10:00', end_time: '16:00' }
    end
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        post :create, params: { member_id: member.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのユーザーのものである場合' do
        it 'シフト希望が作成される' do
          expect{
            post :create, params: { member_id: member.id, shift_submission: create_attributes }
          }.to change(ShiftSubmission, :count).by(1)
        end
        it '200が返ってくる' do
          post :create, params: { member_id: member.id, shift_submission: create_attributes }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'メンバーがログイン済みのユーザーのものでない場合' do
        it 'シフト登録が作成されない' do
          expect{
            post :create, params: { member_id: other_member.id, shift_submission: create_attributes }
          }.to change(ShiftSubmission, :count).by(0)
        end
        it '404が返ってくる' do
          post :create, params: { member_id: other_member.id, shift_submission: create_attributes }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end


  describe 'PATCH #update' do
    let!(:update_attributes) do
      { start_time: '12:00', end_time: '18:00' }
    end
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update, params: { id: shift_submission.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト希望がログイン済みのユーザーのものである場合' do
        it 'シフト希望が更新される' do
          patch :update, params: { id: shift_submission.id, shift_submission: update_attributes }
          shift_submission.reload
          expect(shift_submission.start_time).to eq '12:00'
          expect(shift_submission.end_time).to eq '18:00'
        end
        it '200が返ってくる' do
          patch :update, params: { id: shift_submission.id }
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'シフト希望がログイン済みのユーザーのものでない場合' do
        it 'シフト希望が更新されない' do
          patch :update, params: { id: other_shift_submission.id, shift_submission: update_attributes }
          other_shift_submission.reload
          expect(shift_submission.start_time).to eq '08:00'
        end
        it '404が返ってくる' do
          patch :update, params: { id: other_shift_submission.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
