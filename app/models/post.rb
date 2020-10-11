class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String

  validates_presence_of :title
  validates_presence_of :body
  validates_uniqueness_of :title

  belongs_to :user


end
