# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# carrot-bookers2

Template is missing programs.<br>
<br>

-- Before rails s --
<br>
* 1*cannot commmand rails s(syntax error,unexpected end-of-input,expecting end)<br>
    routes.rb → do~end<br>
   *config.host don't match<br>
    add at development.rb, past one go to comment<br>
   *Migration is pending(ActiveRecord::PendingMigrationError)<br>
    rails db:migrate RAILS_ENV=development
<br>

-- After rails s, Log in page --
<br>
* 2*SyntaxError<br>
   users_controller.rb → put end on index-action

* 3*cannot launch page<br>
   routes.rb → change the order(primary:  devise_for :user)

* 4*Webpacker::Manifest::MissingEntryError in<br>
   rails assets:precompile<br>
   *check bootstrap<br>
   yarn add jquery bootstrap@4.5 popper.js<br>
   check js files(webpack/environments.js)(stylesheets/application.scss)(packs/application.js)<br>

* 5*cannot display except header<br>
   application.html.erb → yield-tag(next to flashmessage)<br>
<br>

-- Before sign up --
<br>
* 6*cannot jump to home or about<br>
   AppCon → add except[:top, :about] to before_action

* 7*NameError in Homes#top<br>
   rails routes → new_user_session_path, new_user_registration_path(change at top.html)<br>
<br>

-- Sign up(on time) --
<br>
* 8*NoMethodError undefined method 'name-field'<br>
   registrations/new → change to text_field

* 9*cannot sign-up (display: book must exist)<br>
   association → has_many :books,dependent: :destroy  //  belongs_to :user<br>
                 
* 10*after sign-up, jump to top-page<br>
    after_sign_path_for → change path to user_path(resource)<br>
<br>

-- users/index --
<br>
* 11*Missing Template
    not users, 'books/form'

* 12*cannot display by bootstrap(side by side)
    copy style like users/show(container,row,col)
<br>

-- users/edit --
<br>
* 13*define errors at edit-action → @user=User.find(params[:id])<br>
　　 *not exist column'title' → change title to name on edit-action

* 14*get url /user.1<br>
    update-action → redirect_to user_path(@user)

* 15*decide render-action → render :edit (at update-action)
<br>

-- books/index --
<br>
* 16*cannot send data by form(did you define @books and @book?)<br>
    @book=Book.new (index-action)

* 17*missing error-message<br>
    add to books/index.show,users/index.show → <%= render 'layouts/errors', obj: @book %>

* 18*when fill form and enter, appear "Body can't blank"<br>
    permit body at strong-parameter(BookCon)
<br>   

-- books/show --
<br>
* 19*NameError in Books#show, undefined local variable or method'user'<br>
    add argument at render → <%= render 'users/info', user: @user %>

* 20*NoMethodError in Books#show, undefined method 'get_profile_image' for ....<br>
    user.rb → has_one_attached :profile_image // get_profile_image method 

* 21*change form edit to new<br>
    take empty-model → @new_book=Book.new(BookCon)<br>
    take this value → <%= render 'users/list', user: @user ,book: @new_book %> (at books/show)

* 22*cannot delete submitted-book<br>
    fix miss → @book→book, book.destroy (at destroy-action)
<br>

-- others --
<br>
* 23*when edit user-data, cannot validate column'introduction'<br>
    add → validates :introduction, length:{maximum:50}

* 24*must not edit other-user's profile<br>
    add edit → before_action :ensure_correct_user, only: [:update]

* 25*show edit&destroy, if submitted-user is log-in-user<br>
    pick → <% if @user == current_user %>...button(edit,destroy)...<% end %>  (on books/show)

* 26*cannot display error-message, when book-edit is failure<br>
    add to books/edit → <%= render 'layouts/errors', obj: @book %>

* 27*must not link_to other-user's book-edit<br>
    fix → <%= link_to edit_user_path(user), class: "btn btn-outline-secondary btn-block edit_user_#{user.id}" do %><...><% end %><br>
    (at users/_info.html.erb)<br>


# +α like_it/comment_function

-- Like it --
* create model<br>
   rails g model Favorite user_id:integer book_id:integer<br>
   → rails db:migrate
   
