require 'rails_helper'

RSpec.describe CampaignRaffleJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    let(:campaign) { create(:campaign) }

    subject(:job) { described_class.perform_later(campaign) }

    it 'queues the job' do
      expect { job }.to have_enqueued_job
    end
  end
end
