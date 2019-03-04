# Welcome to Recipe application.
Recipe application you can see all recipes created by all users. With recipe app you can:
-  Anyone can sign up with email and password
-  If user signed in can create recipe
-  User can sign in with facebook
-  Create recipe with title, description, categories, directions,ingredients, image
-  Edit recipe if belongs to user()
-  Delete recipe if belongs to user
-  Show all recipe info on recipe show page
-  User can see categories on navbar and select one see belongings
-  User can see all comments even if not signed in
-  User can comment on recipe show page
-  User can delete comment
-  All edit, delete buttons restricted except belonging user
-  User do search and find recipes
-  User can edit his/her profile.

I have used some gems to build the project and here is:
```
gem 'devise', '~> 4.5'
gem 'sass-rails', '~> 5.0'
gem 'jquery-rails'
gem 'image_processing', '~> 1.7', '>= 1.7.1'
gem 'bootstrap', '~> 4.1', '>= 4.1.3'
gem 'ratyrate'
gem 'cocoon', '~> 1.2', '>= 1.2.12'
gem 'ransack', '~> 2.1'
gem 'omniauth-facebook'
```

To clone project please copy [link](https://github.com/rahymov/recipe_portfolio.git):
`https://github.com/rahymov/recipe_portfolio.git`
Then `bunlde install` and `rails db:migrate` or `rake db:migrate`.
If you are working on google chrome maybe you will need ssl certificate. In my project there is certificate and key. When you run `rails s` you can check on what port ssl listening.
Thank you.
