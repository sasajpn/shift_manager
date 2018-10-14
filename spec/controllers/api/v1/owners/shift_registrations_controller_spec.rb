require 'rails_helper'

RSpec.describe Api::V1::Owners::ShiftRegistrationsController, type: :controller do
  login_owner

  let!(:team) {create(:team, owner: subject.current_owner)}
  let!(:other_team) {create(:team)}

  let!(:member) {create(:member, team: team)}
  let!(:other_member) {create(:member)}

  let!(:shift_registration) {create(:shift_registration, member: member)}
  let!(:other_shift_registration) {create(:shift_registration)}

  describe 'GET #show' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :show, params: {id: shift_registration.id}
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト登録がログイン済みのオーナーのチームのものである場合' do
        it '200が返ってくる' do
          get :show, params: {id: shift_registration.id}
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'シフト登録がログイン済みのオーナーのチームのものでない場合' do
        it '404が返ってくる' do
          get :show, params: {id: other_shift_registration.id}
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end

  describe 'POST #create' do
    let!(:create_attributes) do
      {registered_date: Date.today.next_month, start_time: '10:00', end_time: '12:00'}
    end
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        post :create, params: {member_id: member.id}
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト登録がログイン済みのオーナーのチームのものである場合' do
        it 'シフト登録が作成される' do
          expect {
            post :create, params: {member_id: member.id, shift_registration: create_attributes}
          }.to change(Shift::Registration, :count).by(1)
        end
        it '200が返ってくる' do
          post :create, params: {member_id: member.id, shift_registration: create_attributes}
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'シフト登録がログイン済みのオーナーのチームのものでない場合' do
        it 'シフト登録が作成されない' do
          expect {
            post :create, params: {member_id: other_member.id, shift_registration: create_attributes}
          }.to change(Shift::Registration, :count).by(0)
        end
        it '404が返ってくる' do
          post :create, params: {member_id: other_member.id, shift_registration: create_attributes}
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end

  describe 'PATCH #update' do
    let!(:update_attributes) do
      {start_time: '10:00'}
    end
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update, params: {id: shift_registration.id}
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'シフト登録がログイン済みのオーナーのものである場合' do
        it 'シフト登録が更新される' do
          patch :update, params: {id: shift_registration.id, shift_registration: update_attributes}
          shift_registration.reload
          expect(shift_registration.start_time).to eq '10:00'
        end
        it '200が返ってくる' do
          patch :update, params: {id: shift_registration.id}
          expect(response).to be_success
          expect(response.status).to eq 200
        end
      end
      context 'シフト登録がログイン済みのオーナーのチームのものでない場合' do
        it 'シフト登録が更新されない' do
          patch :update, params: {id: other_shift_registration.id, shift_registration: update_attributes}
          shift_registration.reload
          expect(shift_registration.start_time).to eq '08:00'
        end
        it '404が返ってくる' do
          patch :update, params: {id: other_shift_registration.id}
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
