Class {
	#name : #GtPharoFourStateAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'coder',
		'updater',
		'fourIconElement',
		'neutralIconElement',
		'errorIconElement',
		'failureIconElement',
		'passedIconElement',
		'addedToSceneGraphEventHandler',
		'oneIconElement'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #accessing }
GtPharoFourStateAptitude >> coder: aGtFilteredMethodsCoder [
	coder = aGtFilteredMethodsCoder ifTrue: [ ^ self ].
	self unsubscribeFromCoder.
	coder := aGtFilteredMethodsCoder.
	self subscribeToCoder.
	self onCoderChanged.
]

{ #category : #accessing }
GtPharoFourStateAptitude >> coderDo: aBlock [
	coder ifNotNil: aBlock
]

{ #category : #'api - tasks' }
GtPharoFourStateAptitude >> enqueueTask: aTask [

	self widgetDo: [ :anElement | anElement enqueueTask: aTask ]
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> errorIconElement [

	^ errorIconElement
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> failureIconElement [

	^ failureIconElement
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> fourIconElement [
	^ fourIconElement
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initialize [

	super initialize.

	self initializeOneStateIconElement.
	self initializeFourStateIconElement.
	self initializeNeutralIconElement.
	self initializeErrorIconElement.
	self initializeFailureIconElement.
	self initializePassedIconElement.

	self fourIconElement addChild: self passedIconElement as: #passed.
	self fourIconElement addChild: self failureIconElement as: #failure.
	self fourIconElement addChild: self errorIconElement as: #error.
	self fourIconElement addChild: self neutralIconElement as: #neutral.

	self
		addChangeAddChildAs: #( content oneStateExample )
		with: [ self oneIconElement ].
	self
		addChangeAddChildAs: #( content fourStateExample )
		with: [ self fourIconElement ].
	updater := GtPhlowUpdateRequester new
		           element: self
		           selector: #updateElement.
	
	self initializeEventHandler.
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializeErrorIconElement [

	errorIconElement := self newColoredIcon:
		                    GtPharoMethodTestCaseErrorState default color
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializeEventHandler [

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
GtPharoFourStateAptitude >> initializeFailureIconElement [

	failureIconElement := self newColoredIcon:
		                      GtPharoMethodTestCaseFailureState default
			                      color
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializeFourStateIconElement [

	fourIconElement := BlElement new
		                   layout: (BlGridLayout new
				                    columnCount: 2;
				                    cellSpacing: 0);
		                   background: BlBackground transparent;
		                   constraintsDo: [ :c | 
			                   c horizontal fitContent.
			                   c vertical fitContent ]
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializeNeutralIconElement [

	neutralIconElement := self newColoredIcon:
		                      GtPharoMethodNotExecutedState default color
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializeOneStateIconElement [
	oneIconElement := BlElement new
		  geometry: BlSquare new;
		  margin: (BlInsets all: 1);
		  size: 16 @ 16
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializePassedIconElement [

	passedIconElement := self newColoredIcon:
		                     GtPharoMethodTestCasePassedState default color
]

{ #category : #'api - testing' }
GtPharoFourStateAptitude >> isAttachedToSceneGraph [

	self widgetDo: [ :anElement | ^ anElement isAttachedToSceneGraph ].
	^ false
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> neutralIconElement [

	^ neutralIconElement
]

{ #category : #initialization }
GtPharoFourStateAptitude >> newColoredIcon: aColor [

	^ BlElement new
		  background: aColor;
		  geometry: BlSquare new;
		  margin: (BlInsets all: 1);
		  size: 8 @ 8
]

{ #category : #accessing }
GtPharoFourStateAptitude >> onAddedToSceneGraph: anEvent [
	"I dispatch it for myself so that updater can receive notifications"

	self dispatchEventToMyself: anEvent
]

{ #category : #'private - hooks' }
GtPharoFourStateAptitude >> onCoderChanged [
	updater requestUpdate
]

{ #category : #'private - announcement handling' }
GtPharoFourStateAptitude >> onCoderChanged: anAnnouncement [
	self flag: 'replace it'.
	updater requestUpdate
]

{ #category : #'private - announcement handling' }
GtPharoFourStateAptitude >> onCodersCoderAdded: aGtCodersCoderAdded [
	"Handle coder added announcement"
	
	self subscribeToCodersCoder: aGtCodersCoderAdded coder.
	self updater requestUpdate.
]

{ #category : #'private - announcement handling' }
GtPharoFourStateAptitude >> onCodersCoderRemoved: aGtCodersCoderRemoved [
	"Handle coder removed announcement"
	self unsubscribeFromCodersCoder: aGtCodersCoderRemoved coder.
	self updater requestUpdate.
]

{ #category : #'private - announcement handling' }
GtPharoFourStateAptitude >> onCodersCoderSourceCodeChanged: aGtCoderSourceCodeChanged [
	self updater requestUpdate
]

{ #category : #'private - announcement handling' }
GtPharoFourStateAptitude >> onCodersCodersChanged: aGtCodersCodersChanged [
	"Handle coders changed (added and/or removed) announcement"
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> oneIconElement [

	^ oneIconElement
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> passedIconElement [

	^ passedIconElement
]

{ #category : #'element compatibility' }
GtPharoFourStateAptitude >> space [
	^ self widget space
]

{ #category : #'private - subscriptions' }
GtPharoFourStateAptitude >> subscribeToCoder [

	self coderDo: [ :aCoder | 
		aCoder weak
			when: GtCodersCoderAdded send: #onCodersCoderAdded: to: self;
			when: GtCodersCoderRemoved send: #onCodersCoderRemoved: to: self;
			when: GtCodersCodersChanged send: #onCodersCodersChanged: to: self ]
]

{ #category : #'private - announcement handling' }
GtPharoFourStateAptitude >> subscribeToCodersCoder: aMethodCoder [

	aMethodCoder weak 
		when: GtCoderSourceCodeChanged 
		send: #onCodersCoderSourceCodeChanged:
		to: self 
]

{ #category : #'private - subscriptions' }
GtPharoFourStateAptitude >> unsubscribeFromCoder [
	self coderDo: [ :aCoder |
		aCoder unsubscribe: self ].
]

{ #category : #'private - announcement handling' }
GtPharoFourStateAptitude >> unsubscribeFromCodersCoder: aMethodCoder [ 
	aMethodCoder unsubscribe: self
]

{ #category : #'private - updating' }
GtPharoFourStateAptitude >> updateElement [
	"Subclasses may update the widget.
	It should be called from the UI process."
	
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> updater [
	^ updater
]
