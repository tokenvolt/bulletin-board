require 'spec_helper'

describe AdvertisementsController do
  include Devise::TestHelpers

  before(:each) do
    @advertisement = Advertisement.create(title: "new ad 1",
                                          description: "this is new ad",
                                          email: 'user@ex.com',
                                          city: "LA",
                                          address: "La, 12, 23")
    @common_user = User.create(email: "user@example.com", password: '123456')
    @admin_user = User.create(email: "admin@example.com", password: '123456', role: 'admin')
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
        sign_in @common_user
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
    context "if user is not an admin" do
      it "redirects to advertisements index page" do
        sign_in @common_user
        get :edit, { id: @advertisement.id }
        response.should redirect_to advertisements_url
      end
    end

    context "if user is an admin" do
      it "renders edit page" do
        sign_in @admin_user
        get :edit, { id: @advertisement.id }
        response.should render_template 'edit'
      end
    end
  end

  describe "PUT update" do
    context "if user is not an admin" do
      it "redirects to advertisements index page" do
        sign_in @common_user
        put :update, :id => @advertisement.id, :advertisement => { title: 'updated ad' }
        response.should redirect_to advertisements_url
      end

      it "doesn't update advertisement" do
        sign_in @common_user
        put :update, :id => @advertisement.id, :advertisement => { title: 'updated ad' }
        Advertisement.find(@advertisement.id).title.should_not == 'updated ad'
      end
    end

    context "if user is an admin" do
      it "renders edit page" do
        sign_in @admin_user
        put :update, :id => @advertisement.id, :advertisement => { title: 'updated ad' }
        Advertisement.find(@advertisement.id).title.should == 'updated ad'
      end
    end
  end

  describe "DELETE destroy" do
    context "if user is not an admin" do

      it "redirects to advertisements index page" do
        sign_in @common_user
        put :destroy, { id: @advertisement.id }
        response.should redirect_to advertisements_url
      end  

      it "doesn't destroy advertisement" do       
        sign_in @common_user
        previous_advertisement_count = Advertisement.count
        put :destroy, { id: @advertisement.id }
        Advertisement.count.should == previous_advertisement_count
      end
    end

    context "if user is an admin" do
      it "destroys advertisement" do        
        sign_in @admin_user
        expect {
          put :destroy, { id: @advertisement.id }
          }.to change { Advertisement.count }
      end
    end
  end

end