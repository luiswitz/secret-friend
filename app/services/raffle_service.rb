class RaffleService
  def initialize(campaign)
    @campaign = campaign
  end

  def call
    return false if @campaign.members.count < 3

    results = {}
    members_list = @campaign.members
    friends_list = @campaign.members
    i = 0
    
    while members_list.count != i
      current_member = members_list[i]
      i += 1

      loop do
        friend = friends_list.sample

        if friends_list.count == 1 and friend == current_member
          results = {}
          members_list = @campaign.members
          friends_list = @campaign.members
          break
        elsif friend != current_member and results[friend] != current_member
          results[current_member] = friend
          friends_list -= [friend]
          break 
        end
      end
    end
    results
  end
end
