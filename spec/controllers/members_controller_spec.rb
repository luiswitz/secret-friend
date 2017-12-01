require 'rails_helper'

RSpec.describe MembersController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  before { sign_in user }

  describe "POST #create" do
    context 'with valid parameters' do
      it "creates a new user" do
        member = create(:member)
        post :create, member: { name: member.name, email: member.email }, format: :json
        expect(Member.last).to eq(member)
      end
    end
    
    context 'without valid parameters' do
      it 'returns 302 status' do
        post :create, member: { name: '', email: '' }, format: :json
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "GET #destroy" do
    xit "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    xit "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

end
