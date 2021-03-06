require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "posts#destroy action" do
    it "shouldn't allow users who didn't create the post to destroy it" do
      post = FactoryBot.create(:post)
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: post.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users destroy a post" do
      post = FactoryBot.create(:post)
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow a user to destroy posts" do
      post = FactoryBot.create(:post)
      sign_in post.user
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to root_path
      post = Post.find_by_id(post.id)
      expect(post).to eq nil
    end

    it "should return a 404 message if we cannot find a post with the id that is specified" do
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: 'EXAMPLEPOST' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "posts#update action" do

    it "shouldn't let users who didn't create the post update it" do
      post = FactoryBot.create(:post)
      user = FactoryBot.create(:user)
      sign_in user
      patch :update, params: { id: post.id, post: { message: 'wahoo' } }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users update a post" do
      post = FactoryBot.create(:post)
      patch :update, params: { id: post.id, post: { message: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end


    it "should allow users to successfully update posts" do
      post = FactoryBot.create(:post, message: "Initial Value")
      sign_in post.user

      patch :update, params: { id: post.id, post: { message: 'Changed' } }
      expect(response).to redirect_to root_path
      post.reload
      expect(post.message).to eq "Changed"
    end

    it "should have http 404 error if the post cannot be found" do
      user = FactoryBot.create(:user)
      sign_in user

      patch :update, params: { id: "PHONEYTEST", post: { message: 'Changed' } }
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      post = FactoryBot.create(:post, message: "Initial Value")
      sign_in post.user

      patch :update, params: { id: post.id, post: { message: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      post.reload
      expect(post.message).to eq "Initial Value"
    end
  end

 describe "posts#edit action" do
    it "shouldn't let a user who did not create the post edit a post" do
      post = FactoryBot.create(:post)
      user = FactoryBot.create(:user)
      sign_in user
      get :edit, params: { id: post.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticated users edit a post" do
      post = FactoryBot.create(:post)
      get :edit, params: { id: post.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the edit form if the post is found" do
      post = FactoryBot.create(:post)
      sign_in post.user

      get :edit, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the post is not found" do
      user = FactoryBot.create(:user)
      sign_in user

      get :edit, params: { id: 'RANDOMPOST' }
      expect(response).to have_http_status(:not_found)
    end
  end


  describe "posts#show action" do
    it "should successfully show the page if the post is found" do
      post = FactoryBot.create(:post)
      get :show, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the post is not found" do
      get :show, params: { id: 'RANDOMPOST' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "posts#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "posts#new action" do
    it "should require users to be logged in" do
      user = FactoryBot.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end

  end

  describe "posts#create action" do
    it "should require users to be logged in" do
      post :create, params: { post: { message: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new post in our database" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: {
        post: {
          message: 'Hello!',
          picture: fixture_file_upload("/picture.png", 'image/png')
        }
      }

      expect(response).to redirect_to root_path

      post = Post.last
      expect(post.message).to eq("Hello!")
      expect(post.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user

      post_count = Post.count
      post :create, params: { post: { message: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(post_count).to eq Post.count
    end
  end
end
