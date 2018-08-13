require 'rails_helper'

RSpec.describe Owners::ShiftRegistrationsController, type: :controller do
  login_owner

  let!(:team) { create(:team, owner: subject.current_owner) }
  let!(:other_team) { create(:team) }

  let!(:member) { create(:member, team: team) }
  let!(:other_member) { create(:member) }

  let!(:shift_registration) { create(:shift_registration, :tomorrow, :eight_am_to_three_pm, member: member) }
  let!(:other_shift_registration) { create(:shift_registration, :tomorrow, :eight_am_to_three_pm) }

  describe 'GET #new' do
    context 'ログインしていない場合' do
      before do
        sign_out subject.current_owner
      end
      it 'ログイン画面にリダイレクトする' do
        get :new, params: { member_id: member.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのオーナーのチームのものである場合' do
        it 'newテンプレートがレンダリングされる' do
          get :new, params: { member_id: member.id }
          expect(response).to render_template :new
        end
      end
      context 'メンバーがログイン済みのオーナーのチームのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :new, params: { member_id: other_member.id }
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
        get :edit, params: { id: shift_registration.id }
        expect(response).to redirect_to new_owner_session_url
      end
    end
    context 'ログインしている場合' do
      context 'メンバーがログイン済みのオーナーのチームのものである場合' do
        it 'editテンプレートがレンダリングされる' do
          get :edit, params: { id: shift_registration.id }
          expect(response).to render_template :edit
        end
      end
      context 'メンバーがログイン済みのオーナーのチームのものでない場合' do
        it 'オーナー用のホーム画面にリダイレクトする' do
          get :edit, params: { id: other_shift_registration.id }
          expect(response).to redirect_to owners_home_index_url
        end
      end
    end
  end

end
