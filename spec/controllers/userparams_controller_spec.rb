require 'rails_helper'

RSpec.describe UserparamsController, type: :controller do
  let!(:user) { build(:user, email: "test@gmail.com") }

  login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe 'GET #new' do
    it "should find current_user and open form for create userparam" do
      get :new
      expect(subject.current_user.email).to eq("tester@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    it "should create userparam and redirect to index page" do
      post :create, params: {userparam: {firstname:"Tester", lastname:"Test", age:"20"}}
      expect(subject.current_user.userparam.firstname).to eq("Tester")
      expect(subject.current_user.userparam.lastname).to eq("Test")
      expect(subject.current_user.userparam.age).to eq(20)
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET #edit' do
    it "should find current_user and open form for edit userparam" do
      expect(subject.current_user.email).to eq("tester@gmail.com")
      expect(subject.current_user.email).to_not eq(user.email)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH #update' do
    before do
      @userparam = create(:userparam, user_id: subject.current_user.id)
    end
    it "should update userparam and redirect to userparam" do
      patch :update, params: { id: subject.current_user.id, userparam: {firstname: "Tester2", lastname: "Test2", age:"22"}}
      expect(subject.current_user.userparam.firstname).to eq("Tester2")
      expect(subject.current_user.userparam.lastname).to eq("Test2")
      expect(subject.current_user.userparam.age).to eq(22)
      expect(response).to redirect_to root_path
    end
  end
end
