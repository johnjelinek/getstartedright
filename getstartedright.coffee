Steps = new Meteor.Collection "Steps"

if Meteor.is_client
  Meteor.startup ->
    #Load popovers
    $('#accountability').popover {'placement': 'left'}

    ###
    counter = (futureDate) ->
      today = new Date # today
      count = Math.floor (futureDate - today) / 1000
      countdown = setInterval ->
        $("#d").html Math.floor count / ( 60 * 60 * 24 )
        temp = count % ( 60 * 60 * 24 )
        $("#h").html Math.floor temp / ( 60 * 60 )
        temp = count % ( 60 * 60 )
        $("#m").html Math.floor temp / 60
        temp = count % 60
        $("#s").html temp

        counter new Date today.getFullYear(), today.getMonth(), today.getDate() + 1 if count isnt 0
        count--
      , 1000

    today = new Date #today
    counter new Date today.getFullYear(), today.getMonth(), today.getDate() + 1
    ###

  Template.gameplan.greeting = ->
    "Our core purpose is to help people achieve their goals and enjoy a healthy, fulfilling life. To achieve this core purpose, Team Beachbody Coaches engage in six core activities:"

  Template.gameplan.steps = ->
    Steps.find {}, {"sort": {"order": 1}}

  Template.gameplan.events = 
    'click button': ->
      myEmail = $('#myEmail').val()
      sendToEmail = $('#sendToEmail').val()
      myName = $('#myName').val()

      if myEmail > "" and sendToEmail > "" and myName > ""
        $.ajax {
          "type": "POST",
          "url": "https://mandrillapp.com/api/1.0/messages/send-template.json",
          "data": {
            "key": "5a95d1f1-4cec-4ac3-8d7e-e69d0748f3d9",
            "template_name": "Game Plan Updates",
            "template_content":[
              {
                "name": "schedule_time00",
                "content": "Possible marks: 3"
              }, {
                "name": "schedule_title00",
                "content": "Completed marks: 3"
              }, {
                "name": "schedule_time01",
                "content": "Possible marks: 4"
              }, {
                "name": "schedule_title01",
                "content": "Completed marks: 4"
              }, {
                "name": "schedule_time02",
                "content": "Possible marks: 4"
              }, {
                "name": "schedule_title02",
                "content": "Completed marks: 4"
              }, {
                "name": "schedule_time03",
                "content": "Possible marks: 4"
              }, {
                "name": "schedule_title03",
                "content": "Completed marks: 4"
              }, {
                "name": "schedule_time04",
                "content": "Possible marks: 4"
              }, {
                "name": "schedule_title04",
                "content": "Completed marks: 4"
              }, {
                "name": "schedule_time05",
                "content": "Possible marks: 4"
              }, {
                "name": "schedule_title05",
                "content": "Completed marks: 4"
              }, {
                "name": "lower_body_content",
                "content": "Total Copleted marks: 23 out of 23"
              }],
            "message": {
              "subject": "GamePlan Status Update",
              "from_email": "admin@johnjelinek.com",
              "from_name": myName,
              "to": [{"email": sendToEmail}],
              "headers": {"reply-to": myEmail},
              "track_opens": true,
              "track_clicks": true,
              "auto_text": "true"
            }
          }
        }

        $('#emailModal').modal()

        false

if Meteor.is_server
  Meteor.startup ->
    # Add Gameplan Steps
    steps = [{
      "title": "Be A Product of The Product",
      "todos": [
        "Work out daily with a Beachbody fitness program",
        "Drink Shakeology daily",
        "Log into the WOWY SuperGym daily"]
    }, {
      "title": "Share Beachbody With Two People Every Day Using The Sharing Cycle",
      "todos": [
        "Find: Always be building your contact list",
        "Invite: Ask them to watch, listen, or attend",
        "Share: Present the product line and opportunity via the appropriate Beachbody sharing tool, Webinar, conference call, or event",
        "Sponsor: Enroll them as a customer or Coach with a complete solution (fitness program, nutrition on Home Direct, and Club) that will help them reach their goal"]
    }, {
      "title": "Hold Get Started Right Interviews within 48 Hours",
      "todos": [
        "Identify their \"Why\"",
        "Establish realistic, achievable goals",
        "Create an action plan",
        "Partner with new Coaches for 90 days"]
    }, {
      "title": "Treat Your Business Like a Business",
      "todos": [
        "Don't work alone; find a Success Partner",
        "Hold weekly planning sessions and manage your time",
        "Focus on the six core Game Plan activities and work your plan every day",
        "Commit to be in business one year from now"]
    }, {
      "title": "Be An Active Team Member",
      "todos": [
        "Know and actively communicate with your team",
        "Check for news and team activity in your online office daily",
        "Attend local Fit Club events, webinars, trainings, calls",
        "Attend the annual Coach Summit and corporate events"]
    }, {
      "title": "Become A Leader",
      "todos": [
        "Lead by example",
        "Focus on helping people achieve their goals",
        "Listen to 10 minutes and read 10 pages of personal development daily",
        "Teach your team to follow the Game Plan"]
    }]

    if Steps.find().count() is 0
      Steps.insert {"title": step.title, "todos": step.todos, "order": i + 1} for step, i in steps
