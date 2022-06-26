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
* 11*

* 12*

-- users/edit --
<br>
* 13*

* 14*

* 15*

-- books/index --
<br>
* 16*

* 17*

* 18*

-- books/show --
<br>
* 19*

* 20*

* 21*

* 22*

-- others --
<br>
* 23*

* 24*

* 25*

* 26*

* 27*

