class MemberList
  constructor: (member) ->
    @member = $(member)
    @members = $.map @member.find("[data-behavior='member']"), (member, m) ->
      new Member(member)

class Member
  constructor: (member) ->
    @member = $(member)
    @id = @member.data("id")
    @setEvents()
    
  setEvents: ->
    @member.find("[data-behavior='member-name-input']").on "blur", @handleNameBlur
    @member.find("[data-behavior='member-email-input']").on "blur", @handleEmailBlur
    @member.find("[data-behavior='member-delete']").on "click", @handleDelete

  handleNameBlur: =>
    value = @member.find("[data-behavior='member-name-input']").val()
    $.ajax
      url: "/members/#{@id}"
      dataType: "script"
      method: "PATCH"
      data: { member: { name: value } }
      success: ->
        Materialize.toast('Participant updated successfully', 4000, 'green')
      error: ->
        Materialize.toast('Could not edit participant', 4000, 'red')

  handleEmailBlur: =>
    value = @member.find("[data-behavior='member-email-input']").val()
    $.ajax
      url: "/members/#{@id}"
      dataType: "script"
      method: "PATCH"
      data: { member: { email: value } }
      success: ->
        Materialize.toast('Participant updated successfully', 4000, 'green')
      error: ->
        Materialize.toast('Could not edit participant', 4000, 'red')
$ ->
  new MemberList $("[data-behavior='member-list']")
