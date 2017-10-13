require 'rails_helper'

describe RaffleService do

  before :each do
    @campaign = create(:campaign, status: :pending)
  end

  describe '#call' do
    context "when there are more than two members" do
      before :each do
        3.times { create(:member, campaign: @campaign) }
        @campaign.reload

        @results = RaffleService.new(@campaign).call
      end

      it "results in a hash" do
        expect(@result.class).to eq(Hash)
      end

      it "all members are in results as a member" do
        result_members = @results.map { |r| r.first }
        expect(result_member.sort).to eq(@campaign.members.sort)
      end

      it "all member are in results as a friend" do
        result_friends = @results.map { |r| r.last }
        expect(result_friends.sort).to eq(@campaign.members.sort)
      end

      it "a member doesn't catch itself" do
        @results.each do |r|
          expect(r.first).not_to eq(r.last)
        end
      end

      it "member X doesn't catch the Y member that catches the X member" do

      end
    end
    

    context "when there are less than two members" do
      before :each do
        create(:member, campaign: @campaign)
        @campaign.reload

        @response = RaffleService.new(@campaign).call
      end

      it "returns false" do
        expect(@response).to eql(false)
      end
    end
  end
end
