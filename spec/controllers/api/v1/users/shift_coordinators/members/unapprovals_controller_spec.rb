require 'rails_helper'

RSpec.describe Api::V1::Users::ShiftCoordinators::Members::UnapprovalsController, type: :controller do
  login_user

  let!(:team) { create(:team) }

  let!(:member) { create(:member, team: team) }

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
      context 'マネージャーである場合' do
        let!(:my_member) { create(:member, :manager, team: team, user: subject.current_user) }
        context 'メンバーが承認されていない場合' do
          let!(:unapprove_member) { create(:member, team: team) }
          it 'メンバーの登録内容が更新される' do
            patch :update, params: { id: unapprove_member.id, member: update_attributes }
            unapprove_member.reload
            expect(unapprove_member.role).to eq 'full_timer'
          end
          it '200が返ってくる' do
            patch :update, params: { id: unapprove_member.id, member: update_attributes }
            expect(response).to be_success
            expect(response.status).to eq 200
          end
        end
        context 'メンバーが承認されている場合' do
          let!(:approve_member) { create(:member, :part_timer, team: team) }
          it 'メンバーの登録内容が更新されない' do
            patch :update, params: { id: approve_member.id, member: update_attributes }
            approve_member.reload
            expect(approve_member.role).to eq 'part_timer'
          end
          it '404が返ってくる' do
            patch :update, params: { id: approve_member.id, member: update_attributes }
            expect(response).not_to be_success
            expect(response.status).to eq 404
          end
        end
      end
      context 'マネージャーでない場合' do
        let!(:my_member) { create(:member, :shift_coordinator, team: team, user: subject.current_user) }
        it 'メンバーの登録内容が更新されない' do
          patch :update, params: { id: member.id, member: update_attributes }
          member.reload
          expect(member.role).to eq 'part_timer'
        end
        it '404が返ってくる' do
          patch :update, params: { id: member.id, member: update_attributes }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
      context '他チームのメンバーである場合' do
        let!(:other_member) { create(:member, :shift_coordinator, user: subject.current_user) }
        it 'メンバーの登録内容が更新されない' do
          patch :update, params: { id: member.id, member: update_attributes }
          member.reload
          expect(member.role).to eq 'part_timer'
        end
        it '404が返ってくる' do
          patch :update, params: { id: member.id, member: update_attributes }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
