Steps = new Meteor.Collection "Steps"


if Meteor.is_client
  Template.gameplan.steps = ->
    Steps.find {}, {"sort": {"order": 1}}

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
      Steps.insert {"title": step, "order": i + 1} for step, i in steps
