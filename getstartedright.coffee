Steps = new Meteor.Collection "Steps"

if Meteor.is_client
  Template.hello.greeting = ->
    "Welcome to getstartedright."

  Template.hello.events =
    'click input': ->
      # template data, if any, is available in 'this'
      console.log "You pressed the button" if console?

if Meteor.is_server
  Meteor.startup ->
    # Add Gameplan Steps
    steps = ["Be A Product of The Product",
    "Share Beachbody With Two People Every Day Using The Sharing Cycle",
    "Hold Get Started Right Interviews within 48 Hours",
    "Treat Your Business Like a Business",
    "Be An Active Team Member",
    "Become A Leader"
    ]

    if Steps.find().count() is 0
      Steps.insert {"step": step} for step in ['Be A Product of The Product']
