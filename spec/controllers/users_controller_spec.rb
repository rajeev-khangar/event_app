require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the users into @users" do
      @users = FactoryGirl.create_list(:user, 10)
      get :index
      expect(assigns(:users).count).to eq @users.count
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    it "render new if send invalid params" do
      post :create, params: { user: { name: "test" }}
      expect(response).to render_template("new")
    end
    
    describe "if send valid params" do
      it "create user" do
        expect do
          post :create, params: { user: FactoryGirl.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it "return success message" do
        post :create, params: { user: FactoryGirl.attributes_for(:user) } 
        expect(flash[:notice]).to eq 'User was successfully created.'
      end
    end
  end

  describe "GET #edit" do
    it "responds successfully with an HTTP 200 status code" do
      @user = FactoryGirl.create(:user)
      get :edit, params: { id: @user.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      @user = FactoryGirl.create(:user)
      get :edit, params: { id: @user.id }
      expect(response).to render_template("edit")
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      @user = FactoryGirl.create(:user)
      get :show, params: { id: @user.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      @user = FactoryGirl.create(:user)
      get :show, params: { id: @user.id }
      expect(response).to render_template("show")
    end
  end

  describe "PUT #update" do
    it "render edit if send invalid params" do
      @user = FactoryGirl.create(:user)
      put :update, params: { id: @user.id, user: { email: "" }}
      expect(response).to render_template("edit")
    end

    it "return success message if send valid params" do
      @user = FactoryGirl.create(:user)
      put :update, params: { id: @user.id, user: { email: "email@fake.com" }}
      expect(flash[:notice]).to eq 'User was successfully updated.'
    end
  end

  describe "DELETE #destroy" do
    it "return success notice if user destroy" do
      @user = FactoryGirl.create(:user)
      delete :destroy, params: { id: @user.id }
      expect(flash[:notice]).to eq 'User was successfully destroyed.'
    end

    it "redirect_to users_url" do
      @user = FactoryGirl.create(:user)
      delete :destroy, params: { id: @user.id }
      expect(response).to redirect_to users_url
    end
  end
end