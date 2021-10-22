# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |
<!-- encrypted_passwordというカラムを記載したが、これはユーザー登録時などに入力するパスワードの意味 -->

### Association

- has_many :items
- has_many :orders
- belongs_to :card

## items テーブル

| Column | Type    | Options     |
| ------ | ------- | ----------- |
| name             | string     | null: false |
| item_description | string     | null: false |
| category_id      | integer    | null: false |
| status_id        | integer    | null: false |
| ship_cost_id     | integer    | null: false |
| ship_days_id     | integer    | null: false |
| ship_form_id     | integer    | null: false |
| price            | integer    | null: false |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :order

## buyers テーブル

| Column        | Type   | Options     |
| --------------| ------ | ----------- |
| postal_code   | string | null: false |
| prefecture_id | integer| null: false |
| city          | string | null: false |
| address       | string | null: false |
| building_name | string |
| phone_number  | string | null: false |
| order         | references | null: false, foreign_key: true |

### Association

- has_one :order

## orders テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ------------|
| user_id       | references | null: false, foreign_key: true |
| item_id       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :items
- belongs_to :buyer

## cards テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ------------|
| customer_id   | string     | null: false |
| card_id       | string     | null: false |

### Association

- belongs_to :users