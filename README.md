gem 'webpacker', github: 'rails/webpacker'
bundle install

rails new myapp --webpack=vue

webpacker のインストール
rails webpacker:install

Vue.js のインストール
rails webpacker:install:vue

= javascript_pack_tag 'hello_vue'

app/javascript/packs/hello_vue.js
import Vue from 'vue'
import App from './app.vue'

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('hello'))
  const app = new Vue(App).$mount('hello')

  console.log(app)
})


JS ファイルのコンパイル
bin/webpack-dev-server

+ import Vue from 'vue/dist/vue.esm'

+ const app = new Vue({
+    el: '#hello',
+    data: {
+      message: "Can you say hello?"
+    }
+ })

html を操作する場合は、vue ではなくて vue/dist/vue.esm を　import する必要がある。
+ import Vue from 'vue/dist/vue.esm'

ダミーデータの作成
gem 'faker'

seed.rb
20.times do
  Book.create(
    title: Faker::Book.title,
    author: Faker::Book.author,
    publisher: Faker::Book.publisher,
    genre: Faker::Book.genre
  )
end

rake db:seed

API の作成

routes.rb
Rails.application.routes.draw do
  root to: 'page#home'

  resources :books, only: %i(index)

+ namespace :api do
+   resources :books, only: %i(show)
+ end
end

app/controllers/api/books_controller.rb
class Api::BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end

app/views/api/books/show.json.jbuilder
json.title     @book.title
json.author    @book.author
json.publisher @book.publisher
json.genre     @book.genre

Ajax で GET しよう！
 yarn add axiosa
