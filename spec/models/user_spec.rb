require 'rails_helper'

describe User do
  before do
    @user=build(:user)
  end

  describe '#create' do
    it "nicknameが空では登録できないこと" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors[:nickname]).to include("can't be blank")
    end

    it "emailが空では登録できないこと" do
        @user.email = ""
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
    end

    it "passwordが空では登録できないこと" do
        @user.password = ""
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
    end

    it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
        user = build(:user, password: "password",password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
        expect(@user).to be_valid
    end

    it "重複したemailが存在する場合登録できないこと" do
        user = create(:user, email:"sample@gmail.com")
        another_user = build(:user, email:"sample@gmail.com")
        another_user.valid?
        expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "nicknameが7文字以上であれば登録できないこと" do
        user = build(:user, nickname:"1234567" )
        user.valid?
        expect(user.errors[:nickname]).to include("is too long (maximum is 6 characters)")
    end

    it "nicknameが6文字以下では登録できること" do
        user = build(:user, nickname:"123456")
        expect(user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと" do
        user = build(:user, password:"12345",password_confirmation:"12345")
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it "passwordが6文字以上であれば登録できること" do
        user = build(:user, password:"123456", password_confirmation:"123456")
        expect(user).to be_valid
    end
  end
end