require 'rails_helper'

RSpec.describe MembersController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:campaign) { create(:campaign, user: user) }

  before { sign_in user }

  describe "POST #create" do
    let(:member) { member = create(:member) }

    context 'with valid parameters' do
      it "creates a new user" do
        post :create, params: { member: { name: member.name, email: member.email } }, format: :json
        expect(Member.last).to eq(member)
      end
    end
    
    context 'without valid parameters' do
      it 'returns 302 status' do
        post :create, params: { member: { name: '', email: '' } } , format: :json
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'member is the owner of the campaign' do
      let(:member) { create(:member, campaign: campaign) } 
      
      before do
        delete :destroy, params: { id: member.id }, format: :json
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'deletes a member' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['deleted']).to eq true
      end
    end

    context 'member is not the owner of the campaign' do
      let(:member) { create(:member) }

      before do
        delete :destroy, params: { id: member.id }, format: :json
      end
      
      it 'returns forbidden status' do
        expect(response).to have_http_status(:forbidden)
      end

      it 'returns member false on response' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['member']).to eq false
      end
    end
  end

  describe "PUT #update" do
    let(:member) { create(:member) }

    context 'with valid parameters' do
      it 'updates a member' do 
        patch :create, params: { member: { id: member.id, name: 'the-edited-name', email: 'the-edited-email' } }, format: :json
        expect(Member.find(member.id)).to eq(member)
      end
    end

    context 'with invalid parameters' do
      it 'returns 302 status' do
        patch :create, params: { member: { id: member.id, name: '', email: '' } }, format: :json
        expect(response).to have_http_status(422)
      end
    end
  end
end
