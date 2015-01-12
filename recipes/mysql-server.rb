mysql_chef_gem 'default' do
  action :install
end


#MEMO mysqlクックブック使うとサービス名変更されてめんどくさい・・
# socketファイルのパス名も変わってしまうためクライアント接続もどうしていいかわからないので一度やめた
# サーバーインストール
#mysql_service 'default' do
#  port '3306'
#  version '5.5'
#  bind_address '0.0.0.0'
#  initial_root_password 'password'
#  action [:create, :start]
#end
# クライアントインストール
#mysql_client 'default' do
#  action :create
#end

# シンプルなレシピ使う
#TODO Vagrantfileのchef.json使うのをやめるようLWRPにするかnodeで扱うかどちらかにする
include_recipe 'mysqld::default'

#TODO 上記のrootパスワードに依存するので変数利用するように修正する
mysql_connection_info = {:host => "localhost",
  :username => 'root',
  :password => 'password'}

#TODO data_bagsを使うべき
mysql_database_user 'dev' do
  connection mysql_connection_info
  password 'password'
  action :create
end

#TODO アプリケーションデータベースの生成
