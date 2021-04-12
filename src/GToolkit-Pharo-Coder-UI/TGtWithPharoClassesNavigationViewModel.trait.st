Trait {
	#name : #TGtWithPharoClassesNavigationViewModel,
	#instVars : [
		'pharoClassesNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo classes navigation view model' }
TGtWithPharoClassesNavigationViewModel >> hasPharoClassesNavigationViewModel [
	"Return a true if pharoClassesNavigation view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoClassesNavigationViewModel notNil
]

{ #category : #'api - pharo classes navigation view model' }
TGtWithPharoClassesNavigationViewModel >> onPharoClassesNavigationViewModelChanged [
	"Is sent when a new pharoClassesNavigation view model is assigned to the element.
	Note: #onPharoClassesNavigationViewModelChanged is sent before #subscribeToPharoClassesNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoClassesNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo classes navigation view model' }
TGtWithPharoClassesNavigationViewModel >> onPostPharoClassesNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoClassesNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo classes navigation view model' }
TGtWithPharoClassesNavigationViewModel >> pharoClassesNavigationViewModel [
	"Return a not-null pharoClassesNavigation view model assigned to the receiver element"
	self
		assert: [ pharoClassesNavigationViewModel notNil ]
		description: [ 'pharoClassesNavigation view model should be initialized' ].

	^ pharoClassesNavigationViewModel
]

{ #category : #'api - pharo classes navigation view model' }
TGtWithPharoClassesNavigationViewModel >> pharoClassesNavigationViewModel: aPharoClassesNavigationViewModel [
	"Set a not-null pharoClassesNavigation view model assigned to the receiver element"
	self
		assert: [ aPharoClassesNavigationViewModel notNil ]
		description: [ 'pharoClassesNavigation view model must not be nil' ].

	pharoClassesNavigationViewModel == aPharoClassesNavigationViewModel 
		ifTrue: [ ^ self ].

	pharoClassesNavigationViewModel ifNotNil: [ self unsubscribeFromPharoClassesNavigationViewModel ].
	pharoClassesNavigationViewModel := aPharoClassesNavigationViewModel.

	self onPharoClassesNavigationViewModelChanged.
	self subscribeToPharoClassesNavigationViewModel.
	self onPostPharoClassesNavigationViewModelChanged
]

{ #category : #'api - pharo classes navigation view model' }
TGtWithPharoClassesNavigationViewModel >> subscribeToPharoClassesNavigationViewModel [
	"Is sent after a new pharoClassesNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoClassesNavigationViewModel if elements subscribe to them"
]

{ #category : #'api - pharo classes navigation view model' }
TGtWithPharoClassesNavigationViewModel >> unsubscribeFromPharoClassesNavigationViewModel [
	"Is sent before a new pharoClassesNavigation view model is assigned to the element.
	Elements that subscribe to pharoClassesNavigation view model in domain model are required to implement this methods."
]
