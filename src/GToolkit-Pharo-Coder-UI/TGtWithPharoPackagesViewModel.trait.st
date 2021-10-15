Trait {
	#name : #TGtWithPharoPackagesViewModel,
	#instVars : [
		'pharoPackagesViewModel'
	],
	#category : 'GToolkit-Pharo-Coder-UI-Support'
}

{ #category : #'api - pharo packages view model' }
TGtWithPharoPackagesViewModel >> hasPharoPackagesViewModel [
	"Return a true if pharoPackages view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoPackagesViewModel notNil
]

{ #category : #'api - pharo packages view model' }
TGtWithPharoPackagesViewModel >> onPharoPackagesViewModelChanged [
	"Is sent when a new pharoPackages view model is assigned to the element.
	Note: #onPharoPackagesViewModelChanged is sent before #subscribeToPharoPackagesViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo packages view model' }
TGtWithPharoPackagesViewModel >> onPostPharoPackagesViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackagesViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo packages view model' }
TGtWithPharoPackagesViewModel >> pharoPackagesViewModel [
	"Return a not-null pharoPackages view model assigned to the receiver element"
	self
		assert: [ pharoPackagesViewModel notNil ]
		description: [ 'pharoPackages view model should be initialized' ].

	^ pharoPackagesViewModel
]

{ #category : #'api - pharo packages view model' }
TGtWithPharoPackagesViewModel >> pharoPackagesViewModel: aPharoPackagesViewModel [
	"Set a not-null pharoPackages view model assigned to the receiver element"
	self
		assert: [ aPharoPackagesViewModel notNil ]
		description: [ 'pharoPackages view model must not be nil' ].

	pharoPackagesViewModel == aPharoPackagesViewModel 
		ifTrue: [ ^ self ].

	pharoPackagesViewModel ifNotNil: [ self unsubscribeFromPharoPackagesViewModel ].
	pharoPackagesViewModel := aPharoPackagesViewModel.

	self onPharoPackagesViewModelChanged.
	self subscribeToPharoPackagesViewModel.
	self onPostPharoPackagesViewModelChanged
]

{ #category : #'api - pharo packages view model' }
TGtWithPharoPackagesViewModel >> subscribeToPharoPackagesViewModel [
	"Is sent after a new pharoPackages view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackagesViewModel if elements subscribe to them"
]

{ #category : #'api - pharo packages view model' }
TGtWithPharoPackagesViewModel >> unsubscribeFromPharoPackagesViewModel [
	"Is sent before a new pharoPackages view model is assigned to the element.
	Elements that subscribe to pharoPackages view model in domain model are required to implement this methods."
]
