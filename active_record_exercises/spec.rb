# SOME SETUP (ignore this part, start below)
require 'active_record'
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

# require 'logger'
# ActiveRecord::Base.logger = Logger.new $stdout
# ActiveSupport::LogSubscriber.colorize_logging = false


ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users do |t|
    t.string :name
  end

  create_table :posts do |t|
    t.string  :name
    t.string  :caption
    t.text    :body
    t.integer :user_id
  end
end

RSpec.configure do |config|
  config.around :each do |spec|
    ActiveRecord::Base.transaction do
      spec.call
      raise ActiveRecord::Rollback
    end
  end
end


class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end

# THE SPECS (start here)
describe 'creating active record instances' do
  let(:user_name) { 'Some user name' }
  let(:post_name) { 'Some post name' }
  let(:caption)   { 'Some caption'   }
  let(:body)      { 'Lorem ipsum dolor sit amet, consectetur adipisicing elit...' }

  def post_has_expected_attributes(post)
    expect(post.body    ).to eq body
    expect(post.caption ).to eq caption
    expect(post.name    ).to eq post_name
  end


  specify "instantiate a post, but don't save it" do
    post = ??

    post_has_expected_attributes post
    expect(post).to be_a_new_record
  end

  specify 'instantiate a post and save it without using #save' do
    user = User.create
    post = ??

    post_has_expected_attributes post
    expect(post).to be_persisted
  end

  specify 'create a user and create a post for them without referencing the Post class' do
    user = User.create name: user_name
    post = ??

    post_has_expected_attributes post
    expect(post.user  ).to eq user
    expect(user.posts ).to eq [post]
    expect(post       ).to be_persisted
  end

  specify 'instantiate a post and build it a user without saving or referencing the Post class' do
    user = User.new name: user_name
    post = ??

    post_has_expected_attributes post
    expect(post).to be_a_new_record
    expect(user).to be_a_new_record

    user.save!
    expect(post.user   ).to eq user
    expect(user.posts  ).to eq [post]
  end

  specify 'build the post with block style' do
    user = User.new do |u|
      ??
    end

    expect(user.name       ).to eq user_name
    expect(user            ).to be_a_new_record
    expect(user.posts.size ).to eq 1
    post_has_expected_attributes user.posts.first
  end
end


