class CampaignRaffleJob < ApplicationJob
  queue_as :emails

  def perform(campaign)
    results = RaffleService.new(campaign).call

    if results == false
      CampaignMailer.error(campaign, campaign.user).deliver_now
    else
      campaign.members.each(&:set_pixel)
      results.each do |r|
        CampaignMailer.raffle(campaign, r.first, r.last).deliver_now
      end
      campaign.update(status: :finished)
    end
  end
end
