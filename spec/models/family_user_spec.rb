require 'rails_helper'

RSpec.describe FamilyUser, type: :model do
  before do
    @family_user = FactoryBot.build(:family_user)
  end

  describe '新規ユーザー登録' do
    context '新規ユーザー登録できる場合' do
      it 'name, user1, user2が存在していれば保存できる' do
        expect(@family_user).to be_valid
      end
    end
    context '新規ユーザー登録できない場合' do
      it 'nameが空だと保存できないこと' do
        @family_user.name = ''
        @family_user.valid?
        expect(@family_user.errors.full_messages).to include("家族名を入力してください")
      end
      it 'user1のニックネームが空だと保存できないこと' do
        @family_user.user1["nickname"] = ''
        @family_user.valid?
        expect(@family_user.errors.full_messages).to include("ニックネーム(ユーザー1)を入力してください")
      end
      it 'user1のメールアドレスが空だと保存できないこと' do
        @family_user.user1["email"] = ''
        @family_user.valid?
        expect(@family_user.errors.full_messages).to include("メールアドレス(ユーザー1)を入力してください")
      end
      it 'user1のパスワードが空だと保存できないこと' do
        @family_user.user1["password"] = ''
        @family_user.valid?
        expect(@family_user.errors.full_messages).to include("パスワード(ユーザー1)を入力してください")
      end
      it 'user1のpasswordとpassword_confirmationが不一致では登録できない' do
        @family_user.user1["password_confirmation"] = '1234567'
        @family_user.valid?
        expect(@family_user.errors.full_messages).to include("パスワードの確認(ユーザー1)が一致しません")
      end
      it 'user2のニックネームが空だと保存できないこと' do
        @family_user.user2["nickname"] = ''
        @family_user.valid?
        expect(@family_user.errors.full_messages).to include("ニックネーム(ユーザー2)を入力してください")
      end
      it 'user2のメールアドレスが空だと保存できないこと' do
        @family_user.user2["email"] = ''
        @family_user.valid?
        expect(@family_user.errors.full_messages).to include("メールアドレス(ユーザー2)を入力してください")
      end
      it 'user2のパスワードが空だと保存できないこと' do
        @family_user.user2["password"] = ''
        @family_user.valid?
        expect(@family_user.errors.full_messages).to include("パスワード(ユーザー2)を入力してください")
      end
      it 'user2のpasswordとpassword_confirmationが不一致では登録できない' do
        @family_user.user2["password_confirmation"] = '1234567'
        @family_user.valid?
        expect(@family_user.errors.full_messages).to include("パスワードの確認(ユーザー2)が一致しません")
      end
    end
  end
end
