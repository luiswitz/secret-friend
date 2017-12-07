require "rails_helper"

RSpec.describe CampaignMailer, type: :mailer do
  describe "raffle" do
    before do
      @campaign = create(:campaign)
      @member = create(:member, campaign: @campaign)
      @friend = create(:member, campaign: @campaign)
      @mail = CampaignMailer.raffle(@campaign, @member, @friend)
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("Our Secret Friend: #{@campaign.title}")
      expect(@mail.to).to eq([@member.email])
    end

    it "body have member name" do
      expect(@mail.body.encoded).to match(@member.name)
    end

    it "body have campaign creator name" do
      expect(@mail.body.encoded).to match(@campaign.user.name)
    end

    it "body have friend name" do
      expect(@mail.body.encoded).to match(@friend.name)
    end

    it "body have member link to set open" do
      expect(@mail.body.encoded).to match("/members/#{@member.token}/opened")
    end
  end

  describe '#error' do
    let(:owner) { create(:user) }
    let(:campaign) { create(:campaign, user: owner) }
    let(:mail) { CampaignMailer.error(campaign, owner) }

    it 'sends the email to the owner' do
      expect(mail.to).to eq([owner.email])
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Something went wrong with your campaign =(')
    end

    it 'body has the owner name' do
      expect(mail.body.encoded).to match(owner.name)
    end

    it 'body has the campaign link' do
      expect(mail.body.encoded).to match(campaign_path(campaign))
    end
  end
end