describe 'with 10 users and 100 posts' do
  before :all do
    10.times do |i|
      User.create! name: "user #{i}" do |user|
        10.times do |j|
          post_number = i * 10 + j
          user.posts.build name: "post #{post_number}", caption: "caption #{post_number}", body: "body #{post_number}"
        end
      end
    end
  end

  after :all do
    User.delete_all
    Post.delete_all
  end

  specify 'count the users and posts' do
    user_count = ??
    post_count = ??

    expect(user_count).to eq 10
    expect(post_count).to eq 100
  end

  specify 'find all the users' do
    users = ??
    expect(users.pluck :id).to eq (1..10).to_a
  end

  specify 'find all the posts' do
    posts = ??
    expect(posts.pluck :id).to eq (1..100).to_a
  end

  specify 'find a specific user' do
    user8 = ??
    expect(user8.id).to eq 8
  end

  specify 'the first 5 posts (limit)' do
    first5 = ??
    expect(first5.pluck :id).to eq (1..5).to_a
  end

  specify 'the second 5 posts (limit, offset)' do
    second5 = ??
    expect(second5.pluck :id).to eq (6..10).to_a
  end

  specify 'the 5 newest posts (limit, order)' do
    last5 = ??
    expect(last5.pluck :id).to eq (96..100).to_a.reverse
  end

  specify 'users where the name is in "user 2", "user 3", "user 5", "user 7" (where)' do
    usernames   = ['user 2', 'user 3', 'user 5', 'user 7']
    prime_users = ??
    expect(prime_users.pluck :name).to eq usernames
  end

  specify 'count the number of posts whose name has a 1 in it (where, count)' do
    post_count = ??
    expect(post_count).to eq 19
  end

  specify 'the post whose name is "post 45" (where, first)' do
    post = ??
    expect(post.name).to eq 'post 45'
  end

  specify "user5's first three posts, without referencing Post (association, limit)" do
    user5 = User.find 5
    posts = ??
    expect(posts.pluck :id).to eq [41, 42, 43]
  end

  specify "user5's three most recent posts (most recent first), without referencing Post (association, limit, order)" do
    user5 = User.find 5
    posts = ??
    expect(posts.pluck :id).to eq [50, 49, 48]
  end

  specify "the first three users and their most recent post name (limit, includes+map)" do
    # you'll need to map over the users, but use includes so that
    # you don't have to make a separate database query for each user's posts as you map
    users_and_posts = ??
    expect(users_and_posts).to eq [
      ['user 0', ['post 0',  'post 1']],
      ['user 1', ['post 10', 'post 11']],
      ['user 2', ['post 20', 'post 21']],
    ]
  end

  # you'll need to go back up and implement this
  # REMEMBER: USE "?" FOR VALUES TO INTERPOLATE INTO THE QUERY
  describe 'Post.with_caption_including' do
    it 'is implemented' do
      # nothing for you to do here,
      # we're checking that with_caption_including is implemented correctly
      posts = Post.with_caption_including('2')
      expect(posts.pluck :id).to eq [3, 13, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 33, 43, 53, 63, 73, 83, 93]
    end

    specify 'second 5 posts with caption including "2"' do
      posts = ??
      expect(posts.pluck :id).to eq [24, 25, 26, 27, 28]
    end

    specify "a user's posts that contain the caption '3', using with_caption_including, without referencing the Post constant" do
      user1  = User.find 1
      user2  = User.find 2
      posts1 = ??
      posts2 = ??
      expect(posts1.pluck :caption).to eq ['caption 3']
      expect(posts2.pluck :caption).to eq ['caption 13']
    end
  end

  describe 'Post.without_caption_including' do
    it 'is implemented' do
      # nothing for you to do here,
      # we're checking that with_caption_including is implemented correctly
      posts = User.first.posts.without_caption_including('2')
      expect(posts.pluck :id).to eq [1, 2, 4, 5, 6, 7, 8, 9, 10]
    end

    specify 'posts with caption including "1", without caption including "2"' do
      posts = ??
      expect(posts.pluck :id).to eq [2, 11, 12, 14, 15, 16, 17, 18, 19, 20, 32, 42, 52, 62, 72, 82, 92]
    end
  end

  # You are going to need to edit the schema and the classes
  # to make this work
  # http://guides.rubyonrails.org/association_basics.html
  describe 'favouriting posts' do
    let(:author1) { User.find 1 }

    let(:reader1) { User.find 2 }
    let(:reader2) { User.find 3 }
    let(:reader3) { User.find 4 }

    specify 'a post can find the users who favourited it' do
      post = Post.first
      post.favourited_by << reader1
      post.favourited_by << reader3
      expect(post.reload.favourited_by).to eq [reader1, reader3]
    end

    specify 'a user can find their favourite posts' do
      post1 = Post.first
      post2 = Post.last
      reader1.favourite_posts << post1
      reader1.favourite_posts << post2
      expect(reader1.favourite_posts).to eq [post1, post2]
    end

    specify "can find an author's fans: who has favourited thier posts" do
      author1.posts.first.favourited_by << reader1
      author1.posts.last.favourited_by  << reader2
      expect(author1.fans).to eq [reader1, reader2]
    end
  end

  # you'll need to go add validations for these
  describe 'validations' do
    specify 'a post is invalid if its name is blank' do
      post = Post.new(name: 'name', caption: 'caption', body: 'body', user: User.find(1))
      expect(post).to be_valid

      post = Post.new(name: nil, caption: 'caption', body: 'body', user: User.find(1))
      expect(post).to_not be_valid

      post = Post.new(name: '', caption: 'caption', body: 'body', user: User.find(1))
      expect(post).to_not be_valid
    end

    specify 'a post is invalid if its name mentions "fork"' do
      post = Post.new(name: 'name', caption: 'caption', body: 'body', user: User.find(1))
      expect(post).to be_valid

      post.name = 'Eat salad with a fork!'
      expect(post).to_not be_valid

      post.name = 'EAT SALAD WITH A FORK!'
      expect(post).to_not be_valid
      expect(post.errors[:name]).to eq ['No dinnerware conversation!']
    end

    specify 'use a transaction to prevent a post from saving' do
      # check out the docs at http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/DatabaseStatements.html#method-i-transaction

      initial_count = Post.count
      expect {
        Post.create!(name: 'name', caption: 'caption', body: 'body', user: User.first)
        expect(Post.count).to eq initial_count+1
        raise 'An error!'
      }.to raise_error
      expect(Post.count).to eq initial_count
    end

    specify 'a post is not valid unless it has a user', t:true do
      post = Post.new(name: 'name', caption: 'caption', body: 'body', user: User.find(1))
      expect(post).to be_valid
      post = Post.new(name: 'name', caption: 'caption', body: 'body', user_id: 1)
      expect(post).to be_valid
      post = Post.new(name: 'name', caption: 'caption', body: 'body')
      expect(post).to_not be_valid
    end
  end
end
