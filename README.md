Perl Webアプリケーションのサンプル
======================

Perl Webアプリケーションのデプロイのサンプルです。

- デプロイ: Cinnamon
- アプリケーション実行環境: Plack/PSGI + Server::Starter + Starman
- スーパーバイザー: supervisord

が前提になっています。

主要なファイル
------------

- app.run
    - perlbrew 環境で start_server するためのシェルスクリプト
- config/deploy.pl
    - Cinnamon のタスク定義ファイル
- chef-repo/site-cookbooks/supervisord/templates/default/supervisord.conf.erb
    - supervisord の設定ファイル
    
Chef
----

ホスト環境のセットアップは Vagrant + Chef Solo でやってます。やってるのは

- git
- perlbrew
- Carton
- supervisord

あたりの構成ぐらい。
    
ほか
----

- ホスト名が "perlbox" である前提になってます (config/deploy.pl の中、Chef の Node オブジェクト)
- CentOS 6.3 の EPEL にある supervisord はバージョンが古いせいか supervisorctl の動作が不完全です。https://github.com/paperboy-sqale/sqale-yum/tree/master/RPMS/sl/6/x86_64/RPMS にあるやつをもらった rpm を使ってます