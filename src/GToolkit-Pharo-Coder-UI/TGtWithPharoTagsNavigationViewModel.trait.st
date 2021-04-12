Trait {
	#name : #TGtWithPharoTagsNavigationViewModel,
	#instVars : [
		'pharoTagsNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> hasPharoTagsNavigationViewModel [
	"Return a true if pharoTagsNavigation view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoTagsNavigationViewModel notNil
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> onPharoTagsNavigationViewModelChanged [
	"Is sent when a new pharoTagsNavigation view model is assigned to the element.
	Note: #onPharoTagsNavigationViewModelChanged is sent before #subscribeToPharoTagsNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagsNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> onPostPharoTagsNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoTagsNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> pharoTagsNavigationViewModel [
	"Return a not-null pharoTagsNavigation view model assigned to the receiver element"
	self
		assert: [ pharoTagsNavigationViewModel notNil ]
		description: [ 'pharoTagsNavigation view model should be initialized' ].

	^ pharoTagsNavigationViewModel
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> pharoTagsNavigationViewModel: aPharoTagsNavigationViewModel [
	"Set a not-null pharoTagsNavigation view model assigned to the receiver element"
	self
		assert: [ aPharoTagsNavigationViewModel notNil ]
		description: [ 'pharoTagsNavigation view model must not be nil' ].

	pharoTagsNavigationViewModel == aPharoTagsNavigationViewModel 
		ifTrue: [ ^ self ].

	pharoTagsNavigationViewModel ifNotNil: [ self unsubscribeFromPharoTagsNavigationViewModel ].
	pharoTagsNavigationViewModel := aPharoTagsNavigationViewModel.

	self onPharoTagsNavigationViewModelChanged.
	self subscribeToPharoTagsNavigationViewModel.
	self onPostPharoTagsNavigationViewModelChanged
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> subscribeToPharoTagsNavigationViewModel [
	"Is sent after a new pharoTagsNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoTagsNavigationViewModel if elements subscribe to them"
]

{ #category : #'api - pharo tags navigation view model' }
TGtWithPharoTagsNavigationViewModel >> unsubscribeFromPharoTagsNavigationViewModel [
	"Is sent before a new pharoTagsNavigation view model is assigned to the element.
	Elements that subscribe to pharoTagsNavigation view model in domain model are required to implement this methods."
]
