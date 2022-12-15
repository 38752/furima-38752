require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '登録できる' do
      it '登録できる' do
        expect(@user).to be_valid
      end
    end

    context '登録できない' do
      # nickname
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        check_error_messages(@user, "Nickname can't be blank")
      end
      # email
      it 'emailが空では登録できない' do
        @user.email = ''
        check_error_messages(@user, "Email can't be blank")
      end
      it 'emailに@がないと登録できない' do
        @user.email = 'test.com'
        check_error_messages(@user, "Email is invalid")
      end
      it 'emailが一意でないと登録できない' do
        @user.save
        @another_user = FactoryBot.build(:user, email: @user.email)
        check_error_messages(@another_user, "Email has already been taken")
      end
      # password
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = @user.password
        check_error_messages(@user, "Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '1i1i1'
        @user.password_confirmation = @user.password
        check_error_messages(@user, "Password is too short (minimum is 6 characters)")
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        check_error_messages(@user, "Password is too long (maximum is 128 characters)")
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        check_error_messages(@user, "Password is invalid")
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        check_error_messages(@user, "Password is invalid")
      end
      it 'passwordとpassword_confirmationが異なると登録できない' do
        @user.password += 'l'
        check_error_messages(@user, "Password confirmation doesn't match Password")
      end
      # 本人確認
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        check_error_messages(@user, "Last name can't be blank")
      end
      it 'last_nameに半角文字があると登録できない' do
        @user.last_name += 'l'
        check_error_messages(@user, "Last name is invalid")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        check_error_messages(@user, "First name can't be blank")
      end
      it 'first_nameに半角文字があると登録できない' do
        @user.first_name += 'l'
        check_error_messages(@user, "First name is invalid")
      end
      it 'last_name_readingが空では登録できない' do
        @user.last_name_reading = ''
        check_error_messages(@user, "Last name reading can't be blank")
      end
      it 'last_name_readingに半角文字があると登録できない' do
        @user.last_name_reading += 'l'
        check_error_messages(@user, "Last name reading is invalid")
      end
      it 'first_name_readingが空では登録できない' do
        @user.first_name_reading = ''
        check_error_messages(@user, "First name reading can't be blank")
      end
      it 'first_name_readingに半角文字があると登録できない' do
        @user.first_name_reading += 'l'
        check_error_messages(@user, "First name reading is invalid")
      end
      it '誕生年が空では登録できない' do
        @user.birth_date = '-1-1'
        check_error_messages(@user, "Birth date can't be blank")
      end
      it '誕生月が空では登録できない' do
        @user.birth_date = '2001--1'
        check_error_messages(@user, "Birth date can't be blank")
      end
      it '誕生日が空では登録できない' do
        binding.pry
        @user.birth_date = '2001-1-'
        check_error_messages(@user, "Birth date can't be blank")
      end
    end

    private
    def check_error_messages(user, message)
      user.valid?
      expect(user.errors.full_messages).to include(message)
    end
  end
end
