Trait {
	#name : #TGtWithPharoTagNavigationViewModel,
	#instVars : [
		'pharoTagNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> hasPharoTagNavigationViewModel [
	"Return a true if pharoTagNavigation view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoTagNavigationViewModel notNil
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> onPharoTagNavigationViewModelChanged [
	"Is sent when a new pharoTagNavigation view model is assigned to the element.
	Note: #onPharoTagNavigationViewModelChanged is sent before #subscribeToPharoTagNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> onPostPharoTagNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoTagNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> pharoTagNavigationViewModel [
	"Return a not-null pharoTagNavigation view model assigned to the receiver element"
	self
		assert: [ pharoTagNavigationViewModel notNil ]
		description: [ 'pharoTagNavigation view model should be initialized' ].

	^ pharoTagNavigationViewModel
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> pharoTagNavigationViewModel: aPharoTagNavigationViewModel [
	"Set a not-null pharoTagNavigation view model assigned to the receiver element"
	self
		assert: [ aPharoTagNavigationViewModel notNil ]
		description: [ 'pharoTagNavigation view model must not be nil' ].

	pharoTagNavigationViewModel == aPharoTagNavigationViewModel 
		ifTrue: [ ^ self ].

	pharoTagNavigationViewModel ifNotNil: [ self unsubscribeFromPharoTagNavigationViewModel ].
	pharoTagNavigationViewModel := aPharoTagNavigationViewModel.

	self onPharoTagNavigationViewModelChanged.
	self subscribeToPharoTagNavigationViewModel.
	self onPostPharoTagNavigationViewModelChanged
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> subscribeToPharoTagNavigationViewModel [
	"Is sent after a new pharoTagNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoTagNavigationViewModel if elements subscribe to them"
]

{ #category : #'api - pharo tag navigation view model' }
TGtWithPharoTagNavigationViewModel >> unsubscribeFromPharoTagNavigationViewModel [
	"Is sent before a new pharoTagNavigation view model is assigned to the element.
	Elements that subscribe to pharoTagNavigation view model in domain model are required to implement this methods."
]
