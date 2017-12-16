Materialize.toast('<%= flash[:notice] %>', 4000, 'green')
$("#members-list").html("<%= j render partial: 'campaigns/members' %>")
