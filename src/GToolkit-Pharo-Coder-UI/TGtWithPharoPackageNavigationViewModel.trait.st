Trait {
	#name : #TGtWithPharoPackageNavigationViewModel,
	#instVars : [
		'pharoPackageNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> hasPharoPackageNavigationViewModel [
	"Return a true if pharoPackageNavigation view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoPackageNavigationViewModel notNil
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> onPharoPackageNavigationViewModelChanged [
	"Is sent when a new pharoPackageNavigation view model is assigned to the element.
	Note: #onPharoPackageNavigationViewModelChanged is sent before #subscribeToPharoPackageNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> onPostPharoPackageNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> pharoPackageNavigationViewModel [
	"Return a not-null pharoPackageNavigation view model assigned to the receiver element"
	self
		assert: [ pharoPackageNavigationViewModel notNil ]
		description: [ 'pharoPackageNavigation view model should be initialized' ].

	^ pharoPackageNavigationViewModel
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> pharoPackageNavigationViewModel: aPharoPackageNavigationViewModel [
	"Set a not-null pharoPackageNavigation view model assigned to the receiver element"
	self
		assert: [ aPharoPackageNavigationViewModel notNil ]
		description: [ 'pharoPackageNavigation view model must not be nil' ].

	pharoPackageNavigationViewModel == aPharoPackageNavigationViewModel 
		ifTrue: [ ^ self ].

	pharoPackageNavigationViewModel ifNotNil: [ self unsubscribeFromPharoPackageNavigationViewModel ].
	pharoPackageNavigationViewModel := aPharoPackageNavigationViewModel.

	self onPharoPackageNavigationViewModelChanged.
	self subscribeToPharoPackageNavigationViewModel.
	self onPostPharoPackageNavigationViewModelChanged
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> subscribeToPharoPackageNavigationViewModel [
	"Is sent after a new pharoPackageNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackageNavigationViewModel if elements subscribe to them"
]

{ #category : #'api - pharo package navigation view model' }
TGtWithPharoPackageNavigationViewModel >> unsubscribeFromPharoPackageNavigationViewModel [
	"Is sent before a new pharoPackageNavigation view model is assigned to the element.
	Elements that subscribe to pharoPackageNavigation view model in domain model are required to implement this methods."
]
