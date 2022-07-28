# nagano-cake


## ≪ながのCAKE≫の商品を通販するためのECサイト。
                            
                            
                                   
### 概要


##### _Customer_

・会員登録・編集・退会


・商品の閲覧・カートに入れる・注文


・ジャンル検索


・注文履歴の確認


#### _Admin_

・ジャンル登録・編集・非表示選択


・商品の登録・編集・削除・非表示選択


・注文履歴の確認・進捗ステータスの変更


・会員情報の確認・編集




### 機能


・deviceを使用したログイン機能


・paranoiaを使用した論理削除の実装


・gemを使用せず顧客側、管理者側の双方実装



### インストール


$ git clone git@github.com:team-Meat/nagano-cake.git


$ cd nagano-cake


$ rails db:migrate


$ rails db:seed


$ bundle install



### 使い方


　管理者ログインはメールアドレスを【admin@admin】、パスワードは【testtest】で使用できます。 　
 
 
 顧客側の場合、新規作成で好きなアカウントを作成しても利用が可能です。




### バージョン

rails', '~> 6.1.4.1' 　ruby 2.6.3
