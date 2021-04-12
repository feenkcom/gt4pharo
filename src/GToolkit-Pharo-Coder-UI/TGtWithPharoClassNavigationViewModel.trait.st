Trait {
	#name : #TGtWithPharoClassNavigationViewModel,
	#instVars : [
		'pharoClassNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - pharo class navigation view model' }
TGtWithPharoClassNavigationViewModel >> hasPharoClassNavigationViewModel [
	"Return a true if pharoClassNavigation view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoClassNavigationViewModel notNil
]

{ #category : #'api - pharo class navigation view model' }
TGtWithPharoClassNavigationViewModel >> onPharoClassNavigationViewModelChanged [
	"Is sent when a new pharoClassNavigation view model is assigned to the element.
	Note: #onPharoClassNavigationViewModelChanged is sent before #subscribeToPharoClassNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoClassNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo class navigation view model' }
TGtWithPharoClassNavigationViewModel >> onPostPharoClassNavigationViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoClassNavigationViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo class navigation view model' }
TGtWithPharoClassNavigationViewModel >> pharoClassNavigationViewModel [
	"Return a not-null pharoClassNavigation view model assigned to the receiver element"
	self
		assert: [ pharoClassNavigationViewModel notNil ]
		description: [ 'pharoClassNavigation view model should be initialized' ].

	^ pharoClassNavigationViewModel
]

{ #category : #'api - pharo class navigation view model' }
TGtWithPharoClassNavigationViewModel >> pharoClassNavigationViewModel: aPharoClassNavigationViewModel [
	"Set a not-null pharoClassNavigation view model assigned to the receiver element"
	self
		assert: [ aPharoClassNavigationViewModel notNil ]
		description: [ 'pharoClassNavigation view model must not be nil' ].

	pharoClassNavigationViewModel == aPharoClassNavigationViewModel 
		ifTrue: [ ^ self ].

	pharoClassNavigationViewModel ifNotNil: [ self unsubscribeFromPharoClassNavigationViewModel ].
	pharoClassNavigationViewModel := aPharoClassNavigationViewModel.

	self onPharoClassNavigationViewModelChanged.
	self subscribeToPharoClassNavigationViewModel.
	self onPostPharoClassNavigationViewModelChanged
]

{ #category : #'api - pharo class navigation view model' }
TGtWithPharoClassNavigationViewModel >> subscribeToPharoClassNavigationViewModel [
	"Is sent after a new pharoClassNavigation view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoClassNavigationViewModel if elements subscribe to them"
]

{ #category : #'api - pharo class navigation view model' }
TGtWithPharoClassNavigationViewModel >> unsubscribeFromPharoClassNavigationViewModel [
	"Is sent before a new pharoClassNavigation view model is assigned to the element.
	Elements that subscribe to pharoClassNavigation view model in domain model are required to implement this methods."
]
