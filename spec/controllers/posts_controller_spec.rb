require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "posts#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "posts#new action" do
  
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end

  end

  describe "posts#create action" do
    it "should successfully create a new post in our database" do
      post :create, params: { post: { message: 'Hello!' } }
      expect(response).to redirect_to root_path

      post = Post.last
      expect(post.message).to eq("Hello!")
    end
  end

end
