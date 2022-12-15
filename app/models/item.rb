class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge_by
  belongs_to :prefecture
  belongs_to :days_to_post

  validates :category_id,           numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id,          numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_charge_by_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id,         numericality: { other_than: 1 , message: "can't be blank"}
  validates :days_to_post_id,       numericality: { other_than: 1 , message: "can't be blank"}
  # ActiveHash関連ここまで

  validates :name,   presence: true
  validates :detail, presence: true
  validates :price,  presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  belongs_to :user
  # has_one :purchase
end
