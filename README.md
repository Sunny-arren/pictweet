# pictweet README
# 概要
TECH::EXPERT短期集中コースのカリキュラム内で最初に作成した、簡易twitter型ウェブApp。簡易ではあるが、MVCモデルに基づいた各種機能を網羅。応用カリキュラムに入ってからはコメント投稿時の非同期通信を追加実装、また、単体テストを実施している。フロントサイドは全て用意されたものを使用。したがって本件でマークアップは実行していない。  

## デプロイ先について
URL：https://pictweet8686.herokuapp.com/    
【サインアップ画面】  
![サインアップ画面](https://user-images.githubusercontent.com/56028886/72418344-fceda200-37bd-11ea-8b47-64021e72ab65.png)  
【ログイン画面】  
![サインイン画面](https://user-images.githubusercontent.com/56028886/72418345-fceda200-37bd-11ea-9fd2-9b2b0012517a.png)  
## example user 情報  
### user1:  
email:abcdf@yahoo.co.jp  
pwd: 1234567yy  
nickname: moon  
### user2：  
email:sunlight@gmail.com  
pwd: 1234567yy  
nickname: sunny  
## バージョン情報  
 Rails 5.2.3  
 ruby 2.5.1  
  
# DB設計  
## usersテーブル  
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|nickname|string|null: false|
### Association
- has_many :tweets
- has_many :comments

## tweetsテーブル
|Column|Type|Options|
|------|----|-------|
|image|text||
|text|text||
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- has_many :comments

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|tweet_id|integer|null: false, foreign_key: true|
### Association  
- belongs_to :tweet  
- belongs_to :user  
  
# 機能  
## ログイン関係（gem 'devise'を利用）  
1)nickname（6文字以上）,email,pwdの組み合わせでvalidationを実施。  
2)tweets#index(root)ページは、application.htmlに<% if user_signed_in? %>と書き、ログイン時、未ログイン時の表示を分けている（ログインボタンが異なる）。  
①ログイン状態：  
![ログイン状態](https://user-images.githubusercontent.com/56028886/72418346-fceda200-37bd-11ea-97c2-d3598f45d528.png)  
②未ログイン状態：  
![未ログイン状態](https://user-images.githubusercontent.com/56028886/72418348-fceda200-37bd-11ea-9e22-066178857fd6.png)  
3)tweets_controller に before_action :move_to_index, except: [:index, :show] と記述し、未ログイン時に投稿しようとすると、index ページへ飛ぶように設定している。（画面上では、そもそも投稿ボタンの設定自体が無い）  
## Tweet 関連（コメント投稿機能を含む）   
1)indexページの投稿写真に表示されるツイート削除ボタンについては、 renderファイルのtweet.html.erb に、<% if user_signed_in? && current_user.id == tweet.user_id %>と記述し、ログイン時、かつ投稿のuser_id が,current_userと一致する投稿にのみ、表示される設定としている。  
【ログイン状態（ユーザ自身の投稿）】  
![ログイン状態（ユーザー自身の投稿）](https://user-images.githubusercontent.com/56028886/72418636-8b622380-37be-11ea-9000-1b7fca661cf5.png)  

2)投稿した写真右下に表示されているニックネームには、user マイページへ遷移できるリンクが設定されている。  
【未ログイン状態】   
![未ログイン状態（投稿）](https://user-images.githubusercontent.com/56028886/72418638-8bfaba00-37be-11ea-881d-018af1261768.png)  

3)投稿詳細ページ（詳細ボタンをクリックすると遷移）に、コメント投稿機能を設置。  
①この実装に合わせて、tweetモデルとcommentモデル（一対多）、及びuserモデルとcommentモデル（一対多）にアソシエーションを定義（詳細はDB設計をご確認お願いします）。  
②comments_controllerのルーティングを、tweets_controllerのルーティングの中にネストさせて、/tweets/:tweet_id/commentsというルーティングを実現、tweet_idをcommentのparamsに追加。  
③show.html.erbのコメント投稿関連部分に、 <% if current_user %> と記述し、未ログイン状態でのコメント投稿ができないように設定。  
4)コメント投稿機能へ非同期通信を実装。これが初めてAppに実装した非同期通信。JS（jQuery）を用いる。関連するファイルは、javascripts/comment.js。  
投稿データ（form_tag内のデータ）は、FormDataオブジェクトに格納。  
## User 関連  
１）ユーザー登録に関するテスト（単体テスト）を実施。factory_botを活用し、以下の内容（一部抜粋）で  
テストを行う。  
①nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること。  
②nicknameが空では登録できないこと。  
③passwordが空では登録できないこと。  
  
以上です。  
 
  



