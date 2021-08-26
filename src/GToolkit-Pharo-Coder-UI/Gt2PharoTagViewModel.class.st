"
# GtPharoPackageTagCoder View Model
## Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - {{gtMethod:Gt2PharoTagViewModel>>#parentPharoTagsViewModel}} returns a parent view model ({{gtClass:Gt2PharoTagsViewModel}}) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - {{gtMethod:Gt2PharoTagViewModel>>#parentPharoTagsViewModel:}} allows users to assign a non-null parent view model ({{gtClass:Gt2PharoTagsViewModel}}).
 - {{gtMethod:Gt2PharoTagViewModel>>#hasParentPharoTagsViewModel}} can be used to test if a parent view model ({{gtClass:Gt2PharoTagsViewModel}}) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using {{gtMethod:Gt2PharoTagViewModel>>#hasParentPharoTagsViewModel}} before trying to access {{gtMethod:Gt2PharoTagViewModel>>#parentPharoTagsViewModel}}

"
Class {
	#name : 'Gt2PharoTagViewModel',
	#superclass : 'Object',
	#traits : 'TGtWithPharoPackageTagCoderModel',
	#classTraits : 'TGtWithPharoPackageTagCoderModel classTrait',
	#instVars : [
		'announcer',
		'parentPharoTagsViewModel'
	],
	#category : 'GToolkit-Pharo-Coder-UI-!  - View Models'
}

{ #category : 'api - announcer' }
Gt2PharoTagViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch an event to the parent view model if it is assigned"
	self hasParentPharoTagsViewModel
		ifTrue: [ self parentPharoTagsViewModel announce: anAnnouncement ].
]

{ #category : 'api - accessing' }
Gt2PharoTagViewModel >> hasParentPharoTagsViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester: #tags>

	^ parentPharoTagsViewModel notNil
]

{ #category : 'api - testing' }
Gt2PharoTagViewModel >> isPharoTagViewModel [
	"Return true if this is a view model of Tag, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : 'api - testing' }
Gt2PharoTagViewModel >> isPharoTagsViewModel [
	"Return true if this is a view model of Tags, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : 'api - accessing' }
Gt2PharoTagViewModel >> parentPharoTagsViewModel [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #Gt2PharoTagsViewModel>
	<parentViewModelGetter: #tags>

	self
		assert: [ parentPharoTagsViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ parentPharoTagsViewModel
]

{ #category : 'api - accessing' }
Gt2PharoTagViewModel >> parentPharoTagsViewModel: aGt2PharoTagsViewModel [
	"Assign a parent view model (${class:Gt2PharoTagsViewModel}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"
	<parentViewModelSetter: #tags>

	self
		assert: [ aGt2PharoTagsViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoTagsViewModel := aGt2PharoTagsViewModel
]

{ #category : 'printing' }
Gt2PharoTagViewModel >> printOn: aStream [
	aStream
		print: self pharoPackageTagCoderModel
]

{ #category : 'api - announcer' }
Gt2PharoTagViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : 'api - accessing' }
Gt2PharoTagViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #tag
]

{ #category : 'api - announcer' }
Gt2PharoTagViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : 'api - announcer' }
Gt2PharoTagViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
