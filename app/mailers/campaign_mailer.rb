class CampaignMailer < ApplicationMailer

  def raffle(campaign, member, friend)
    @campaign = campaign
    @member = member
    @friend = friend
    mail to: @member.email, subject: "Our Secret Friend: #{@campaign.title}"
  end

  def error(campaign, owner)
    @campaign = campaign
    @owner = owner
    mail to: @owner.email, subject: 'Something went wrong with your campaign =('
  end
end
