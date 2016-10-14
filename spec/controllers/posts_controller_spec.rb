require "rails_helper"

RSpec.describe PostsController, :type => :controller do
  describe "GET #index" do
    it "allows unauthenticated requests" do
      get :index

      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "redirects unauthenticated requests" do
      get :new, params: { user_id: 1 }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #show" do
    it "allows unauthenticated requests" do
      post = create(:post)
      get :show, params: { id: post.id }

      expect(response).to be_success
    end
  end

  describe "POST #create" do
    it "redirects unauthenticated requests" do
      post :create, params: { id: 1, user_id: 1 }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #edit" do
    it "redirects unauthenticated requests" do
      get :edit, params: { id: 1, user_id: 1 }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST #update" do
    it "redirects unauthenticated requests" do
      post :update, params: { id: 1, user_id: 1 }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "DELETE #destroy" do
    it "redirects unauthenticated requests" do
      delete :destroy, params: { id: 1, user_id: 1 }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
