class MembersController < ApplicationController
  before_action :authenticate_user!, except: [:opened]

  before_action :set_member, only: %i[show destroy update]
  before_action :is_owner?, only: %i[destroy update]
  before_action :set_member_by_token, only: [:opened]

  def create
    @member = Member.new(member_params)
    @campaign = @member.campaign

    respond_to do |format|
      if @member.save
        flash[:notice] = 'Member added with success'
        format.js { render template: 'campaigns/members.js.coffee' }
      else
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @member.destroy
      @campaign = @member.campaign
      flash[:notice] = 'Member deleted with success'
      respond_to do |format|
        format.json { render json: { deleted: true }.to_json, status: :ok }
        format.js { render template: 'campaigns/members.js.coffee' }
      end
    else
      render json: { deleted: false }.to_json, status: :unprocessable_entity
    end
  end

  def update
    @campaign = Campaign.find(@member.campaign_id)
    respond_to do |format|
      if @member.update(member_params)
        flash[:notice] = 'Member updated with success'
        format.js { render template: 'campaigns/members.js.coffee' }
      else
        flash[:notice] = @member.errors.full_messages.to_sentence
        format.js { render template: 'campaigns/members.js.coffee' }
      end
    end
  end

  def opened
    @member.update(open: true)
    gif = Base64.decode64('R0lGODlhAQABAPAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==')
    render text: gif, type: 'image/gif'
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def set_member_by_token
    @member = Member.find_by!(token: params[:token])
  end

  def member_params
    params.require(:member).permit(:name, :email, :campaign_id)
  end

  def is_owner?
    unless current_user == @member.campaign.user
      respond_to do |format|
        format.json { render json: { member: false }.to_json, status: :forbidden }
      end
    end
  end
end
