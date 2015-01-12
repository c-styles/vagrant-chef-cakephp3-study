mysql_chef_gem 'default' do
  action :install
end


#MEMO mysqlクックブック使うとサービス名変更されてめんどくさい・・
# socketファイルのパス名も変わってしまうためクライアント接続も以下のようにソケット指定しないといけなくて手順めんどくさい
# １台構成ならmysqldクックブック使うほうが楽かも。。
# サーバーインストール
mysql_service 'default' do
  port '3306'
  version '5.5'
  bind_address '0.0.0.0'
  initial_root_password 'password'
  action [:create, :start]
end
# クライアントインストール
mysql_client 'default' do
  action :create
end


#TODO 上記のrootパスワードに依存するので変数利用するように修正する
#TODO ソケットファイル名を指定しないとエラーする（TCP接続できない）最初の名前を変数化して再利用可するべき
mysql_connection_info = {
  :host => "localhost",
  :username => 'root',
  :password => 'password',
  :socket => '/var/run/mysql-default/mysqld.sock'
}

#TODO data_bagsを使うべき
mysql_database_user 'dev' do
  connection mysql_connection_info
  password 'password'
  action :create
end

#TODO アプリケーションデータベースの生成
