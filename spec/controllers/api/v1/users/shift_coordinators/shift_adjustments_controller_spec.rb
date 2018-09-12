require 'rails_helper'

RSpec.describe Api::V1::Users::ShiftCoordinators::ShiftAdjustmentsController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:part_timer) { create(:member, :part_timer, team: team) }
  let!(:full_timer) { create(:member, :full_timer, team: team) }
  let!(:manager) { create(:member, :manager, team: team) }

  let!(:shift_submission) { create(:shift_submission, member: member) }
  let!(:part_timer_shift_submission) { create(:shift_submission, member: part_timer) }
  let!(:full_timer_shift_submission) { create(:shift_submission, member: full_timer) }
  let!(:manager_shift_submission) { create(:shift_submission, member: manager) }

  describe 'GET #show' do
    let!(:shift_adjustment) { create(:shift_adjustment, shift_submission: shift_submission) }
    let!(:part_timer_shift_adjustment) { create(:shift_adjustment, shift_submission: part_timer_shift_submission) }
    let!(:full_timer_shift_adjustment) { create(:shift_adjustment, shift_submission: full_timer_shift_submission) }
    let!(:manager_shift_adjustment) { create(:shift_adjustment, shift_submission: manager_shift_submission) }

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
        context 'シフト調整権限がある場合' do
          let!(:my_member) { create(:member, :shift_coordinator, role: role, team: team, user: subject.current_user) }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it '200が返ってくる' do
                get :show, params: { id: manager_shift_adjustment.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it '200が返ってくる' do
                get :show, params: { id: full_timer_shift_adjustment.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it '200が返ってくる' do
                get :show, params: { id: part_timer_shift_adjustment.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it '404が返ってくる' do
                get :show, params: { id: manager_shift_adjustment.id }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it '200が返ってくる' do
                get :show, params: { id: full_timer_shift_adjustment.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it '200が返ってくる' do
                get :show, params: { id: part_timer_shift_adjustment.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it '404が返ってくる' do
                get :show, params: { id: manager_shift_adjustment.id }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it '200が返ってくる' do
                get :show, params: { id: full_timer_shift_adjustment.id }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it '200が返ってくる' do
                get :show, params: { id: part_timer_shift_adjustment.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it '404が返ってくる' do
            get :show, params: { id: shift_adjustment.id }
            expect(response).not_to be_success
            expect(response.status).to eq 404
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it '404が返ってくる' do
          get :show, params: { id:shift_adjustment.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end


  describe 'POST #create' do
    let!(:create_attributes) do
      { start_time: '10:00', end_time: '15:00' }
    end
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        post :create, params: { shift_submission_id: shift_submission.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context '自チームのメンバーである場合' do
        context 'シフト調整権限がある場合' do
          let!(:my_member) { create(:member, :shift_coordinator, role: role, team: team, user: subject.current_user) }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のシフト希望がマネージャーのものである場合' do
              it 'シフト調整が作成される' do
                expect{
                  post :create, params: { shift_submission_id: manager_shift_submission.id, shift_adjustment: create_attributes }
                }.to change(Shift::Adjustment, :count).by(1)
              end
              it '200が返ってくる' do
                post :create, params: { shift_submission_id: manager_shift_submission.id, shift_adjustment: create_attributes }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のシフト希望が正社員のものである場合' do
              it 'シフト調整が作成される' do
                expect{
                  post :create, params: { shift_submission_id: full_timer_shift_submission.id, shift_adjustment: create_attributes }
                }.to change(Shift::Adjustment, :count).by(1)
              end
              it '200が返ってくる' do
                post :create, params: { shift_submission_id: full_timer_shift_submission.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'シフト調整が作成される' do
                expect{
                  post :create, params: { shift_submission_id: part_timer_shift_submission.id, shift_adjustment: create_attributes }
                }.to change(Shift::Adjustment, :count).by(1)
              end
              it '200が返ってくる' do
                post :create, params: { shift_submission_id: part_timer_shift_submission.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it 'シフト調整が作成されない' do
                expect{
                  post :create, params: { shift_submission_id: manager_shift_submission.id, shift_adjustment: create_attributes }
                }.to change(Shift::Adjustment, :count).by(0)
              end
              it '404が返ってくる' do
                post :create, params: { shift_submission_id: manager_shift_submission.id }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it 'シフト調整が作成される' do
                expect{
                  post :create, params: { shift_submission_id: full_timer_shift_submission.id, shift_adjustment: create_attributes }
                }.to change(Shift::Adjustment, :count).by(1)
              end
              it '200が返ってくる' do
                post :create, params: { shift_submission_id: full_timer_shift_submission.id, shift_adjustment: create_attributes }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'シフト調整が作成される' do
                expect{
                  post :create, params: { shift_submission_id: part_timer_shift_submission.id, shift_adjustment: create_attributes }
                }.to change(Shift::Adjustment, :count).by(1)
              end
              it '200が返ってくる' do
                post :create, params: { shift_submission_id: part_timer_shift_submission.id, shift_adjustment: create_attributes }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it 'シフト調整が作成されない' do
                expect{
                  post :create, params: { shift_submission_id: manager_shift_submission.id, shift_adjustment: create_attributes }
                }.to change(Shift::Adjustment, :count).by(0)
              end
              it '404が返ってくる' do
                post :create, params: { shift_submission_id: manager_shift_submission.id, shift_adjustment: create_attributes }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it 'シフト調整が作成されない' do
                expect{
                  post :create, params: { shift_submission_id: full_timer_shift_submission.id, shift_adjustment: create_attributes }
                }.to change(Shift::Adjustment, :count).by(0)
              end
              it '200が返ってくる' do
                post :create, params: { shift_submission_id: full_timer_shift_submission.id, shift_adjustment: create_attributes }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'シフト調整が作成される' do
                expect{
                  post :create, params: { shift_submission_id: part_timer_shift_submission.id, shift_adjustment: create_attributes }
                }.to change(Shift::Adjustment, :count).by(1)
              end
              it '200が返ってくる' do
                post :create, params: { shift_submission_id: part_timer_shift_submission.id, shift_adjustment: create_attributes }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it 'シフト調整が作成されない' do
            expect{
              post :create, params: { shift_submission_id: shift_submission.id, shift_adjustment: create_attributes }
            }.to change(Shift::Adjustment, :count).by(0)
          end
          it '404が返ってくる' do
            post :create, params: { shift_submission_id: shift_submission.id, shift_adjustment: create_attributes }
            expect(response).not_to be_success
            expect(response.status).to eq 404
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'シフト調整が作成されない' do
          expect{
            post :create, params: { shift_submission_id: shift_submission.id, shift_adjustment: create_attributes }
          }.to change(Shift::Adjustment, :count).by(0)
        end
        it '404が返ってくる' do
          post :create, params: { shift_submission_id: shift_submission.id, shift_adjustment: create_attributes }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end


  describe 'PATCH #update' do
    let!(:shift_adjustment) { create(:shift_adjustment, shift_submission: shift_submission) }
    let!(:part_timer_shift_adjustment) { create(:shift_adjustment, shift_submission: part_timer_shift_submission) }
    let!(:full_timer_shift_adjustment) { create(:shift_adjustment, shift_submission: full_timer_shift_submission) }
    let!(:manager_shift_adjustment) { create(:shift_adjustment, shift_submission: manager_shift_submission) }

    let!(:update_attributes) do
      { start_time: '10:00' }
    end
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update, params: { id: shift_adjustment.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context '自チームのメンバーである場合' do
        context 'シフト調整権限がある場合' do
          let!(:my_member) { create(:member, :shift_coordinator, role: role, team: team, user: subject.current_user) }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のシフト希望がマネージャーのものである場合' do
              it 'シフト調整が更新される' do
                patch :update, params: { id: manager_shift_adjustment.id, shift_adjustment: update_attributes }
                manager_shift_adjustment.reload
                expect(manager_shift_adjustment.start_time).to eq '10:00'
              end
              it '200が返ってくる' do
                patch :update, params: { id: manager_shift_adjustment.id, shift_adjustment: update_attributes }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のシフト希望が正社員のものである場合' do
              it 'シフト調整が更新される' do
                patch :update, params: { id: full_timer_shift_adjustment.id, shift_adjustment: update_attributes }
                full_timer_shift_adjustment.reload
                expect(full_timer_shift_adjustment.start_time).to eq '10:00'
              end
              it '200が返ってくる' do
                patch :update, params: { id: full_timer_shift_adjustment.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'シフト調整が更新される' do
                patch :update, params: { id: part_timer_shift_adjustment.id, shift_adjustment: update_attributes }
                part_timer_shift_adjustment.reload
                expect(part_timer_shift_adjustment.start_time).to eq '10:00'
              end
              it '200が返ってくる' do
                patch :update, params: { id: part_timer_shift_adjustment.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it 'シフト調整が更新されない' do
                patch :update, params: { id: manager_shift_adjustment.id, shift_adjustment: update_attributes }
                manager_shift_adjustment.reload
                expect(manager_shift_adjustment.start_time).to eq '08:00'
              end
              it '404が返ってくる' do
                patch :update, params: { id: manager_shift_adjustment.id }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it 'シフト調整が更新される' do
                patch :update, params: { id: full_timer_shift_adjustment.id, shift_adjustment: update_attributes }
                full_timer_shift_adjustment.reload
                expect(full_timer_shift_adjustment.start_time).to eq '10:00'
              end
              it '200が返ってくる' do
                patch :update, params: { id: full_timer_shift_adjustment.id, shift_adjustment: update_attributes }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'シフト調整が更新される' do
                patch :update, params: { id: part_timer_shift_adjustment.id, shift_adjustment: update_attributes }
                part_timer_shift_adjustment.reload
                expect(part_timer_shift_adjustment.start_time).to eq '10:00'
              end
              it '200が返ってくる' do
                patch :update, params: { id: part_timer_shift_adjustment.id, shift_adjustment: update_attributes }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のシフト調整がマネージャーのものである場合' do
              it 'シフト調整が更新されない' do
                patch :update, params: { id: manager_shift_adjustment.id, shift_adjustment: update_attributes }
                manager_shift_adjustment.reload
                expect(manager_shift_adjustment.start_time).to eq '08:00'
              end
              it '404が返ってくる' do
                patch :update, params: { id: manager_shift_adjustment.id, shift_adjustment: update_attributes }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のシフト調整が正社員のものである場合' do
              it 'シフト調整が更新されない' do
                patch :update, params: { id: full_timer_shift_adjustment.id, shift_adjustment: update_attributes }
                full_timer_shift_adjustment.reload
                expect(full_timer_shift_adjustment.start_time).to eq '08:00'
              end
              it '404が返ってくる' do
                patch :update, params: { id: full_timer_shift_adjustment.id, shift_adjustment: update_attributes }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のシフト調整がパートタイマーのものである場合' do
              it 'シフト調整が更新される' do
                patch :update, params: { id: part_timer_shift_adjustment.id, shift_adjustment: update_attributes }
                part_timer_shift_adjustment.reload
                expect(part_timer_shift_adjustment.start_time).to eq '10:00'
              end
              it '200が返ってくる' do
                patch :update, params: { id: part_timer_shift_adjustment.id, shift_adjustment: update_attributes }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it 'シフト調整が更新されない' do
            patch :update, params: { id: shift_adjustment.id, shift_adjustment: update_attributes }
            shift_adjustment.reload
            expect(shift_adjustment.start_time).to eq '08:00'
          end
          it '404が返ってくる' do
            patch :update, params: { id: shift_adjustment.id, shift_adjustment: update_attributes }
            expect(response).not_to be_success
            expect(response.status).to eq 404
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'シフト調整が更新されない' do
          patch :update, params: { id: shift_adjustment.id, shift_adjustment: update_attributes }
          shift_adjustment.reload
          expect(shift_adjustment.start_time).to eq '08:00'
        end
        it '404が返ってくる' do
          patch :update, params: { id: shift_adjustment.id, shift_adjustment: update_attributes }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
