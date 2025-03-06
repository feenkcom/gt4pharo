Class {
	#name : #GtPharoSuiteShowButton,
	#superclass : #BrButton,
	#traits : 'TGtWithPharoSuiteViewModel',
	#classTraits : 'TGtWithPharoSuiteViewModel classTrait',
	#category : #'GToolkit-Pharo-TestSuite-UI-! Views'
}

{ #category : #initialization }
GtPharoSuiteShowButton >> initialize [

	super initialize.
	self initializeAsyncPromise.
	self icon: BrGlamorousVectorIcons play.
	self addAptitude: BrGlamorousButtonWithIconAptitude.
	self addAptitude: (BrGlamorousWithExplicitDropdownAptitude
			 handle: [ BlElement new size: self extent ]
			 content: [ 
				 GtPharoSuiteOverviewElement new
					 suiteViewModel: self suiteViewModel;
					 margin: (BlInsets all: 10) ])
]

{ #category : #initialization }
GtPharoSuiteShowButton >> initializeAsyncPromise [
	self asyncPromise
		whenPending: [ :aButton | aButton visibility: BlVisibility visible ];
		whenError: [ :aButton :anError | 
			aButton visibility: BlVisibility visible.
			aButton icon: anError asDebuggableElement ];
		whenSuccess: [ :aButton :hasSuiteCases | 
			aButton
				visibility: (hasSuiteCases ifTrue: [ BlVisibility visible ] ifFalse: [ BlVisibility gone ]).
			aButton icon: self newForStatePlayIcon ]
]

{ #category : #'private - instance creation' }
GtPharoSuiteShowButton >> newForStatePlayIcon [

	^ BlElement new
		layout: BlLinearLayout horizontal alignCenter;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: { 
			GtPharoSuiteFourStateElement new
				suiteViewModel: self suiteViewModel.
			BrGlamorousVectorIcons play asElement
		}
]

{ #category : #'private - announcement handling' }
GtPharoSuiteShowButton >> onSuiteStreamChanged: anAnnouncement [
	self
		enqueueTask: (BlTaskAction new
				action: [ self asyncPromise promise: self suiteViewModel hasSuiteCases ])
]

{ #category : #'api - suite view model' }
GtPharoSuiteShowButton >> onSuiteViewModelChanged [
	"Is sent when a new suiteViewModel is assigned to the receiver.
	Note: #onSuiteViewModelChanged is sent before #subscribeToSuiteViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSuiteViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	self asyncPromise promise: self suiteViewModel hasSuiteCases
]

{ #category : #'api - suite view model' }
GtPharoSuiteShowButton >> subscribeToSuiteViewModel [
	self suiteViewModel
		when: GtPharoSuiteStreamChanged
		send: #onSuiteStreamChanged:
		to: self
]

{ #category : #'api - suite view model' }
GtPharoSuiteShowButton >> unsubscribeFromSuiteViewModel [
	self suiteViewModel unsubscribe: self
]
