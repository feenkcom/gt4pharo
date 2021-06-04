"
# GtPharoPackageTagCoder View Model
## Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - {{gtMethod:GtPharoPackageTagCoderViewModel>>#parentPharoPackageTagsCoderViewModel}} returns a parent view model ({{gtClass:GtPharoPackageTagsCoderViewModel}}) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - {{gtMethod:GtPharoPackageTagCoderViewModel>>#parentPharoPackageTagsCoderViewModel:}} allows users to assign a non-null parent view model ({{gtClass:GtPharoPackageTagsCoderViewModel}}).
 - {{gtMethod:GtPharoPackageTagCoderViewModel>>#hasParentPharoPackageTagsCoderViewModel}} can be used to test if a parent view model ({{gtClass:GtPharoPackageTagsCoderViewModel}}) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using {{gtMethod:GtPharoPackageTagCoderViewModel>>#hasParentPharoPackageTagsCoderViewModel}} before trying to access {{gtMethod:GtPharoPackageTagCoderViewModel>>#parentPharoPackageTagsCoderViewModel}}

"
Class {
	#name : #GtPharoPackageTagCoderViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageTagCoderModel',
	#classTraits : 'TGtWithPharoPackageTagCoderModel classTrait',
	#instVars : [
		'announcer',
		'parentPharoPackageTagsCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-View Models'
}

{ #category : #'api - announcer' }
GtPharoPackageTagCoderViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch an event to the parent view model if it is assigned"
	self hasParentPharoPackageTagsCoderViewModel
		ifTrue: [ self parentPharoPackageTagsCoderViewModel announce: anAnnouncement ].
]

{ #category : #'api - accessing' }
GtPharoPackageTagCoderViewModel >> hasParentPharoPackageTagsCoderViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester: #packageTags>

	^ parentPharoPackageTagsCoderViewModel notNil
]

{ #category : #'api - testing' }
GtPharoPackageTagCoderViewModel >> isPharoPackageCoderViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackageTagCoderViewModel >> isPharoPackageTagCoderViewModel [
	"Return true if this is a view model of PackageTag, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - testing' }
GtPharoPackageTagCoderViewModel >> isPharoPackageTagsCoderViewModel [
	"Return true if this is a view model of PackageTags, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackageTagCoderViewModel >> isPharoPackagesCoderViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - accessing' }
GtPharoPackageTagCoderViewModel >> parentPharoPackageTagsCoderViewModel [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #GtPharoPackageTagsCoderViewModel>
	<parentViewModelGetter: #packageTags>

	self
		assert: [ parentPharoPackageTagsCoderViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ parentPharoPackageTagsCoderViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageTagCoderViewModel >> parentPharoPackageTagsCoderViewModel: aGtPharoPackageTagsCoderViewModel [
	"Assign a parent view model (${class:GtPharoPackageTagsCoderViewModel}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"
	<parentViewModelSetter: #packageTags>

	self
		assert: [ aGtPharoPackageTagsCoderViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackageTagsCoderViewModel := aGtPharoPackageTagsCoderViewModel
]

{ #category : #printing }
GtPharoPackageTagCoderViewModel >> printOn: aStream [
	aStream
		print: self pharoPackageTagCoderModel
]

{ #category : #'api - announcer' }
GtPharoPackageTagCoderViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoPackageTagCoderViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #packageTag
]

{ #category : #'api - announcer' }
GtPharoPackageTagCoderViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoPackageTagCoderViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
