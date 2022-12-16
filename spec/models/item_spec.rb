require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '出品' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '出品できる' do
      it '全ての情報が正しく入っていれば出品できる' do
        expect(@item).to be_valid
      end
      it '価格の頭に0がついていても出品できる' do
        @item.price = '0300'
        expect(@item).to be_valid
      end
    end

    context '出品できない' do
      # image
      it 'imageが空では出品できない' do
        @item.image = nil
        check_error_messages(@item, "Image can't be blank")
      end
      it 'imageで選択されたファイルが画像でなければ出品できない' do
        @item.image.attach(io: File.open('public/images/test_dummy.txt'), filename: 'test_dummy.txt')
        check_error_messages(@item, "Image is not a valid file format")
      end
      # name
      it 'nameが空では出品できない' do
        @item.name = ''
        check_error_messages(@item, "Name can't be blank")
      end
      it 'nameが40字を超えると出品できない' do
        @item.name = Faker::String.random(length: 41)
        check_error_messages(@item, "Name is too long (maximum is 40 characters)")
      end
      # detail
      it 'detailが空では出品できない' do
        @item.detail = ''
        check_error_messages(@item, "Detail can't be blank")
      end
      it 'detailが1000字を超えると出品できない' do
        @item.detail = Faker::String.random(length: 1001)
        check_error_messages(@item, "Detail is too long (maximum is 1000 characters)")
      end
      # category_id
      it 'category_idが1では登録できない' do
        @item.category_id = 1
        check_error_messages(@item, "Category can't be blank")
      end
      # condition_id
      it 'condition_idが1では登録できない' do
        @item.condition_id = 1
        check_error_messages(@item, "Condition can't be blank")
      end
      # delivery_charge_by_id
      it 'delivery_charge_by_idが1では登録できない' do
        @item.delivery_charge_by_id = 1
        check_error_messages(@item, "Delivery charge by can't be blank")
      end
      # prefecture_id
      it 'prefecture_idが1では登録できない' do
        @item.prefecture_id = 1
        check_error_messages(@item, "Prefecture can't be blank")
      end
      # days_to_post_id
      it 'days_to_post_idが1では登録できない' do
        @item.days_to_post_id = 1
        check_error_messages(@item, "Days to post can't be blank")
      end
      # price
      it 'priceが空では登録できない' do
        @item.price = ''
        check_error_messages(@item, "Price is not a number")
      end
      it 'priceが300未満では登録できない' do
        @item.price = 299
        check_error_messages(@item, "Price must be greater than or equal to 300")
      end
      it 'priceが10000000以上では登録できない' do
        @item.price = 10000000
        check_error_messages(@item, "Price must be less than or equal to 9999999")
      end
      it 'priceに全角文字が使われていると登録できない' do
        @item.price = '３00'
        check_error_messages(@item, "Price is not a number")
      end
      it 'priceに数字以外が使われていると登録できない' do
        @item.price = 'a300'
        check_error_messages(@item, "Price is not a number")
      end
    end
  end
end
