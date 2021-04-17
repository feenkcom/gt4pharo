Trait {
	#name : #TGtWithPharoPackageTagViewModel,
	#instVars : [
		'pharoPackageTagViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Support'
}

{ #category : #'api - pharo package tag view model' }
TGtWithPharoPackageTagViewModel >> hasPharoPackageTagViewModel [
	"Return a true if pharoPackageTag view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoPackageTagViewModel notNil
]

{ #category : #'api - pharo package tag view model' }
TGtWithPharoPackageTagViewModel >> onPharoPackageTagViewModelChanged [
	"Is sent when a new pharoPackageTag view model is assigned to the element.
	Note: #onPharoPackageTagViewModelChanged is sent before #subscribeToPharoPackageTagViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageTagViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo package tag view model' }
TGtWithPharoPackageTagViewModel >> onPostPharoPackageTagViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageTagViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo package tag view model' }
TGtWithPharoPackageTagViewModel >> pharoPackageTagViewModel [
	"Return a not-null pharoPackageTag view model assigned to the receiver element"
	self
		assert: [ pharoPackageTagViewModel notNil ]
		description: [ 'pharoPackageTag view model should be initialized' ].

	^ pharoPackageTagViewModel
]

{ #category : #'api - pharo package tag view model' }
TGtWithPharoPackageTagViewModel >> pharoPackageTagViewModel: aPharoPackageTagViewModel [
	"Set a not-null pharoPackageTag view model assigned to the receiver element"
	self
		assert: [ aPharoPackageTagViewModel notNil ]
		description: [ 'pharoPackageTag view model must not be nil' ].

	pharoPackageTagViewModel == aPharoPackageTagViewModel 
		ifTrue: [ ^ self ].

	pharoPackageTagViewModel ifNotNil: [ self unsubscribeFromPharoPackageTagViewModel ].
	pharoPackageTagViewModel := aPharoPackageTagViewModel.

	self onPharoPackageTagViewModelChanged.
	self subscribeToPharoPackageTagViewModel.
	self onPostPharoPackageTagViewModelChanged
]

{ #category : #'api - pharo package tag view model' }
TGtWithPharoPackageTagViewModel >> subscribeToPharoPackageTagViewModel [
	"Is sent after a new pharoPackageTag view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackageTagViewModel if elements subscribe to them"
]

{ #category : #'api - pharo package tag view model' }
TGtWithPharoPackageTagViewModel >> unsubscribeFromPharoPackageTagViewModel [
	"Is sent before a new pharoPackageTag view model is assigned to the element.
	Elements that subscribe to pharoPackageTag view model in domain model are required to implement this methods."
]
