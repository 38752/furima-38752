require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      item = FactoryBot.create(:item)
      buyer = FactoryBot.create(:user)
      @order_address = FactoryBot.build(:order_address, user_id: buyer.id, item_id: item.id)
      sleep 0.1
    end

    context '保存できる場合' do
      it '保存できる' do
        expect(@order_address).to be_valid
      end
      it 'apartmentは空でも保存できる' do
        @order_address.apartment = ''
        expect(@order_address).to be_valid
      end
      it 'phone_numberは11桁でも保存できる' do
        @order_address.phone_number += '0'
      end
    end

    context '保存できない場合' do
      # token
      it 'tokenが空では保存できない' do
        @order_address.token = nil
        check_error_messages(@order_address, "Token can't be blank")
      end
      # post_code
      it 'post_codeが空では保存できない' do
        @order_address.post_code = ''
        check_error_messages(@order_address, "Post code is invalid. Include hyphen(-)")
      end
      it 'post_codeが数字と数字の間に半角ハイフンを含まなければ保存できない' do
        @order_address.post_code = '1234567'
        check_error_messages(@order_address, "Post code is invalid. Include hyphen(-)")
      end
      it 'post_codeが全角数字を含むと保存できない' do
        @order_address.post_code += '123-456７'
        check_error_messages(@order_address, "Post code is invalid. Include hyphen(-)")
      end
      # prefecture_id
      it 'prefecture_idが1では保存できない' do
        @order_address.prefecture_id = 1
        check_error_messages(@order_address, "Prefecture can't be blank")
      end
      # city
      it 'cityが空では保存できない' do
        @order_address.city = ''
        check_error_messages(@order_address, "City can't be blank")
      end
      # address
      it 'addressが空では保存できない' do
        @order_address.address = ''
        check_error_messages(@order_address, "Address can't be blank")
      end
      # phone_number
      it 'phone_numberが空では保存できない' do
        @order_address.phone_number = ''
        check_error_messages(@order_address, "Phone number is invalid.")
      end
      it 'phone_numberが10桁未満では保存できない' do
        @order_address.phone_number = '123456789'
        check_error_messages(@order_address, "Phone number is invalid.")
      end
      it 'phone_numberが11桁を超えていると保存できない' do
        @order_address.phone_number = '123456789012'
        check_error_messages(@order_address, "Phone number is invalid.")
      end
      it 'phone_numberがハイフンを含むと保存できない' do
        @order_address.phone_number = '03-1234-5678'
        check_error_messages(@order_address, "Phone number is invalid.")
      end
      it 'phone_numberが全角数字を含むと保存できない' do
        @order_address.phone_number += '０'
        check_error_messages(@order_address, "Phone number is invalid.")
      end
      # item
      it 'itemが紐づいていないと保存できない' do
        @order_address.item_id = nil
        check_error_messages(@order_address, "Item can't be blank")
      end
      # user
      it 'userが紐づいていないと保存できない' do
        @order_address.user_id = nil
        check_error_messages(@order_address, "User can't be blank")
      end
    end
  end

  private

  def puts_error_messages
    @order_address.valid?
    @order_address.errors.full_messages
  end
end
