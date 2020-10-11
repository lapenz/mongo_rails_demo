require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  render_views


  let(:valid_attributes) {
    { :title => "Test title!", :body => "This is a test description", :user => @current_user}
  }
  let(:valid_session) { {} }

  let(:invalid_post) { { title: nil, body: "KLSJDf LKSDJF LSKdfj SLDKFJ ", user: nil } }

  describe "responds to" do
    login_user

    it "responds to html by default" do
      post :create, params: { post: attributes_for(:post) }
      expect(response.content_type).to match "text/html"
    end

    it "responds to custom formats when provided in the params" do
      post :create, params: { post: attributes_for(:post), :format => :json }
      expect(response.content_type).to match "application/json"
    end
  end

  describe "GET #index" do
    login_user

    it "show posts" do
      post = create(:post, user: @current_user)
      get :index
      expect(response.body).to have_content post.title
    end

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

  end

  describe "GET #index without login" do

    it "has a 302 status code" do
      get :index
      expect(response.status).to eq(302)
    end

  end

  describe "GET #show" do
    login_user

    it "renders the #show view" do
      post = create(:post, user: @current_user)
      get :show, params: { id: post }
      expect(response.body).to have_content post.title
    end

    it "has a 200 status code" do
      post = create(:post, user: @current_user)
      get :show, params: { id: post }
      expect(response.status).to eq(200)
    end
  end


  describe "POST create" do
    login_user

    context "with valid attributes" do
      it "creates a new post" do
        expect{
          post :create, params: { post: attributes_for(:post) }
        }.to change(Post,:count).by(1)
      end

      it "redirects to the new post" do
        post :create, params: { post: attributes_for(:post) }
        expect(response).to redirect_to Post.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact" do
        expect{
          post :create, params: { post: attributes_for(:post, title: nil) }
        }.to_not change(Post,:count)
      end

    end
  end
  describe 'PUT update' do
    login_user

    before :each do
      @post = create(:post, title: "Lawrence", body: "Smith Alskdj ALSkdj PAOSidu AODSI", user: @current_user)

    end

    context "valid attributes" do

      it "changes @post's attributes" do
        put :update, params: {  id: @post,
            post: attributes_for(:post, title: "Larry", body: "Smith") }
        @post.reload
        expect(@post.title).to eq("Larry")
        expect(@post.body).to eq("Smith")
      end

      it "redirects to the updated contact" do
        put :update, params: { id: @post, post: attributes_for(:post) }
        expect(response).to redirect_to @post
      end
    end

    context "invalid attributes" do

      it "does not change @post's attributes" do
        put :update, params: { id: @post,
            post: attributes_for(:post, title: nil, body: nil) }
        @post.reload
        expect(@post.title).to_not eq("Larry")
        expect(@post.body).to eq("Smith Alskdj ALSkdj PAOSidu AODSI")
      end

    end
  end


  describe 'DELETE destroy' do
    login_user

    before :each do
      @post = create(:post, user: @current_user)
    end

    it "deletes the Post" do
      expect{
        delete :destroy, params: { id: @post }
      }.to change(Post,:count).by(-1)
    end

    it "redirects to posts#index" do
      delete :destroy, params: { id: @post }
      expect(response).to redirect_to posts_url
    end
  end
end
