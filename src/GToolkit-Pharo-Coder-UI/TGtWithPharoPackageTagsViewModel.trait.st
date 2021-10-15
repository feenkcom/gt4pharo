Trait {
	#name : #TGtWithPharoPackageTagsViewModel,
	#instVars : [
		'pharoPackageTagsViewModel'
	],
	#category : 'GToolkit-Pharo-Coder-UI-Support'
}

{ #category : #'api - pharo package tags view model' }
TGtWithPharoPackageTagsViewModel >> hasPharoPackageTagsViewModel [
	"Return a true if pharoPackageTags view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pharoPackageTagsViewModel notNil
]

{ #category : #'api - pharo package tags view model' }
TGtWithPharoPackageTagsViewModel >> onPharoPackageTagsViewModelChanged [
	"Is sent when a new pharoPackageTags view model is assigned to the element.
	Note: #onPharoPackageTagsViewModelChanged is sent before #subscribeToPharoPackageTagsViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageTagsViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - pharo package tags view model' }
TGtWithPharoPackageTagsViewModel >> onPostPharoPackageTagsViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPharoPackageTagsViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - pharo package tags view model' }
TGtWithPharoPackageTagsViewModel >> pharoPackageTagsViewModel [
	"Return a not-null pharoPackageTags view model assigned to the receiver element"
	self
		assert: [ pharoPackageTagsViewModel notNil ]
		description: [ 'pharoPackageTags view model should be initialized' ].

	^ pharoPackageTagsViewModel
]

{ #category : #'api - pharo package tags view model' }
TGtWithPharoPackageTagsViewModel >> pharoPackageTagsViewModel: aPharoPackageTagsViewModel [
	"Set a not-null pharoPackageTags view model assigned to the receiver element"
	self
		assert: [ aPharoPackageTagsViewModel notNil ]
		description: [ 'pharoPackageTags view model must not be nil' ].

	pharoPackageTagsViewModel == aPharoPackageTagsViewModel 
		ifTrue: [ ^ self ].

	pharoPackageTagsViewModel ifNotNil: [ self unsubscribeFromPharoPackageTagsViewModel ].
	pharoPackageTagsViewModel := aPharoPackageTagsViewModel.

	self onPharoPackageTagsViewModelChanged.
	self subscribeToPharoPackageTagsViewModel.
	self onPostPharoPackageTagsViewModelChanged
]

{ #category : #'api - pharo package tags view model' }
TGtWithPharoPackageTagsViewModel >> subscribeToPharoPackageTagsViewModel [
	"Is sent after a new pharoPackageTags view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPharoPackageTagsViewModel if elements subscribe to them"
]

{ #category : #'api - pharo package tags view model' }
TGtWithPharoPackageTagsViewModel >> unsubscribeFromPharoPackageTagsViewModel [
	"Is sent before a new pharoPackageTags view model is assigned to the element.
	Elements that subscribe to pharoPackageTags view model in domain model are required to implement this methods."
]
