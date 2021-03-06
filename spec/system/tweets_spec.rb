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
            find(".form-group")
            #find(".form-check", visible: false) #なんでこっちはみつからないのかと思ったら、input type="hidden"になってる。。なぜ？
            click_button 'SEND'
        end

        context 'ユーザーAがログインしている時' do
            let(:tweet_text){'新規作成のテストを書く'}
            it '投稿成功' do
                expect(page).to have_content '投稿が完了しました。'
            end
        end
    end

    describe 'コメント機能' do
        context 'ユーザーAがログインしている時' do
            let(:login_user){user_a}
            before do 
              visit tweet_path(tweet_a)
              fill_in 'コメントする', with: "コメント機能のテスト"
              click_button 'SEND'
            end

            it 'ユーザーAが作成したコメントが表示される' do
                expect(page).to have_content "コメント機能のテスト"
            end
        end
    end

    describe '検索機能' do
        context 'ユーザーAがログインしている時' do
            let(:login_user){user_a}
            before do 
              fill_in '投稿を検索する', with: "最初の投稿"
              click_button '検索'
            end

            it '最初の投稿の記事が表示される' do
                expect(page).to have_content "最初の投稿"
            end
        end
    end

    describe 'いいね機能' do
        context 'ユーザーAがログインしている時' do
            let(:login_user){user_a}
            before do 
              visit tweet_path(tweet_a)
              find('#like').click
            end

            it 'いいねの数が0から1になる' do
                expect(page).to have_content "1"
            end
        end
    end
end