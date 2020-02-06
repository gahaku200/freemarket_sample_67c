require 'rails_helper'
describe User do
  describe '#create' do  

    it "nickname: nil error" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "first_name: format zenkaku only" do
      user = build(:user, first_name: "あア阿")
      expect(user).to be_valid
    end

    it "first_name_kana: format hiragana only" do
      user = build(:user, first_name_kana: "あいう")
      expect(user).to be_valid
    end
 
    it "email must include @ and domain" do
      user = build(:user, email: "a@b.c")
      expect(user).to be_valid
    end

    it "password_length > 6 and match" do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      expect(user).to be_valid
    end
  end
end