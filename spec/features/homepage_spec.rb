require 'rails_helper'
require 'capybara/rails'

feature 'Recent campaigns in Home Page', type: :feature do
  include Warden::Test::Helpers

  let!(:user) { FactoryGirl.create(:user) }
  let!(:campaign1) { FactoryGirl.create(:campaign, user: user) }
  let!(:campaign2) { FactoryGirl.create(:campaign, user: user) }
  let!(:campaign3) { FactoryGirl.create(:campaign) }

  before do
    login_as(user, scope: :user)
    visit root_path
  end

  scenario 'logged user see recent campaigns on pages/home' do
    expect(page).to have_content(campaign1.title)
    expect(page).to have_content(campaign2.title)
  end

  scenario 'logged user sees campaign link' do
    expect(page).to have_link('create', href: campaign_path(campaign1))
    expect(page).to have_link('create', href: campaign_path(campaign2))
  end

  scenario 'logged user doesn\'t sees campaigns from others' do
    expect(page).to_not have_content(campaign3.title)
  end

  scenario 'guest user doesn\'t sees any campaigns' do
    logout(:user)
    visit root_path

    expect(page).to_not have_content(campaign1.title)
    expect(page).to_not have_content(campaign2.title)
    expect(page).to_not have_content(campaign3.title)
  end
end
