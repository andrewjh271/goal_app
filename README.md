# Goal App

Created as part of the App Academy [curriculum](https://open.appacademy.io/learn/full-stack-online/rails/goal-app).

### Thoughts

The main point of this project was to test it. Nothing in the implementation was new except for the minor task at the end of making a Concern  for the polymorphic `comments` association that `User` and `Goal` models could share.

I created this method in `spec/spec_helper.rb` to mock logging in:

```ruby
def login(user)
  allow_any_instance_of(ApplicationController).to receive(:current_user) { user }
end
```

Using FactoryBot and Faker was cool, but it took some trial and error to get the syntax right for FactoryBot.

In many of my tests I used a `before(:all)` hook to create models and save them to the database. I eventually realized I was filling my test database with a lot of data and not starting tests with a clean slate (this was generally not causing immediate issues with duplicate entries becuase the hook was using FactoryBot to create random data.) I added an `after(:all)` hook to destroy the test data, but this was not foolproof (errors or debugging could end up prematurely terminating a test before the `after(:all)` hook). I learned that `before` hooks are not part of the test transaction because they happen before and independent of the example, so are not rolled back. My guess is that this is not the best way to implement what I needed. In `goals_controller_spec.rb` and `comment_spec.rb` I switched to using `let` to define memoized helper methods. This seems much more robust, but has the disadvantage of recreating data for each example rather than just once at the beginning of a group.

###### Polymorphism

Part of the project was implementing `comments` in two ways, but keeping the tests from the first time around. The first implementation involved creating models, controllers, and views for both `UserComments` and `GoalComments`. The second was letting `Comments` be shared by both users and goals with a polymorphic association. The migration for this change involved creating the new `comments` table, migrating data to it, then dropping the old tables. I chose the name `subject` for the association, but should have chosen `commentable`. (I actually considered it, but found it too awkward.) It wasn't until reading about Concerns that I realized how idiomatic it is to use names like `commentable`. 

###### Capybara

I knew going in that `feature` and `scenario` are the capybara aliases for `describe` and `it`, but I was unaware until looking at the App Academy solution that `given` and `backround` are capybara aliases for `let` and `before`.

I didn't end up using `save_and_open` while debugging, but I would like to remember it exists.

-Andrew Hayhurst