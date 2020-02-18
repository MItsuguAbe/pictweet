require 'rails_helper'

describe 'ツイート機能', type: :system do
    describe '一覧表示機能' do
        let(:user_a) {FactoryBot.create(:user, nickname: 'ユーザーA', email: 'a@example.com')}
        let(:user_b) {FactoryBot.create(:user, nickname: 'ユーザーB', email: 'b@example.com')}

        before do
            FactoryBot.create(:tweet, text: '最初の投稿',  user: user_a)
            visit new_user_session_path
            fill_in 'Email', with: 'a@example.com'
            fill_in 'Password', with: 'password'
            click_button 'Log in'
        end

        context 'ユーザーAがログインしている時' do
            let(:login_user){user_a}

            it 'ユーザーAが作成したツイートが表示される' do
                expect(page).to have_content '最初の投稿'
            end
        end
   
        context 'ユーザーBがログインしている時' do
            let(:login_user){user_b}

            it 'ユーザーAが作成したツイートが表示される' do
                expect(page).to have_content '最初の投稿'
            end
        end
   
   
    end
end