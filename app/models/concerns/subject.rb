# I created the polymorphic association before realizing how much more idiomatic
# it would have been (especially once using a Concern) to say Commentable
# Next time.

# https://dev.to/software_writer/how-rails-concerns-work-and-how-to-use-them-gi6

module Subject extend ActiveSupport::Concern
  included do
    has_many :comments, as: :subject
  end
end