require 'rails_helper'

describe 'タスク管理機能', type: :system do
  # ユーザーAを作成しておく
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  # ユーザーBを作成しておく
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  # user_aのtaskを投稿
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

  before do
    # 作成者がユーザーAであるタスクを作成しておく
    FactoryBot.create(:task, name: '最初のタスク', user: user_a)
    # ユーザーA、ユーザーBそれぞれでログインする
    # 1.ログイン画面にアクセス
    visit login_path
    # 2.メールアドレスを入力
    fill_in 'メールアドレス', with: login_user.email
    # 3.パスワードを入力
    fill_in 'パスワード', with: login_user.password
    # 4.ログインするボタンをおす
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content '最初のタスク' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      # user_aと定義されたletが呼び出されlogin_userへ代入される
      let(:login_user) { user_a }

      # ユーザーAが作成したタスクの名称が画面上に表示されていることを確認
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしている時' do
      # user_bと定義されたletが呼び出されlogin_userへ代入される
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        # 作成済みのタスクの名称が画面上に表示されていないことを確認
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end
end