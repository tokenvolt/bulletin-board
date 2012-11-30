require 'spec_helper'

describe AdvertisementsController do
  include Devise::TestHelpers

  before(:each) do
    @advertisement = Advertisement.create(title: "new ad 1",
                                          description: "this is new ad",
                                          email: 'user@ex.com',
                                          city: "LA",
                                          address: "La, 12, 23")

  end

  describe "POST create" do

    before(:each) do
      @new_advertisement = Advertisement.new(title: "new ad 2",
                                      description: "this is another ad",
                                      email: 'user2@ex.com',
                                      city: "LA",
                                      address: "La, 12, 43")
    end

    context "if user is not an admin" do
      it "creates new advertisement" do
        common_user = User.create(email: "user@example.com", password: '123456')
        sign_in common_user
        expect { 
          post :create, :advertisement => @new_advertisement.attributes.except('id', 'created_at', 'updated_at')
          }.to change { Advertisement.count }.by(1)        
      end
    end

    context "if user is not signed in" do
      it "creates new advertisement" do
        expect { 
          post :create, :advertisement => @new_advertisement.attributes.except('id', 'created_at', 'updated_at')
          }.to change { Advertisement.count }.by(1)        
      end
    end
  end

  describe "GET edit" do
    it "redirects to advertisements index page if user is not an admin" do
      common_user = User.create(email: "user@example.com", password: '123456')
      sign_in common_user
      get :edit, { id: @advertisement.id }
      response.should redirect_to advertisements_url
    end

    it "renders edit page if user is an admin" do
      admin_user = User.create(email: "user@example.com", password: '123456', role: 'admin')
      sign_in admin_user
      get :edit, { id: @advertisement.id }
      response.should render_template 'edit'
    end
  end

  describe "DELETE destroy" do
    context "if user is not an admin" do

      it "redirects to advertisements index page" do
        common_user = User.create(email: "user@example.com", password: '123456')
        sign_in common_user
        put :destroy, { id: @advertisement.id }
        response.should redirect_to advertisements_url
      end  

      it "doesn't destroy advertisement" do
        common_user = User.create(email: "user@example.com", password: '123456')
        sign_in common_user
        previous_advertisement_count = Advertisement.count
        put :destroy, { id: @advertisement.id }
        Advertisement.count.should == previous_advertisement_count
      end
    end

    context "if user is an admin" do
      it "destroys advertisement" do
        admin_user = User.create(email: "user@example.com", password: '123456', role: 'admin')
        sign_in admin_user
        expect {
          put :destroy, { id: @advertisement.id }
          }.to change { Advertisement.count }
      end
    end
  end

end