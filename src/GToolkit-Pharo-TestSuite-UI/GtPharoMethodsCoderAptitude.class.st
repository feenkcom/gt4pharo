Class {
	#name : #GtPharoMethodsCoderAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'updater',
		'coder',
		'addedToSceneGraphEventHandler'
	],
	#category : #'GToolkit-Pharo-TestSuite-UI-Aptitudes'
}

{ #category : #accessing }
GtPharoMethodsCoderAptitude >> coder: aGtFilteredMethodsCoder [
	coder = aGtFilteredMethodsCoder ifTrue: [ ^ self ].
	self unsubscribeFromCoder.
	coder := aGtFilteredMethodsCoder.
	self subscribeToCoder.
	self onCoderChanged.
]

{ #category : #accessing }
GtPharoMethodsCoderAptitude >> coderDo: aBlock [
	coder ifNotNil: aBlock
]

{ #category : #'api - tasks' }
GtPharoMethodsCoderAptitude >> enqueueTask: aTask [

	self widgetDo: [ :anElement | anElement enqueueTask: aTask ]
]

{ #category : #initialization }
GtPharoMethodsCoderAptitude >> initialize [

	super initialize.
	self initializeUpdater.

	self initializeEventHandler
]

{ #category : #initialization }
GtPharoMethodsCoderAptitude >> initializeEventHandler [

	addedToSceneGraphEventHandler := BlEventHandler
		                                 on: BlElementAddedToSceneGraphEvent
		                                 do:
		                                 (MessageSend
			                                  receiver: self
			                                  selector: #onAddedToSceneGraph:).

	self addChange: (BrLookChange new
			 up: [ :e | widget addEventHandler: addedToSceneGraphEventHandler ];
			 down: [ :e | 
				 widget removeEventHandler: addedToSceneGraphEventHandler ];
			 yourself)
]

{ #category : #initialization }
GtPharoMethodsCoderAptitude >> initializeUpdater [

	updater := BrElementUpdater new
		           element: self
		           selector: #updateElement
]

{ #category : #'api - testing' }
GtPharoMethodsCoderAptitude >> isAttachedToSceneGraph [

	self widgetDo: [ :anElement | ^ anElement isAttachedToSceneGraph ].
	^ false
]

{ #category : #'private - event handling' }
GtPharoMethodsCoderAptitude >> onAddedToSceneGraph: anEvent [
	"I dispatch it for myself so that updater can receive notifications"

	self dispatchEventToMyself: anEvent
]

{ #category : #'private - hooks' }
GtPharoMethodsCoderAptitude >> onCoderChanged [

	self updater requestUpdate
]

{ #category : #'private - announcement handling' }
GtPharoMethodsCoderAptitude >> onCodersCoderAdded: aGtCodersCoderAdded [

	"Handle coder added announcement"

	self subscribeToCodersCoder: aGtCodersCoderAdded coder.
	self updater requestUpdate
]

{ #category : #'private - announcement handling' }
GtPharoMethodsCoderAptitude >> onCodersCoderRemoved: aGtCodersCoderRemoved [

	"Handle coder removed announcement"

	self unsubscribeFromCodersCoder: aGtCodersCoderRemoved coder.
	self updater requestUpdate
]

{ #category : #'private - announcement handling' }
GtPharoMethodsCoderAptitude >> onCodersCoderSourceCodeChanged: aGtCoderSourceCodeChanged [

	self updater requestUpdate
]

{ #category : #'private - announcement handling' }
GtPharoMethodsCoderAptitude >> onCodersCodersChanged: aGtCodersCodersChanged [

	"Handle coders changed (added and/or removed) announcement"

	
]

{ #category : #accessing }
GtPharoMethodsCoderAptitude >> space [
	^ self widget space
]

{ #category : #'private - subscriptions' }
GtPharoMethodsCoderAptitude >> subscribeToCoder [

	self coderDo: [ :aCoder | 
		aCoder
			when: GtCodersCoderAdded send: #onCodersCoderAdded: to: self;
			when: GtCodersCoderRemoved send: #onCodersCoderRemoved: to: self;
			when: GtCodersCodersChanged send: #onCodersCodersChanged: to: self ]
]

{ #category : #'private - subscriptions' }
GtPharoMethodsCoderAptitude >> subscribeToCodersCoder: aMethodCoder [

	aMethodCoder weak 
		when: GtCoderSourceCodeChanged 
		send: #onCodersCoderSourceCodeChanged:
		to: self 
]

{ #category : #'private - subscriptions' }
GtPharoMethodsCoderAptitude >> unsubscribeFromCoder [

	self coderDo: [ :aCoder | aCoder unsubscribe: self ]
]

{ #category : #'private - subscriptions' }
GtPharoMethodsCoderAptitude >> unsubscribeFromCodersCoder: aMethodCoder [

	aMethodCoder unsubscribe: self
]

{ #category : #'private - updating' }
GtPharoMethodsCoderAptitude >> updateElement [
	"Subclasses may update the widget.
	It should be called from the UI process."
	
]

{ #category : #'private - accessing' }
GtPharoMethodsCoderAptitude >> updater [

	^ updater
]
