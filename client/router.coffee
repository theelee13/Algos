Router.map ->
  @route 'home',{
    path: '/'
	 template: 'home'
  }
  @route 'forum',{
	 template: 'forum'
  }

  @route 'algo',{
    path: '/pedia'
	 template: 'algopedia'
  }
  @route 'profile',{
	 template: 'userPage'
	 action: ->
		 Session.set 'lastUserSearch',Meteor.user()
		 @render()
  }
  @route 'users',{
    path: '/users/:_id'
    template: 'userPage'
	 action: ->
		 uDoc = Meteor.users.findOne({username:@params._id})
		 Session.set 'lastUserSearch',uDoc
		 @render()
  }
  @route 'pedia',{
    path:'/pedia/:_id'
	 template: 'entryPage'
	 action: ->
      aDoc = AlgoPedia.findOne({AiD:@params._id})
      Session.set 'lastAlgoSearch',aDoc
      @render()
  }

Router.configure {
  layoutTemplate: 'layout_main'
}
