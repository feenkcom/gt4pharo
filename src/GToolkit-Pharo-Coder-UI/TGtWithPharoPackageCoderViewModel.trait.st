Trait {
	#name : #TGtWithPharoPackageCoderViewModel,
	#instVars : [
		'pharoPackageCoderViewModel'
	],
	#category : 'GToolkit-Pharo-Coder-UI-Support'
}

{ #category : #'api - pharo package coder view model' }
TGtWithPharoPackageCoderViewModel >> hasPharoPackageCoderViewModel [
	"Return a true if pharoPackageCoder view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoPackageCoderViewModel notNil
]

{ #category : #'api - pharo package coder view model' }
TGtWithPharoPackageCoderViewModel >> onPharoPackageCoderViewModelChanged [
	"Is sent when a new pharoPackageCoder view model is assigned to the element.
	Note: #onPharoPackageCoderViewModelChanged is sent before #subscribeToPharoPackageCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo package coder view model' }
TGtWithPharoPackageCoderViewModel >> onPostPharoPackageCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo package coder view model' }
TGtWithPharoPackageCoderViewModel >> pharoPackageCoderViewModel [
	"Return a not-null pharoPackageCoder view model assigned to the receiver element"
	self
		assert: [ pharoPackageCoderViewModel notNil ]
		description: [ 'pharoPackageCoder view model should be initialized' ].

	^ pharoPackageCoderViewModel
]

{ #category : #'api - pharo package coder view model' }
TGtWithPharoPackageCoderViewModel >> pharoPackageCoderViewModel: aPharoPackageCoderViewModel [
	"Set a not-null pharoPackageCoder view model assigned to the receiver element"
	self
		assert: [ aPharoPackageCoderViewModel notNil ]
		description: [ 'pharoPackageCoder view model must not be nil' ].

	pharoPackageCoderViewModel == aPharoPackageCoderViewModel 
		ifTrue: [ ^ self ].

	pharoPackageCoderViewModel ifNotNil: [ self unsubscribeFromPharoPackageCoderViewModel ].
	pharoPackageCoderViewModel := aPharoPackageCoderViewModel.

	self onPharoPackageCoderViewModelChanged.
	self subscribeToPharoPackageCoderViewModel.
	self onPostPharoPackageCoderViewModelChanged
]

{ #category : #'api - pharo package coder view model' }
TGtWithPharoPackageCoderViewModel >> subscribeToPharoPackageCoderViewModel [
	"Is sent after a new pharoPackageCoder view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackageCoderViewModel if elements subscribe to them"
]

{ #category : #'api - pharo package coder view model' }
TGtWithPharoPackageCoderViewModel >> unsubscribeFromPharoPackageCoderViewModel [
	"Is sent before a new pharoPackageCoder view model is assigned to the element.
	Elements that subscribe to pharoPackageCoder view model in domain model are required to implement this methods."
]
