# pictweet README
# 概要
TECH：：EXPERT短期集中コースのカリキュラム内で最初に作成した、簡易twitter型ウェブApp。  
簡易ではあるが、MVCモデルに基づいた各種機能を網羅。応用カリキュラムに入ってからは  
コメント投稿時の非同期通信を追加実装、また、単体テストを実施している。  
フロントサイドは全て用意されたものを使用。したがって本件でマークアップは実行していない。  

## デプロイ先について
　URL：  
　pwd：  
  ＊写真資料_０：  
  ①サインアップ画面  
     https://user-images.githubusercontent.com/56028886/70861364-40ab7c80-1f70-11ea-847e-4d29c9493ac7.png  
  ②ログイン画面  
     https://user-images.githubusercontent.com/56028886/70861385-7c464680-1f70-11ea-802b-33f298be72e3.png  
## example user 情報  
  
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
１）nickname（６文字以上）,email,pwdの組み合わせでvalidationを実施。  
２）tweets#index(root)ページは、application.htmlに<% if user_signed_in? %>と書き、  
ログイン時、未ログイン時の表示を分けている（ログインボタンが異なる）（＊写真資料_１）。  
  ＊写真資料_１：  
   ①ログイン状態：  
      https://user-images.githubusercontent.com/56028886/70861069-c7f6f100-1f6c-11ea-8477-d020f2cc8847.png  
   ②未ログイン状態：  
      https://user-images.githubusercontent.com/56028886/70861162-6b480600-1f6d-11ea-990e-7cdf5ef66590.png  
３)tweets_controller に before_action :move_to_index, except: [:index, :show] と記述し、  
未ログイン時に投稿しようとすると、index ページへ飛ぶように設定している。  
　（画面上では、そもそも投稿ボタンの設定自体が無い）  
## Tweet 関連（コメント投稿機能を含む）   
１）indexページの投稿写真に表示されるツイート削除ボタンについては、 renderファイルのtweet.html.erb に、  
<% if user_signed_in? && current_user.id == tweet.user_id %>と記述し、ログイン時、かつ  
投稿のuser_id が、current_userと一致する投稿にのみ、表示される設定としている。  
(＊写真資料_２）  
２）投稿した写真右下に表示されているニックネームには、user マイページへ遷移できるリンクが設定されている(＊写真資料_２）  
＊写真資料_2：  
  ①ログイン状態：  
     https://user-images.githubusercontent.com/56028886/70861293-39d03a00-1f6f-11ea-8b1c-a17323b207fd.png   
  ②未ログイン状態：   
     https://user-images.githubusercontent.com/56028886/70861329-ac411a00-1f6f-11ea-8d64-dc9ff021c97b.png  
３）投稿詳細ページ（詳細ボタンをクリックすると遷移）に、コメント投稿機能を設置。  
 ① この実装に合わせて、tweetモデルとcommentモデル（一対多）、及びuserモデルとcommentモデル（一対多）に  
 　アソシエーションを定義（詳細はDB設計をご確認お願いします）。  
 ② comments_controllerのルーティングを、tweets_controllerのルーティングの中にネストさせて、  
 　/tweets/:tweet_id/commentsというルーティングを実現、tweet_idをcommentのparamsに追加。  
 ③ show.html.erbのコメント投稿関連部分に、 <% if current_user %>　と記述し、未ログイン状態での  
 　コメント投稿ができないように設定。  
４）コメント投稿機能へ非同期通信を実装。これが初めてAppに実装した非同期通信。JS（jQuery）を用いる。  
　関連するファイルは、javascripts/comment.js。投稿データ（form_tag内のデータ）は、  
　FormDataオブジェクトに格納。  
## User 関連  
１）ユーザー登録に関するテスト（単体テスト）を実施。factory_botを活用し、以下の内容（一部抜粋）で  
テストを行う。  
  1. nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること。  
  2. nicknameが空では登録できないこと。  
  3. passwordが空では登録できないこと。  
以上です。  
 
  



