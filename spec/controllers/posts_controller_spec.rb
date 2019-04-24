require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) { build(:user, email: "test@gmail.com") }

  login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe 'GET #new' do
    it "should find current_user and open form for create post" do
      get :new
      expect(subject.current_user.email).to eq("tester@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    before do
      @userparam = create(:post, user_id: subject.current_user.id)
    end
    it "should create post and redirect to root_path" do
      post :create, params: {post: {title:"test", body:"test"}}
      expect(subject.current_user.post.title).to eq("test")
      expect(subject.current_user.post.body).to eq("test")
      expect(response).to redirect_to root_path
    end
  end
end
