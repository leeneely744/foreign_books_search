# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '3.18.240.13', user: 'kohei', roles: %w{app db web} 

#デプロイするサーバーにsshログインする鍵の情報を記述
set :ssh_options, keys: '~/.ssh/foreignbookssearch_key_rsa ' 