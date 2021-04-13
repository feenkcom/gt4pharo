Trait {
	#name : #TGtWithPharoBehaviorNavigationViewModel,
	#instVars : [
		'pharoBehaviorNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> hasPharoBehaviorNavigationViewModel [
	"Return a true if pharoBehaviorNavigation view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoBehaviorNavigationViewModel notNil
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> onPharoBehaviorNavigationViewModelChanged [
	"Is sent when a new pharoBehaviorNavigation view model is assigned to the element.
	Note: #onPharoBehaviorNavigationViewModelChanged is sent before #subscribeToPharoBehaviorNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoBehaviorNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> onPostPharoBehaviorNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoBehaviorNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> pharoBehaviorNavigationViewModel [
	"Return a not-null pharoBehaviorNavigation view model assigned to the receiver element"
	self
		assert: [ pharoBehaviorNavigationViewModel notNil ]
		description: [ 'pharoBehaviorNavigation view model should be initialized' ].

	^ pharoBehaviorNavigationViewModel
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> pharoBehaviorNavigationViewModel: aPharoBehaviorNavigationViewModel [
	"Set a not-null pharoBehaviorNavigation view model assigned to the receiver element"
	self
		assert: [ aPharoBehaviorNavigationViewModel notNil ]
		description: [ 'pharoBehaviorNavigation view model must not be nil' ].

	pharoBehaviorNavigationViewModel == aPharoBehaviorNavigationViewModel 
		ifTrue: [ ^ self ].

	pharoBehaviorNavigationViewModel ifNotNil: [ self unsubscribeFromPharoBehaviorNavigationViewModel ].
	pharoBehaviorNavigationViewModel := aPharoBehaviorNavigationViewModel.

	self onPharoBehaviorNavigationViewModelChanged.
	self subscribeToPharoBehaviorNavigationViewModel.
	self onPostPharoBehaviorNavigationViewModelChanged
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> subscribeToPharoBehaviorNavigationViewModel [
	"Is sent after a new pharoBehaviorNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoBehaviorNavigationViewModel if elements subscribe to them"
]

{ #category : #'api - pharo behavior navigation view model' }
TGtWithPharoBehaviorNavigationViewModel >> unsubscribeFromPharoBehaviorNavigationViewModel [
	"Is sent before a new pharoBehaviorNavigation view model is assigned to the element.
	Elements that subscribe to pharoBehaviorNavigation view model in domain model are required to implement this methods."
]
