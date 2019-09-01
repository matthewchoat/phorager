require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
 describe "comments#create action" do
    it "should allow users to create comments on post" do
#      post = FactoryBot.create(:post)

#      user = FactoryBot.create(:user)
#      sign_in user

#      post :create, params: { post_id: post.id, comment: { message: 'awesome post' } }

#      expect(response).to redirect_to root_path
#      expect(post.comments.length).to eq 1
#      expect(post.comments.first.message).to eq "awesome post"
    end

    it "should require a user to be logged in to comment on a post" do
#      post = FactoryBot.create(:post)
#      post :create, params: { post_id: post.id, comment: { message: 'awesome post' } }
#     expect(response).to redirect_to new_user_session_path
    end

    it "should return http status code of not found if the post isn't found" do
#      user = FactoryBot.create(:user)
#      sign_in user
#      post :create, params: { post_id: 'randompost', comment: { message: 'awesome post' } }
#      expect(response).to have_http_status :not_found
    end
  end
end
