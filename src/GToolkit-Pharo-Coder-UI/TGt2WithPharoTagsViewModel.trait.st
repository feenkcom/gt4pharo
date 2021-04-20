Trait {
	#name : #TGt2WithPharoTagsViewModel,
	#instVars : [
		'pharoTagsViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-!  - Support'
}

{ #category : #'api - pharo tags view model' }
TGt2WithPharoTagsViewModel >> hasPharoTagsViewModel [
	"Return a true if pharoTags view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoTagsViewModel notNil
]

{ #category : #'api - pharo tags view model' }
TGt2WithPharoTagsViewModel >> onPharoTagsViewModelChanged [
	"Is sent when a new pharoTags view model is assigned to the element.
	Note: #onPharoTagsViewModelChanged is sent before #subscribeToPharoTagsViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagsViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo tags view model' }
TGt2WithPharoTagsViewModel >> onPostPharoTagsViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoTagsViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo tags view model' }
TGt2WithPharoTagsViewModel >> pharoTagsViewModel [
	"Return a not-null pharoTags view model assigned to the receiver element"
	self
		assert: [ pharoTagsViewModel notNil ]
		description: [ 'pharoTags view model should be initialized' ].

	^ pharoTagsViewModel
]

{ #category : #'api - pharo tags view model' }
TGt2WithPharoTagsViewModel >> pharoTagsViewModel: aPharoTagsViewModel [
	"Set a not-null pharoTags view model assigned to the receiver element"
	self
		assert: [ aPharoTagsViewModel notNil ]
		description: [ 'pharoTags view model must not be nil' ].

	pharoTagsViewModel == aPharoTagsViewModel 
		ifTrue: [ ^ self ].

	pharoTagsViewModel ifNotNil: [ self unsubscribeFromPharoTagsViewModel ].
	pharoTagsViewModel := aPharoTagsViewModel.

	self onPharoTagsViewModelChanged.
	self subscribeToPharoTagsViewModel.
	self onPostPharoTagsViewModelChanged
]

{ #category : #'api - pharo tags view model' }
TGt2WithPharoTagsViewModel >> subscribeToPharoTagsViewModel [
	"Is sent after a new pharoTags view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoTagsViewModel if elements subscribe to them"
]

{ #category : #'api - pharo tags view model' }
TGt2WithPharoTagsViewModel >> unsubscribeFromPharoTagsViewModel [
	"Is sent before a new pharoTags view model is assigned to the element.
	Elements that subscribe to pharoTags view model in domain model are required to implement this methods."
]
