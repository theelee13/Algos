Template.getAlgoLink.events = {
	'click button[name=goTo]': function(){
		Router.go('pedia', {_id: this.AiD});
	}
}
