Trait {
	#name : #TGt2WithPharoTagViewModel,
	#instVars : [
		'pharoTagViewModel'
	],
	#category : 'GToolkit-Pharo-Coder-UI-!  - Support'
}

{ #category : #'api - pharo tag view model' }
TGt2WithPharoTagViewModel >> hasPharoTagViewModel [
	"Return a true if pharoTag view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoTagViewModel notNil
]

{ #category : #'api - pharo tag view model' }
TGt2WithPharoTagViewModel >> onPharoTagViewModelChanged [
	"Is sent when a new pharoTag view model is assigned to the element.
	Note: #onPharoTagViewModelChanged is sent before #subscribeToPharoTagViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo tag view model' }
TGt2WithPharoTagViewModel >> onPostPharoTagViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoTagViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo tag view model' }
TGt2WithPharoTagViewModel >> pharoTagViewModel [
	"Return a not-null pharoTag view model assigned to the receiver element"
	self
		assert: [ pharoTagViewModel notNil ]
		description: [ 'pharoTag view model should be initialized' ].

	^ pharoTagViewModel
]

{ #category : #'api - pharo tag view model' }
TGt2WithPharoTagViewModel >> pharoTagViewModel: aPharoTagViewModel [
	"Set a not-null pharoTag view model assigned to the receiver element"
	self
		assert: [ aPharoTagViewModel notNil ]
		description: [ 'pharoTag view model must not be nil' ].

	pharoTagViewModel == aPharoTagViewModel 
		ifTrue: [ ^ self ].

	pharoTagViewModel ifNotNil: [ self unsubscribeFromPharoTagViewModel ].
	pharoTagViewModel := aPharoTagViewModel.

	self onPharoTagViewModelChanged.
	self subscribeToPharoTagViewModel.
	self onPostPharoTagViewModelChanged
]

{ #category : #'api - pharo tag view model' }
TGt2WithPharoTagViewModel >> subscribeToPharoTagViewModel [
	"Is sent after a new pharoTag view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoTagViewModel if elements subscribe to them"
]

{ #category : #'api - pharo tag view model' }
TGt2WithPharoTagViewModel >> unsubscribeFromPharoTagViewModel [
	"Is sent before a new pharoTag view model is assigned to the element.
	Elements that subscribe to pharoTag view model in domain model are required to implement this methods."
]
