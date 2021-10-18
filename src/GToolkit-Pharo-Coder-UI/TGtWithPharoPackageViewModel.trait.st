Trait {
	#name : #TGtWithPharoPackageViewModel,
	#instVars : [
		'pharoPackageViewModel'
	],
	#category : 'GToolkit-Pharo-Coder-UI-Support'
}

{ #category : #'api - pharo package view model' }
TGtWithPharoPackageViewModel >> hasPharoPackageViewModel [
	"Return a true if pharoPackage view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoPackageViewModel notNil
]

{ #category : #'api - pharo package view model' }
TGtWithPharoPackageViewModel >> onPharoPackageViewModelChanged [
	"Is sent when a new pharoPackage view model is assigned to the element.
	Note: #onPharoPackageViewModelChanged is sent before #subscribeToPharoPackageViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo package view model' }
TGtWithPharoPackageViewModel >> onPostPharoPackageViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo package view model' }
TGtWithPharoPackageViewModel >> pharoPackageViewModel [
	"Return a not-null pharoPackage view model assigned to the receiver element"
	self
		assert: [ pharoPackageViewModel notNil ]
		description: [ 'pharoPackage view model should be initialized' ].

	^ pharoPackageViewModel
]

{ #category : #'api - pharo package view model' }
TGtWithPharoPackageViewModel >> pharoPackageViewModel: aPharoPackageViewModel [
	"Set a not-null pharoPackage view model assigned to the receiver element"
	self
		assert: [ aPharoPackageViewModel notNil ]
		description: [ 'pharoPackage view model must not be nil' ].

	pharoPackageViewModel == aPharoPackageViewModel 
		ifTrue: [ ^ self ].

	pharoPackageViewModel ifNotNil: [ self unsubscribeFromPharoPackageViewModel ].
	pharoPackageViewModel := aPharoPackageViewModel.

	self onPharoPackageViewModelChanged.
	self subscribeToPharoPackageViewModel.
	self onPostPharoPackageViewModelChanged
]

{ #category : #'api - pharo package view model' }
TGtWithPharoPackageViewModel >> subscribeToPharoPackageViewModel [
	"Is sent after a new pharoPackage view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackageViewModel if elements subscribe to them"
]

{ #category : #'api - pharo package view model' }
TGtWithPharoPackageViewModel >> unsubscribeFromPharoPackageViewModel [
	"Is sent before a new pharoPackage view model is assigned to the element.
	Elements that subscribe to pharoPackage view model in domain model are required to implement this methods."
]
