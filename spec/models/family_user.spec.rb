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
      it 'user1のニックネーム空だと保存できないこと' do
        @family_user.user1[:nickname] = ''
        @family_user.valid?
        expect(@family_user.errors.full_messages).to include("ニックネーム(ユーザー1)を入力してください")
      end
      it 'user2が空だと保存できないこと' do
        @family_user.user2 = ''
        @family_user.valid?
        expect(@family_user.errors.full_messages).to include("この家族名は既に存在しています")
      end
    end
  end
end
