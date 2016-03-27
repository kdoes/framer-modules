# A module for Android Components
# My first module, mostly for learning.
# Kim Does, 2016

exports.createButton = (options) ->
	thisButton = new Layer
		width: Screen.width*0.8
		height: 120;
		backgroundColor: options.backgroundColor || '#2196F3'
		clip: true
		name: options.name

	thisButton.center()
	thisButton.html = options.html || 'Placeholder Text'
	thisButton.style =
		"font-family": "Roboto, OpenSans"
		"text-align": "center"
		"padding" : "45px"
		"font-size" : "50px"
		"text-transform" : "uppercase"

	thisButton.on Events.TouchEnd, (event) ->
		touchEvent = Events.touchEvent(event)
		exports.showFeedback(this, touchEvent)

	return thisButton

exports.createCard = (options) ->
	card = new Layer
		width: Screen.width-4*16
		midX: Screen.width/2
		backgroundColor: '#FFFFFF'
		borderRadius: 4
		height: 500
		y: 32
		color: 'rgba(0,0,0, .87)'
		clip: true
		shadowX: 1
		shadowY: 3
		shadowColor: 'rgba(0,0,0,.12)'

	card.html = "This is a Card"
	card.style =
		"font-family": "Roboto, OpenSans"
		"text-align": "left"
		"padding" : "45px"
		"font-size" : "60px"

	card.on Events.TouchEnd, (event) ->
		touchEvent = Events.touchEvent(event)
		exports.showFeedback(this, touchEvent)

	return card

exports.showFeedback = (thisObject, touchEvent) ->
	if Utils.isPhone() || Utils.isTablet()
		tX = touchEvent.clientX - thisObject.x
		tY = touchEvent.clientY - thisObject.y
	else
		tX = touchEvent.offsetX
		tY = touchEvent.offsetY

	circle = new Layer
		width: 1000
		height: 1000
		borderRadius: 1000
		backgroundColor: thisObject.backgroundColor.darken(20)
		opacity: 0.2
		midX: tX
		midY: tY

	circle.scale = 0.001
	circle.parent = thisObject

	animateIn = 0.2
	animateOut = 0.2

	circle.animate
		properties:
			scale: 1
		time: animateIn

	Utils.delay animateIn, ->
		circle.animate
			properties:
				opacity: 0
			time: animateOut

		Utils.delay animateOut, ->
			circle.destroy()
