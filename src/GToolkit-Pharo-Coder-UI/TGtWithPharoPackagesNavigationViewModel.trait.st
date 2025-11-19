Trait {
	#name : #TGtWithPharoPackagesNavigationViewModel,
	#instVars : [
		'pharoPackagesNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> hasPharoPackagesNavigationViewModel [
	"Return a true if pharoPackagesNavigation view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoPackagesNavigationViewModel notNil
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> onPharoPackagesNavigationViewModelChanged [
	"Is sent when a new pharoPackagesNavigation view model is assigned to the element.
	Note: #onPharoPackagesNavigationViewModelChanged is sent before #subscribeToPharoPackagesNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> onPostPharoPackagesNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackagesNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> pharoPackagesNavigationViewModel [
	"Return a not-null pharoPackagesNavigation view model assigned to the receiver element"
	self
		assert: [ pharoPackagesNavigationViewModel notNil ]
		description: [ 'pharoPackagesNavigation view model should be initialized' ].

	^ pharoPackagesNavigationViewModel
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> pharoPackagesNavigationViewModel: aPharoPackagesNavigationViewModel [
	"Set a not-null pharoPackagesNavigation view model assigned to the receiver element"
	self
		assert: [ aPharoPackagesNavigationViewModel notNil ]
		description: [ 'pharoPackagesNavigation view model must not be nil' ].

	pharoPackagesNavigationViewModel == aPharoPackagesNavigationViewModel 
		ifTrue: [ ^ self ].

	pharoPackagesNavigationViewModel ifNotNil: [ self unsubscribeFromPharoPackagesNavigationViewModel ].
	pharoPackagesNavigationViewModel := aPharoPackagesNavigationViewModel.

	self onPharoPackagesNavigationViewModelChanged.
	self subscribeToPharoPackagesNavigationViewModel.
	self onPostPharoPackagesNavigationViewModelChanged
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> subscribeToPharoPackagesNavigationViewModel [
	"Is sent after a new pharoPackagesNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackagesNavigationViewModel if elements subscribe to them"
]

{ #category : #'api - pharo packages navigation view model' }
TGtWithPharoPackagesNavigationViewModel >> unsubscribeFromPharoPackagesNavigationViewModel [
	"Is sent before a new pharoPackagesNavigation view model is assigned to the element.
	Elements that subscribe to pharoPackagesNavigation view model in domain model are required to implement this methods."
]
