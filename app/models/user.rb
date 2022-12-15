class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]*\z/i.freeze # 英数混合
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ーＡ-Ｚａ-ｚ０-９]*\z/.freeze # 全角ひらがな、全角カタカナ、漢字、全角英数字
  VALID_NAME_READING_REGEX = /\A[ァ-ヶー－]*\z/.freeze # 全角カタカナ

  validates :password,           format: { with: VALID_PASSWORD_REGEX }
  validates :nickname,           presence: true
  validates :last_name,          presence: true, format: { with: VALID_NAME_REGEX }
  validates :first_name,         presence: true, format: { with: VALID_NAME_REGEX }
  validates :last_name_reading,  presence: true, format: { with: VALID_NAME_READING_REGEX }
  validates :first_name_reading, presence: true, format: { with: VALID_NAME_READING_REGEX }
  validates :birth_date,         presence: true
end
