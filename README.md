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

- has_many :products
- belongs_to :buyers
- belongs_to :cards

## products テーブル

| Column | Type    | Options     |
| ------ | ------- | ----------- |
| name             | string     | null: false |
| item_description | string     | null: false |
| item_status      | string     | null: false |
| shipping_cost    | string     | null: false |
| shipping_days    | string     | null: false |
| ship_form        | string     | null: false |
| price            | string     | null: false |
| user             | references | null: false, foreign_key: true |
| category         | references | null: false, foreign_key: true |
| brand            | references | foreign_key: true |

### Association

- belongs_to :users
- belongs_to :category
- belongs_to :brand

## category テーブル

| Column | Type       | Options     |
| ------ | ---------- | ------------|
| name   | string     | null: false |

### Association

- has_many :products

## brand テーブル

| Column | Type       | Options     |
| ------ | ---------- | ------------|
| name   | string     |

### Association

- has_many :products

## buyers テーブル

| Column        | Type   | Options     |
| --------------| ------ | ----------- |
| postal_code   | string | null: false |
| prefecture    | string | null: false, unique: true |
| city          | string | null: false |
| address       | string | null: false |
| building_name | string |
| phone_number  | string | null: false |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :users

## cards テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ------------|
| customer_id   | string     | null: false |
| card_id       | string     | null: false |

### Association

- belongs_to :users