* association 3model<br>
  user<favorite  book<favorite <br>
  add each other (belongs_to // has_many dependent: :destroy)
  
* favorited_by method at book.rb

* resource add at routing<br>
caution! → I use original-route to create/destroy<br>
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'<br>
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'

* create controller<br>
  rails g controller favorites
  
* write before-action, create/destroy-action, strong-parameter

* write on books/index,show(where want to display like-it)<br>
  location: into each(example is without <>)<br>
  div id="likes_buttons_<%= post.id %>"<br>
   %= render partial: 'favorites/favorite', locals: {book: book} %  ←formal template<br>
  /div
 
* template(create _favorites.html.erb) <br>
  elements: if user_signed_in? // current_user.favorited_by? // book.favorites.count<br>
    // remote: true →→ create js.erb to catch response

* create create(destroy).js.erb in favorites-folder<br>
  ex) alert('いいねが出来ている')<br>
  $('#favorites_buttons_<%= @book.id %>').html("<%= j(render partial: 'favorites/favorite', locals: {book: @book}) %>");

* add jquery on Gemfile, require jquery(set) on application.js

<br>
-- comment --

* create model<br><br>
  rails g model book_comment comment:text user_id:integer book_id:integer<br>

* association 3model<br>
  user<book_comment book<book_comment

* create controller<br>
  rails g controller BookComments

* write create&destroy action on BookComCon<br>
  comment = current_user.book_comments.new(book_comment_params)<br>
  comment.book_id = book.id<br>
  comment.save<br>
  redirect_to request.referer<br>

  def destroy<br>
  BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy<br>
  redirect_to request.referer<br>
  end<br>

* add instance&method on BookCon<br>
  before_action :authenticate_user!<br>
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]<br>

  @book_comment = BookCommnet.new<br>

  def ensure_correct_user<br>
  @book = Book.find(params[:id])<br>
  unless @book.user == current_user<br>
  redirect_to books_path<br>
  end<br>
  end<br>

* book_comment.rb<br>
  validates :comment, presence: true<br>

* write on books/index,show
  コメント数: <%= book.book_comments.count %><br>

* add routing(while resources :book...do~end)<br>
  resources :book_comments,only: [:create, :destroy]<br>

* create template(book_comments/_form)<br>
  <%= form_with(model:[book, book_comment], local: true) do |f| %><br>
  <%= f.text_area :comment, rows:'5',placeholder: "コメントをここに", class: "w-100" %><br>
  <%= f.submit "送信する", class: "btn btn-lg btn-base-1 mt-20 pull-right" %><br>
  <% end %>

* write book_comments/_index

* rewrite books/_index

* rewrite books/show

* change render to normal users/show


# followed/follower_function

* create model<br>
  rails g model Relationship follower_id:integer followed_id:integer<br>
  rails db:migrate

* add at relationship.rb(recognize which user to find)<br>
  belongs_to :follower, class_name: "User"<br>
  belongs_to :followed, class_name:"User"

* add at user.rb

* + following, followed relation<br>
   has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy<br>
   has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

* + use at index<br>
   has_many :followings, through: :relationships, source: :followed<br>
   has_many :followers, through: :reverse_of_relationships, source: :follower

* + follow process<br>
   def follow(user_id)<br>
    relationships.create(followed_id: user_id)<br>
   end<br>

* + remove follow process<br>
   def unfollow(user_id)<br>
   relationships.find_by(followed_id: user_id).destroy<br>
   end<br>

* + judge follow or not<br>
   def following?(user)<br>
   followings.include?(user)<br>
   end<br>

* create controller<br>
  rails g controller relationships followings followers<br>

* add at relationships_controller.rb<br>

* + following<br>
   def create<br>
   current_user.follow(params[:user_id])<br>
   redirect_to request.referer<br>
   end<br>

* + remove follow<br>
   def destroy<br>
   current_user.unfollow(params[:user_id])<br>
   redirect_to request.referer<br>
   end<br>

* + following-list<br>
   def followings<br>
   user = User.find(params[:user_id])<br>
   @users = user.followings<br>
   end<br>

* + follower-list<br>
   def followers<br>
   user = User.find(params[:user_id])<br>
   @users = user.followers<br>
   end<br>

* add >>>routing<br>

* + nest<br>
   resources :users do<br>
   resource :relationships, only: [:create, :destroy]<br>
   get 'followings' => 'relationships#followings', as: 'followings'<br>
   get 'followers' => 'relationships#followers', as: 'followers'<br>
   end

