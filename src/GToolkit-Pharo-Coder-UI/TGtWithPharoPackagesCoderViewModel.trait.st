Trait {
	#name : 'TGtWithPharoPackagesCoderViewModel',
	#instVars : [
		'pharoPackagesCoderViewModel'
	],
	#category : 'GToolkit-Pharo-Coder-UI-Support'
}

{ #category : 'api - pharo packages coder view model' }
TGtWithPharoPackagesCoderViewModel >> hasPharoPackagesCoderViewModel [
	"Return a true if pharoPackagesCoder view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoPackagesCoderViewModel notNil
]

{ #category : 'api - pharo packages coder view model' }
TGtWithPharoPackagesCoderViewModel >> onPharoPackagesCoderViewModelChanged [
	"Is sent when a new pharoPackagesCoder view model is assigned to the element.
	Note: #onPharoPackagesCoderViewModelChanged is sent before #subscribeToPharoPackagesCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : 'api - pharo packages coder view model' }
TGtWithPharoPackagesCoderViewModel >> onPostPharoPackagesCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackagesCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : 'api - pharo packages coder view model' }
TGtWithPharoPackagesCoderViewModel >> pharoPackagesCoderViewModel [
	"Return a not-null pharoPackagesCoder view model assigned to the receiver element"
	self
		assert: [ pharoPackagesCoderViewModel notNil ]
		description: [ 'pharoPackagesCoder view model should be initialized' ].

	^ pharoPackagesCoderViewModel
]

{ #category : 'api - pharo packages coder view model' }
TGtWithPharoPackagesCoderViewModel >> pharoPackagesCoderViewModel: aPharoPackagesCoderViewModel [
	"Set a not-null pharoPackagesCoder view model assigned to the receiver element"
	self
		assert: [ aPharoPackagesCoderViewModel notNil ]
		description: [ 'pharoPackagesCoder view model must not be nil' ].

	pharoPackagesCoderViewModel == aPharoPackagesCoderViewModel 
		ifTrue: [ ^ self ].

	pharoPackagesCoderViewModel ifNotNil: [ self unsubscribeFromPharoPackagesCoderViewModel ].
	pharoPackagesCoderViewModel := aPharoPackagesCoderViewModel.

	self onPharoPackagesCoderViewModelChanged.
	self subscribeToPharoPackagesCoderViewModel.
	self onPostPharoPackagesCoderViewModelChanged
]

{ #category : 'api - pharo packages coder view model' }
TGtWithPharoPackagesCoderViewModel >> subscribeToPharoPackagesCoderViewModel [
	"Is sent after a new pharoPackagesCoder view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackagesCoderViewModel if elements subscribe to them"
]

{ #category : 'api - pharo packages coder view model' }
TGtWithPharoPackagesCoderViewModel >> unsubscribeFromPharoPackagesCoderViewModel [
	"Is sent before a new pharoPackagesCoder view model is assigned to the element.
	Elements that subscribe to pharoPackagesCoder view model in domain model are required to implement this methods."
]
