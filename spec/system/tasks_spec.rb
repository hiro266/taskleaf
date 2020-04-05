require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # ユーザーAを作成しておく
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      # 作成者がユーザーAであるタスクを作成しておく
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
    end
    context 'ユーザーAがログインしている時' do
      before do
        # ユーザーAでログインする
        # 1.ログイン画面にアクセス
        visit login_path
        # 2.メールアドレスを入力
        fill_in 'メールアドレス', with: 'a@example.com'
        # 3.パスワードを入力
        fill_in 'パスワード', with: 'password'
        # 4.ログインするボタンをおす
        click_button 'ログインする'
      end

      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済みのタスクの名称が画面上に表示されていることを確認
        expect(page).to have_content '最初のタスク'
      end
    end
  end
end