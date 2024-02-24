CREATE TABLE test.users
(
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ユーザーID',
    username VARCHAR(50) NOT NULL COMMENT 'ユーザー名',
    email VARCHAR(100) NOT NULL COMMENT 'メールアドレス',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'レコード作成日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'レコード更新日時'
)
COMMENT 'ユーザー情報を格納するテーブル';

CREATE TABLE test.products
(
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '商品ID',
    name VARCHAR(100) NOT NULL COMMENT '商品名',
    price DECIMAL(10, 2) NOT NULL COMMENT '価格',
    description TEXT COMMENT '商品説明',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '登録日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
)
COMMENT '商品情報を格納するテーブル';

CREATE TABLE test.orders
(
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '注文ID',
    user_id INT NOT NULL COMMENT 'ユーザーID',
    product_id INT NOT NULL COMMENT '商品ID',
    quantity INT NOT NULL COMMENT '数量',
    order_date DATE COMMENT '注文日',
    status ENUM('pending', 'completed', 'cancelled') DEFAULT 'pending' COMMENT '状態',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '注文日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
)
COMMENT '注文情報を格納するテーブル';

CREATE TABLE test.categories
(
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'カテゴリID',
    name VARCHAR(50) NOT NULL COMMENT 'カテゴリ名',
    description TEXT COMMENT 'カテゴリ説明',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '登録日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
)
COMMENT 'カテゴリ情報を格納するテーブル';

CREATE TABLE test.comments
(
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'コメントID',
    user_id INT NOT NULL COMMENT 'ユーザーID',
    product_id INT NOT NULL COMMENT '商品ID',
    comment TEXT NOT NULL COMMENT 'コメント内容',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'コメント日時',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
)
COMMENT 'コメント情報を格納するテーブル';

ALTER TABLE test.orders
ADD CONSTRAINT fk_orders_users
FOREIGN KEY (user_id) REFERENCES test.users(id);

ALTER TABLE test.orders
ADD CONSTRAINT fk_orders_products
FOREIGN KEY (product_id) REFERENCES test.products(id);

ALTER TABLE test.comments
ADD CONSTRAINT fk_comments_users
FOREIGN KEY (user_id) REFERENCES test.users(id);

ALTER TABLE test.comments
ADD CONSTRAINT fk_comments_products
FOREIGN KEY (product_id) REFERENCES test.products(id);
