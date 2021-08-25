Trait {
	#name : 'TGtWithPharoPackageTagCoderViewModel',
	#instVars : [
		'pharoPackageTagCoderViewModel'
	],
	#category : 'GToolkit-Pharo-Coder-UI-Support'
}

{ #category : 'api - pharo package tag coder view model' }
TGtWithPharoPackageTagCoderViewModel >> hasPharoPackageTagCoderViewModel [
	"Return a true if pharoPackageTagCoder view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoPackageTagCoderViewModel notNil
]

{ #category : 'api - pharo package tag coder view model' }
TGtWithPharoPackageTagCoderViewModel >> onPharoPackageTagCoderViewModelChanged [
	"Is sent when a new pharoPackageTagCoder view model is assigned to the element.
	Note: #onPharoPackageTagCoderViewModelChanged is sent before #subscribeToPharoPackageTagCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageTagCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : 'api - pharo package tag coder view model' }
TGtWithPharoPackageTagCoderViewModel >> onPostPharoPackageTagCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageTagCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : 'api - pharo package tag coder view model' }
TGtWithPharoPackageTagCoderViewModel >> pharoPackageTagCoderViewModel [
	"Return a not-null pharoPackageTagCoder view model assigned to the receiver element"
	self
		assert: [ pharoPackageTagCoderViewModel notNil ]
		description: [ 'pharoPackageTagCoder view model should be initialized' ].

	^ pharoPackageTagCoderViewModel
]

{ #category : 'api - pharo package tag coder view model' }
TGtWithPharoPackageTagCoderViewModel >> pharoPackageTagCoderViewModel: aPharoPackageTagCoderViewModel [
	"Set a not-null pharoPackageTagCoder view model assigned to the receiver element"
	self
		assert: [ aPharoPackageTagCoderViewModel notNil ]
		description: [ 'pharoPackageTagCoder view model must not be nil' ].

	pharoPackageTagCoderViewModel == aPharoPackageTagCoderViewModel 
		ifTrue: [ ^ self ].

	pharoPackageTagCoderViewModel ifNotNil: [ self unsubscribeFromPharoPackageTagCoderViewModel ].
	pharoPackageTagCoderViewModel := aPharoPackageTagCoderViewModel.

	self onPharoPackageTagCoderViewModelChanged.
	self subscribeToPharoPackageTagCoderViewModel.
	self onPostPharoPackageTagCoderViewModelChanged
]

{ #category : 'api - pharo package tag coder view model' }
TGtWithPharoPackageTagCoderViewModel >> subscribeToPharoPackageTagCoderViewModel [
	"Is sent after a new pharoPackageTagCoder view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackageTagCoderViewModel if elements subscribe to them"
]

{ #category : 'api - pharo package tag coder view model' }
TGtWithPharoPackageTagCoderViewModel >> unsubscribeFromPharoPackageTagCoderViewModel [
	"Is sent before a new pharoPackageTagCoder view model is assigned to the element.
	Elements that subscribe to pharoPackageTagCoder view model in domain model are required to implement this methods."
]
