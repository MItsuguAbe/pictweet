require 'rails_helper'

describe 'ツイート機能', type: :system do
    let(:user_a) {FactoryBot.create(:user, nickname: 'ユーザーA', email: 'a@example.com')}
    let(:user_b) {FactoryBot.create(:user, nickname: 'ユーザーB', email: 'b@example.com')}
    let!(:tweet_a) {FactoryBot.create(:tweet, text: '最初の投稿', user: user_a)}

    before do
        visit new_user_session_path
        fill_in 'Email', with: login_user.email
        fill_in 'Password', with: login_user.password
        click_button 'Log in'
    end

    shared_examples_for 'ユーザーAが作成したツイートが表示される' do
        it {expect(page).to have_content '最初の投稿'}
    end

    describe '一覧表示機能' do
        context 'ユーザーAがログインしている時' do
            let(:login_user){user_a}
            it_behaves_like 'ユーザーAが作成したツイートが表示される'
        end
   
        context 'ユーザーBがログインしている時' do
            let(:login_user){user_b}
            it_behaves_like 'ユーザーAが作成したツイートが表示される'
        end
    end

    describe '詳細表示機能' do
        context 'ユーザーAがログインしている時' do
            let(:login_user){user_a}
            before do 
              visit tweet_path(tweet_a)
            end

            it_behaves_like 'ユーザーAが作成したツイートが表示される'
        end
    end

    describe '新規作成機能' do
        let(:login_user){user_a}
        before do
            visit new_tweet_path
            fill_in 'text', with: tweet_text
            click_button 'SEND'
        end

        context 'ユーザーAがログインしている時' do
            let(:tweet_text){'新規作成のテストを書く'}
            it '投稿成功' do
                expect(page).to have_content '投稿が完了しました。'
            end
        end
    end

    #describe '削除機能' do
        #context 'ユーザーAがログインしている時' do
            #let(:login_user){user_a}
            #before do
                #tweet_destroy=FactoryBot.create(:tweet, text: '削除用の投稿', user: user_a)
                #visit tweet_path(tweet_destroy) 
            #end

            #it '削除完了' do
                #expect(page).to have_content '削除が完了しました。'
            #end
        #end
    #end
end