* add at Views<br>
  フォロー数: <%= user.followings.count %><br>
  フォロワー数: <%= user.followers.count %><br>

  <% unless current_user == user %><br>
  <% if current_user.following?(user) %><br>
   <%= link_to "フォロー外す", user_relationships_path(user.id), method: :delete %><br>
  <% else %><br>
   <%= link_to "フォローする", user_relationships_path(user.id), method: :post %><br>
  <% end %><br>

* write _follow_list.html.erb<br>
  <% if users.exists? %><br>
  <% users.each do |user| %><br>
  table <thead <tr <th name /th> <th /th> <th /th> /tr> /thead> <br>
  <tbody <tr <td<br>
  <%= user.name %> td><br>
  <td フォロー数: <%= user.followings.count %> /td><br>
  <td フォロワー数: <%= user.followers.count %> /td><br>
  /tr /tbody /table  % end % <br>
   % else %  p ユーザーはいません /p  % end % <br>
   % end %<br>
   
  
 # Search_function
 
* create controller<br>
  rails g controller searches
  
* define search-action on SearchCon(conditional branch)
* + search-model→ params[:range]、method→ params[:search]、word→ params[:word]<br>  
  def search<br>
   @range = params[:range]<br>
    if @range == "User"<br>
      @users = User.looks(params[:search], params[:word])<br>
    else<br>
      @books = Book.looks(params[:search], params[:word])<br>
    end<br>
  end<br>
  end<br>
  
* add at routing  <br>
  get 'search' => 'searches#search'
  
* add render on Application.html.erb(above the yield)<br>
  <div class="d-flex justify-content-center mb-2"><br>
    <%= render 'searches/form' %>  <br>
  </div><br>

* create template(searches/_form)
* + conditional branch<br>
  (f.text_field :word)<br>
  (f.select :range)<br>
  (f.select :search)<br>

* write define on each model(user,book)(search-method-branch)<br>
  perfect,forward,backward,partial<br>

* + user.rb<br>
  def self.looks(search, word)<br>
    if search == "perfect_match"<br>
      @user = User.where("name LIKE?", "#{word}")<br>
    elsif search == "forward_match"<br>
      @user = User.where("name LIKE?","#{word}%")<br>
    elsif search == "backward_match"<br>
      @user = User.where("name LIKE?","%#{word}")<br>
    elsif search == "partial_match"<br>
      @user = User.where("name LIKE?","%#{word}%")<br>
    else<br>
      @user = User.all<br>
    end<br>
  end<br>
  
* + book.rb <br>
  def self.looks(search, word)<br>
    if search == "perfect_match"<br>
      @book = Book.where("title LIKE?","#{word}")<br>
    elsif search == "forward_match"<br>
      @book = Book.where("title LIKE?","#{word}%")<br>
    elsif search == "backward_match"<br>
      @book = Book.where("title LIKE?","%#{word}")<br>
    elsif search == "partial_match"<br>
      @book = Book.where("title LIKE?","%#{word}%")<br>
    else<br>
      @book = Book.all<br>
    end<br>
  end

* write view(searches/search_result)※remove<><br>
  h2 Results index /h2<br>

  table class="table table-hover table-inverse"<br>
  --検索対象モデルがUserの時 --<br>
  % if @range == "User" %<br>
    tbody<br>
      % @users.each do |user| %<br>
        tr<br>
          td %= user.name % /td <br>
        /tr<br>
      % end %<br>
    /tbody<br>
  % else %<br>
  
   --検索対象モデルがUserではない時(= 検索対象モデルがBookの時) --<br>
    tbody<br>
      % @books.each do |book| %<br>
        tr<br>
          td %= book.title % /td<br>
          td %= book.body % /td<br>
        /tr<br>
      % end %<br>
    /tbody<br>
  % end %<br>
  /table<br>
  
# Why cannot change comment-function to Ajax?

-- checking flow --<br>
* book_comments/_form → local: false<br>
 →ok
* book_comments_controller → have any elements of HTML<br>
  redirect_to, format.html etc.<br>
  →ok
* view(write about book_comment → books/show, _index) → compare with js(create/destroy)<br>
  $('.book-comments-index').html("<%= j(render 'book_comments/index', { book: @comment.book}) %>")<br>
   　　　　　　　　　　　　　　　↓<br>
  $(' class-or-id / range '). change-type ("<%= j(render 'want-to-change-this-file ', { argument }) %>")<br>
  →warning!!<br>
  →unify these, class or id.<br>
  class-tag →　$(' .~~~~~ ')<br>
  id-tag → $(' #~~~~~ ')<br>

  →All clear!!<br>
