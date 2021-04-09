Trait {
	#name : #TGtWithPharoPackageTagNavigationViewModel,
	#instVars : [
		'pharoPackageTagNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - pharo package tag navigation view model' }
TGtWithPharoPackageTagNavigationViewModel >> hasPharoPackageTagNavigationViewModel [
	"Return a true if pharoPackageTagNavigation view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoPackageTagNavigationViewModel notNil
]

{ #category : #'api - pharo package tag navigation view model' }
TGtWithPharoPackageTagNavigationViewModel >> onPharoPackageTagNavigationViewModelChanged [
	"Is sent when a new pharoPackageTagNavigation view model is assigned to the element.
	Note: #onPharoPackageTagNavigationViewModelChanged is sent before #subscribeToPharoPackageTagNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageTagNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo package tag navigation view model' }
TGtWithPharoPackageTagNavigationViewModel >> onPostPharoPackageTagNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageTagNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo package tag navigation view model' }
TGtWithPharoPackageTagNavigationViewModel >> pharoPackageTagNavigationViewModel [
	"Return a not-null pharoPackageTagNavigation view model assigned to the receiver element"
	self
		assert: [ pharoPackageTagNavigationViewModel notNil ]
		description: [ 'pharoPackageTagNavigation view model should be initialized' ].

	^ pharoPackageTagNavigationViewModel
]

{ #category : #'api - pharo package tag navigation view model' }
TGtWithPharoPackageTagNavigationViewModel >> pharoPackageTagNavigationViewModel: aPharoPackageTagNavigationViewModel [
	"Set a not-null pharoPackageTagNavigation view model assigned to the receiver element"
	self
		assert: [ aPharoPackageTagNavigationViewModel notNil ]
		description: [ 'pharoPackageTagNavigation view model must not be nil' ].

	pharoPackageTagNavigationViewModel == aPharoPackageTagNavigationViewModel 
		ifTrue: [ ^ self ].

	pharoPackageTagNavigationViewModel ifNotNil: [ self unsubscribeFromPharoPackageTagNavigationViewModel ].
	pharoPackageTagNavigationViewModel := aPharoPackageTagNavigationViewModel.

	self onPharoPackageTagNavigationViewModelChanged.
	self subscribeToPharoPackageTagNavigationViewModel.
	self onPostPharoPackageTagNavigationViewModelChanged
]

{ #category : #'api - pharo package tag navigation view model' }
TGtWithPharoPackageTagNavigationViewModel >> subscribeToPharoPackageTagNavigationViewModel [
	"Is sent after a new pharoPackageTagNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackageTagNavigationViewModel if elements subscribe to them"
]

{ #category : #'api - pharo package tag navigation view model' }
TGtWithPharoPackageTagNavigationViewModel >> unsubscribeFromPharoPackageTagNavigationViewModel [
	"Is sent before a new pharoPackageTagNavigation view model is assigned to the element.
	Elements that subscribe to pharoPackageTagNavigation view model in domain model are required to implement this methods."
]
