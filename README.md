# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| password           | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_reading  | string  | null: false               |
| first_name_reading | string  | null: false               |
| birth_date         | date    | null: false               |

### Association

 - has_many :items
 - has_many :addresses
 - has_many :purchases


## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| apartment     | string     |                                |
| user_id       | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - has_many :purchases


## items テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| name                  | string     | null: false                    |
| detail                | text       | null: false                    |
| category_id           | integer    | null: false                    |
| condition_id          | integer    | null: false                    |
| delivery_charge_by_id | integer    | null: false                    |
| prefecture_id         | integer    | null: false                    |
| days_to_post_id       | integer    | null: false                    |
| price                 | integer    | null: false                    |
| user_id               | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - has_one :purchase


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