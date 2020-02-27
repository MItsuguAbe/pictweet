require 'rails_helper'

describe TweetsController, type: :controller do

  describe 'GET #new' do
    it "new.html.erbに遷移しているか" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "インスタンス変数に期待した値が入っているか" do
        tweet = create(:tweet)
        #データベースに保存したいのでbuildではなくcreateでいく
        get :edit, params: { id: tweet }
        expect(assigns(:tweet)).to eq tweet
    end

    it "edit.html.erbに遷移しているか" do
        tweet = create(:tweet)
        get :edit, params: { id: tweet }
        expect(response).to render_template :edit
    end
  end

  describe 'GET #index' do
    it "populates an array of tweets ordered by created_at DESC" do
        #indexアクションに関してのポイントは、indexアクションで定義している@tweetsは配列の形で取得されてくること
        tweets = create_list(:tweet, 3) 
        get :index  
        expect(assigns(:tweets)).to match(tweets.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "renders the :index template" do
        get :index
        expect(response).to render_template :index
    end
  end

end

