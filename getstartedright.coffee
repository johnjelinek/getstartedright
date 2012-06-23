Steps = new Meteor.Collection "Steps"

if Meteor.is_client
  Meteor.startup ->
    #Load popovers
    $('#accountability').popover {'placement': 'left'}

  Template.gameplan.greeting = ->
    "Our core purpose is to help people achieve their goals and enjoy a healthy, fulfilling life. To achieve this core purpose, Team Beachbody Coaches engage in six core activities:"

  Template.gameplan.steps = ->
    Steps.find {}, {"sort": {"order": 1}}

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
