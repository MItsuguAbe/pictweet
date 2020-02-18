require 'rails_helper'

describe 'ツイート機能', type: :system do
    describe '一覧表示機能' do
        before do
            user_a=FactoryBot.create(:user, nickname: 'ユーザー', email: 'a@example.com')
            FactoryBot.create(:tweet, text: '最初の投稿',  user: user_a)
        end

        context 'ユーザーAがログインしている時' do
            before do
                visit new_user_session_path
                fill_in 'Email', with: 'a@example.com'
                fill_in 'Password', with: 'password'
                click_button 'Log in'
            end

            it 'ユーザーAが作成したタスクが表示される' do
                expect(page).to have_content '最初の投稿'
            end
        end
    end
end