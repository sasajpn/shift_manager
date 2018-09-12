require 'rails_helper'

RSpec.describe Api::V1::Owners::Members::UnapprovalsController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:other_member) { create(:member) }


  describe 'PATCH #update' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        patch :update, params: { id: member.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのオーナーのチームのものである場合' do
        context 'メンバーが未承認の場合' do
          let!(:unapproval_member) { create(:member, team: team) }
          it 'メンバーの登録内容が更新される' do
            patch :update, params: { id: unapproval_member.id, member: { role: 'manager', approve: true } }
            unapproval_member.reload
            expect(unapproval_member.role).to eq 'manager'
            expect(unapproval_member.approve).to eq true
          end
          it '200が返ってくる' do
            patch :update, params: { id: unapproval_member.id, member: { role: 'manager', approve: true } }
            expect(response).to be_success
            expect(response.status).to eq 200
          end
        end
        context 'メンバーが承認済みの場合' do
          let!(:approval_member) { create(:member, approve: true, team: team) }
          it  'メンバーの登録内容が更新されない' do
            patch :update, params: { id: approval_member.id, member: { role: 'manager', approve: true } }
            approval_member.reload
            expect(approval_member.role).to eq 'part_timer'
          end
          it '404が返ってくる' do
            patch :update, params: { id: approval_member.id, member: { role: 'manager', approve: true } }
            expect(response).not_to be_success
            expect(response.status).to eq 404
          end
        end
      end
      context 'メンバーがログイン済みのオーナーのチームのものでない場合' do
        it  'メンバーの登録内容が更新されない' do
          patch :update, params: { id: other_member.id, member: { role: 'manager', approve: true } }
          other_member.reload
          expect(member.role).to eq 'part_timer'
        end
        it '404が返ってくる' do
          patch :update, params: { id: other_member.id, member: { role: 'manager', approve: true } }
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end
end
