
# Vagrant
## プラグイン環境

インストール必須プラグイン
```
vagrant plugin install vagrant-hostsupdater
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-berkshelf
```

インストール推奨プラグイン
```
vagrant plugin install vagrant-cachier
```

# ChefDK

Berkshelfを利用する為にインストール


# Cookbook
## users
```
dev.json
openssl passwd -1 "password"
dev:password
```
を生成
