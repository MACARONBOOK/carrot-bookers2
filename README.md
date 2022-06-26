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
* 23*

* 24*

* 25*

* 26*

* 27*

