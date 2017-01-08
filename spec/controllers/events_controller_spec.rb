require "rails_helper"

RSpec.describe EventsController, :type => :controller do
  let(:user) { User.where(id: 1).first || FactoryGirl.create(:user) }
 
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, params: {user_id: user.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index, params: {user_id: user.id}
      expect(response).to render_template("index")
    end

    it "loads all of the events into @events" do
      @events = FactoryGirl.create_list(:event, 10)
      get :index, params: {user_id: user.id}
      expect(assigns(:events).count).to eq @events.count
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new, params: {user_id: user.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      get :new, params: {user_id: user.id}
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    it "render new if send invalid params" do
      post :create, params: {user_id: user.id, event: { name: "" }}
      expect(response).to render_template("new")
    end
    
    describe "if send valid params" do
      it "create event" do
        expect do
          post :create, params: { user_id: user.id, event: FactoryGirl.attributes_for(:event).merge!(user_id: user.id) }
        end.to change(Event, :count).by(1)
      end

      it "return success message" do
        post :create, params: { user_id: user.id, event: FactoryGirl.attributes_for(:event).merge!(user_id: user.id) } 
        expect(flash[:notice]).to eq 'Event was successfully created.'
      end
    end
  end

  describe "GET #edit" do
    it "responds successfully with an HTTP 200 status code" do
      @event = FactoryGirl.create(:event)
      get :edit, params: { user_id: user.id, id: @event.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      @event = FactoryGirl.create(:event)
      get :edit, params: { user_id: user.id, id: @event.id }
      expect(response).to render_template("edit")
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      @event = FactoryGirl.create(:event)
      get :show, params: { user_id: user.id, id: @event.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      @event = FactoryGirl.create(:event)
      get :show, params: { user_id: user.id, id: @event.id }
      expect(response).to render_template("show")
    end
  end

  describe "PUT #update" do
    it "render edit if send invalid params" do
      @event = FactoryGirl.create(:event)
      put :update, params: { user_id: user.id, id: @event.id, event: { name: "" }}
      expect(response).to render_template("edit")
    end

    it "return success message if send valid params" do
      @event = FactoryGirl.create(:event)
      put :update, params: { user_id: user.id, id: @event.id, event: { email: "email@fake.com" }}
      expect(flash[:notice]).to eq 'Event was successfully updated.'
    end
  end

  describe "DELETE #destroy" do
    it "return success notice if event destroy" do
      @event = FactoryGirl.create(:event)
      delete :destroy, params: { user_id: user.id, id: @event.id }
      expect(flash[:notice]).to eq 'Event was successfully destroyed.'
    end

    it "redirect_to user_events_path" do
      @event = FactoryGirl.create(:event)
      delete :destroy, params: { user_id: user.id, id: @event.id }
      expect(response).to redirect_to user_events_path
    end
  end
end