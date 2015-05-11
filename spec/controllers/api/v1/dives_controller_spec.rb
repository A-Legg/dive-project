require 'rails_helper'

RSpec.describe Api::V1::DivesController, type: :controller do
	describe 'GET, #show' do 
		before(:each) do 
			@dive = FactoryGirl.create :dive
			get :show, id: @dive.id
		end 

		it "has the user as a embeded object" do
      dive_response = json_response[:dive]
      expect(dive_response[:user][:email]).to eql @dive.user.email
    end

		it { should respond_with 200 }

	end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :dive }
      get :index
    end
   
    it "returns the user object into each dive" do
      dives_response = json_response[:dives]
      dives_response.each do |dive_response|
        expect(dive_response[:user]).to be_present
      end
    end
  end

	describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @dive_attributes = FactoryGirl.attributes_for :dive
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, dive: @dive_attributes }
      end

      it "renders the json representation for the dive record just created" do
        dive_response = json_response
        expect(dive_response[:dive][:location]).to eql @dive_attributes[:location]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_dive_attributes = { location: 6}
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, dive: @invalid_dive_attributes }
      end

      it "renders an errors json" do
        dive_response = json_response
        expect(dive_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @dive = FactoryGirl.create :dive, user: @user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @dive.id,
              dive: { location: "Tulamben" } }
      end

      it "renders the json representation for the updated user" do
        dive_response = json_response
        expect(dive_response[:dive][:location]).to eql "Tulamben"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @dive.id,
              dive: { location: '' } }
      end

      it "renders an errors json" do
        dive_response = json_response
        expect(dive_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        dive_response = json_response
        expect(dive_response[:errors][:location]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
end

describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @dive = FactoryGirl.create :dive, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, { user_id: @user.id, id: @dive.id }
    end

    it { should respond_with 204 }
  end

	
end
