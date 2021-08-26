Trait {
	#name : 'TGtWithPharoPackageTagsCoderViewModel',
	#instVars : [
		'pharoPackageTagsCoderViewModel'
	],
	#category : 'GToolkit-Pharo-Coder-UI-Support'
}

{ #category : 'api - pharo package tags coder view model' }
TGtWithPharoPackageTagsCoderViewModel >> hasPharoPackageTagsCoderViewModel [
	"Return a true if pharoPackageTagsCoder view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoPackageTagsCoderViewModel notNil
]

{ #category : 'api - pharo package tags coder view model' }
TGtWithPharoPackageTagsCoderViewModel >> onPharoPackageTagsCoderViewModelChanged [
	"Is sent when a new pharoPackageTagsCoder view model is assigned to the element.
	Note: #onPharoPackageTagsCoderViewModelChanged is sent before #subscribeToPharoPackageTagsCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageTagsCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : 'api - pharo package tags coder view model' }
TGtWithPharoPackageTagsCoderViewModel >> onPostPharoPackageTagsCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageTagsCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : 'api - pharo package tags coder view model' }
TGtWithPharoPackageTagsCoderViewModel >> pharoPackageTagsCoderViewModel [
	"Return a not-null pharoPackageTagsCoder view model assigned to the receiver element"
	self
		assert: [ pharoPackageTagsCoderViewModel notNil ]
		description: [ 'pharoPackageTagsCoder view model should be initialized' ].

	^ pharoPackageTagsCoderViewModel
]

{ #category : 'api - pharo package tags coder view model' }
TGtWithPharoPackageTagsCoderViewModel >> pharoPackageTagsCoderViewModel: aPharoPackageTagsCoderViewModel [
	"Set a not-null pharoPackageTagsCoder view model assigned to the receiver element"
	self
		assert: [ aPharoPackageTagsCoderViewModel notNil ]
		description: [ 'pharoPackageTagsCoder view model must not be nil' ].

	pharoPackageTagsCoderViewModel == aPharoPackageTagsCoderViewModel 
		ifTrue: [ ^ self ].

	pharoPackageTagsCoderViewModel ifNotNil: [ self unsubscribeFromPharoPackageTagsCoderViewModel ].
	pharoPackageTagsCoderViewModel := aPharoPackageTagsCoderViewModel.

	self onPharoPackageTagsCoderViewModelChanged.
	self subscribeToPharoPackageTagsCoderViewModel.
	self onPostPharoPackageTagsCoderViewModelChanged
]

{ #category : 'api - pharo package tags coder view model' }
TGtWithPharoPackageTagsCoderViewModel >> subscribeToPharoPackageTagsCoderViewModel [
	"Is sent after a new pharoPackageTagsCoder view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackageTagsCoderViewModel if elements subscribe to them"
]

{ #category : 'api - pharo package tags coder view model' }
TGtWithPharoPackageTagsCoderViewModel >> unsubscribeFromPharoPackageTagsCoderViewModel [
	"Is sent before a new pharoPackageTagsCoder view model is assigned to the element.
	Elements that subscribe to pharoPackageTagsCoder view model in domain model are required to implement this methods."
]
