"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	packageCoderViewModel:		<Object>


    Implementation Points
"
Trait {
	#name : #TGtPharoWithPackageCoderViewModel,
	#instVars : [
		'packageCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-View Models'
}

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> hasPackageCoderViewModel [
	"Return a true if packageCoder view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ packageCoderViewModel notNil
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> onPackageCoderViewModelChanged [
	"Is sent when a new packageCoder view model is assigned to the element.
	Note: #onPackageCoderViewModelChanged is sent before #subscribeToPackageCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPackageCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> onPostPackageCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToPackageCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> packageCoderViewModel [
	"Return a not-null packageCoder view model assigned to the receiver element"
	self
		assert: [ packageCoderViewModel notNil ]
		description: [ 'packageCoder view model should be initialized' ].

	^ packageCoderViewModel
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> packageCoderViewModel: aPackageCoderViewModel [
	"Set a not-null packageCoder view model assigned to the receiver element"
	<viewModelSetter>
	self
		assert: [ aPackageCoderViewModel notNil ]
		description: [ 'packageCoder view model must not be nil' ].

	packageCoderViewModel == aPackageCoderViewModel 
		ifTrue: [ ^ self ].

	packageCoderViewModel ifNotNil: [ self unsubscribeFromPackageCoderViewModel ].
	packageCoderViewModel := aPackageCoderViewModel.

	self onPackageCoderViewModelChanged.
	self subscribeToPackageCoderViewModel.
	self onPostPackageCoderViewModelChanged
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> subscribeToPackageCoderViewModel [
	"Is sent after a new packageCoder view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPackageCoderViewModel if elements subscribe to them"
]

{ #category : #'api - package coder view model' }
TGtPharoWithPackageCoderViewModel >> unsubscribeFromPackageCoderViewModel [
	"Is sent before a new packageCoder view model is assigned to the element.
	Elements that subscribe to packageCoder view model in domain model are required to implement this methods."
]
