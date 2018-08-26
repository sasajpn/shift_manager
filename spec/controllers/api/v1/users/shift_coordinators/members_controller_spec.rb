require 'rails_helper'

RSpec.describe Api::V1::Users::ShiftCoordinators::MembersController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:part_timer) { create(:member, :part_timer, team: team) }
  let!(:full_timer) { create(:member, :full_timer, team: team) }
  let!(:manager) { create(:member, :manager, team: team) }

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
        context 'シフト調整権限がある場合' do
          let!(:my_member) { create(:member, :shift_coordinator, role: role, team: team, user: subject.current_user) }
          context 'マネージャーの場合' do
            let!(:role) { 'manager' }
            context 'アクセス先のメンバーがマネージャーの場合' do
              it '200が返ってくる' do
                get :show, params: { id: manager.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のメンバーが正社員の場合' do
              it '200が返ってくる' do
                get :show, params: { id: full_timer.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のメンバーがパートタイマーの場合' do
              it '200が返ってくる' do
                get :show, params: { id: part_timer.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
          context '正社員の場合' do
            let!(:role) { 'full_timer' }
            context 'アクセス先のメンバーがマネージャーの場合' do
              it '404が返ってくる' do
                get :show, params: { id: manager.id }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のメンバーが正社員の場合' do
              it '200が返ってくる' do
                get :show, params: { id: full_timer.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
            context 'アクセス先のメンバーがパートタイマーの場合' do
              it '200が返ってくる' do
                get :show, params: { id: part_timer.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
          context 'パートタイマーの場合' do
            let!(:role) { 'part_timer' }
            context 'アクセス先のメンバーがマネージャーの場合' do
              it '404が返ってくる' do
                get :show, params: { id: manager.id }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のメンバーが正社員の場合' do
              it '404が返ってくる' do
                get :show, params: { id: full_timer.id }
                expect(response).not_to be_success
                expect(response.status).to eq 404
              end
            end
            context 'アクセス先のメンバーがパートタイマーの場合' do
              it '200が返ってくる' do
                get :show, params: { id: part_timer.id }
                expect(response).to be_success
                expect(response.status).to eq 200
              end
            end
          end
        end
        context 'シフト調整権限がない場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it '404が返ってくる' do
            get :show, params: { id: member.id }
            expect(response).not_to be_success
            expect(response.status).to eq 404
          end
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it '404が返ってくる' do
          get :show, params: { id: member.id }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end


  describe 'PATCH #update' do
    let!(:update_attributes) do
      { role: 'full_timer', shift_coordinator: true }
    end
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_user
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update, params: { id: member.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
    context 'ログインしている場合' do
      context '自チームのメンバーである場合' do
        context 'マネージャーの場合' do
          let!(:my_member) { create(:member, :manager, team: team, user: subject.current_user) }
          it 'メンバーの登録内容が更新される' do
            patch :update, params: { id: member.id, member: update_attributes }
            member.reload
            expect(member.role).to eq 'full_timer'
            expect(member.shift_coordinator).to eq true
          end
          it '200が返ってくる' do
            patch :update, params: { id: member.id, member: update_attributes }
            expect(response).to be_success
            expect(response.status).to eq 200
          end
        end
        context 'マネージャー以外の場合' do
          let!(:my_member) { create(:member, team: team, user: subject.current_user) }
          it 'メンバーの登録内容が更新されない' do
            patch :update, params: { id: member.id, member: update_attributes }
            member.reload
            expect(member.role).to eq 'part_timer'
            expect(member.shift_coordinator).to eq false
          end
          it '200が返ってくる' do
            patch :update, params: { id: member.id, member: update_attributes }
            expect(response).not_to be_success
            expect(response.status).to eq 404
          end
        end
      end
    end
  end
end
