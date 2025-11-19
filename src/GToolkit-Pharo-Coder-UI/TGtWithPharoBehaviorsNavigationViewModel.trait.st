Trait {
	#name : #TGtWithPharoBehaviorsNavigationViewModel,
	#instVars : [
		'pharoBehaviorsNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> hasPharoBehaviorsNavigationViewModel [
	"Return a true if pharoBehaviorsNavigation view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoBehaviorsNavigationViewModel notNil
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> onPharoBehaviorsNavigationViewModelChanged [
	"Is sent when a new pharoBehaviorsNavigation view model is assigned to the element.
	Note: #onPharoBehaviorsNavigationViewModelChanged is sent before #subscribeToPharoBehaviorsNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoBehaviorsNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> onPostPharoBehaviorsNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoBehaviorsNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> pharoBehaviorsNavigationViewModel [
	"Return a not-null pharoBehaviorsNavigation view model assigned to the receiver element"
	self
		assert: [ pharoBehaviorsNavigationViewModel notNil ]
		description: [ 'pharoBehaviorsNavigation view model should be initialized' ].

	^ pharoBehaviorsNavigationViewModel
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> pharoBehaviorsNavigationViewModel: aPharoBehaviorsNavigationViewModel [
	"Set a not-null pharoBehaviorsNavigation view model assigned to the receiver element"
	self
		assert: [ aPharoBehaviorsNavigationViewModel notNil ]
		description: [ 'pharoBehaviorsNavigation view model must not be nil' ].

	pharoBehaviorsNavigationViewModel == aPharoBehaviorsNavigationViewModel 
		ifTrue: [ ^ self ].

	pharoBehaviorsNavigationViewModel ifNotNil: [ self unsubscribeFromPharoBehaviorsNavigationViewModel ].
	pharoBehaviorsNavigationViewModel := aPharoBehaviorsNavigationViewModel.

	self onPharoBehaviorsNavigationViewModelChanged.
	self subscribeToPharoBehaviorsNavigationViewModel.
	self onPostPharoBehaviorsNavigationViewModelChanged
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> subscribeToPharoBehaviorsNavigationViewModel [
	"Is sent after a new pharoBehaviorsNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoBehaviorsNavigationViewModel if elements subscribe to them"
]

{ #category : #'api - pharo behaviors navigation view model' }
TGtWithPharoBehaviorsNavigationViewModel >> unsubscribeFromPharoBehaviorsNavigationViewModel [
	"Is sent before a new pharoBehaviorsNavigation view model is assigned to the element.
	Elements that subscribe to pharoBehaviorsNavigation view model in domain model are required to implement this methods."
]
