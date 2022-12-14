# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_reading  | string  | null: false               |
| first_name_reading | string  | null: false               |
| birth_date         | date    | null: false               |
| status             | integer | null: false               |

### Association

 - has_many :items
 - has_many :favorites
 - has_many :items, through: :favorites
 - has_many :addresses
 - has_many :purchases


## addresses テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| post_code  | integer    | null: false                    |
| prefecture | string     | null: false                    |
| city       | string     | null: false                    |
| address    | string     | null: false                    |
| apartment  | string     |                                |
| status     | integer    | null: false                    |
| user_id    | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - has_many :purchases


## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| detail             | text       | null: false                    |
| category           | string     | null: false                    |
| condition          | string     | null: false                    |
| delivery_charge_by | string     | null: false                    |
| post_from          | string     | null: false                    |
| days_to_post       | string     | null: false                    |
| price              | integer    | null: false                    |
| status             | integer    | null: false                    |
| user_id            | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - has_many :favorites
 - has_many :users, through: :favorites
 - has_one :purchase


## favorites テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - belongs_to :item


## purchases テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user_id    | references | null: false, foreign_key: true |
| address_id | references | null: false, foreign_key: true |
| item_id    | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - belongs_to :address
 - belongs_to :item