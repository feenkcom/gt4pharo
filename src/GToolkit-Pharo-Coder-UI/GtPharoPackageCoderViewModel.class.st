"
# GtPharoPackageCoder View Model
## Accessing a view model for `packageTagsCoder` domain model
{{gtClass:GtPharoPackageCoderViewModel}} is a view model for a `pharoPackageTagCoderModel` domain model which in turn contains `packageTagsCoder` domain model. To accomodate that child domain model, a corresponding {{gtClass:GtPharoPackageTagsCoderViewModel}} is created and assigned as the child view model of {{gtClass:GtPharoPackageCoderViewModel}}.
That child view model is instantiated lazily by {{gtMethod:GtPharoPackageCoderViewModel>>#createPharoPackageTagsCoderViewModel}} and can be accessed with the help of {{gtMethod:GtPharoPackageCoderViewModel>>#pharoPackageTagsCoderViewModel}}.
## Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - {{gtMethod:GtPharoPackageCoderViewModel>>#parentPharoPackagesCoderViewModel}} returns a parent view model ({{gtClass:GtPharoPackagesCoderViewModel}}) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - {{gtMethod:GtPharoPackageCoderViewModel>>#parentPharoPackagesCoderViewModel:}} allows users to assign a non-null parent view model ({{gtClass:GtPharoPackagesCoderViewModel}}).
 - {{gtMethod:GtPharoPackageCoderViewModel>>#hasParentPharoPackagesCoderViewModel}} can be used to test if a parent view model ({{gtClass:GtPharoPackagesCoderViewModel}}) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using {{gtMethod:GtPharoPackageCoderViewModel>>#hasParentPharoPackagesCoderViewModel}} before trying to access {{gtMethod:GtPharoPackageCoderViewModel>>#parentPharoPackagesCoderViewModel}}

"
Class {
	#name : #GtPharoPackageCoderViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoPackageCoderModel',
	#classTraits : 'TGtWithPharoPackageCoderModel classTrait',
	#instVars : [
		'announcer',
		'pharoPackageTagsCoderViewModel',
		'parentPharoPackagesCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-View Models'
}

{ #category : #'api - announcer' }
GtPharoPackageCoderViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch an event to the parent view model if it is assigned"
	self hasParentPharoPackagesCoderViewModel
		ifTrue: [ self parentPharoPackagesCoderViewModel announce: anAnnouncement ].
]

{ #category : #accessing }
GtPharoPackageCoderViewModel >> asElement [
	^ GtPharoPackageCoderElement new coderViewModel: self
]

{ #category : #accessing }
GtPharoPackageCoderViewModel >> coder [
	^ self pharoPackageCoderModel
]

{ #category : #'private - instance creation' }
GtPharoPackageCoderViewModel >> createPharoPackageTagsCoderViewModel [
	"Create a composite view model for a collection of children and return the result"
	<return: #GtPharoPackageTagsCoderViewModel>
	| childrenViewModel |

	childrenViewModel := GtPharoPackageTagsCoderViewModel new.
	childrenViewModel parentPharoPackageCoderViewModel: self.
	childrenViewModel pharoPackageTagsCoderModel: self pharoPackageTagCoderModel packageTagsCoder.
	^ childrenViewModel
]

{ #category : #accessing }
GtPharoPackageCoderViewModel >> elementClass [
	^ GtPharoPackageCoderElement
]

{ #category : #'api - accessing' }
GtPharoPackageCoderViewModel >> hasParentPharoPackagesCoderViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester: #packages>

	^ parentPharoPackagesCoderViewModel notNil
]

{ #category : #'api - testing' }
GtPharoPackageCoderViewModel >> isPharoPackageCoderViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - testing' }
GtPharoPackageCoderViewModel >> isPharoPackageTagCoderViewModel [
	"Return true if this is a view model of PackageTag, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackageCoderViewModel >> isPharoPackageTagsCoderViewModel [
	"Return true if this is a view model of PackageTags, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoPackageCoderViewModel >> isPharoPackagesCoderViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - accessing' }
GtPharoPackageCoderViewModel >> parentPharoPackagesCoderViewModel [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #GtPharoPackagesCoderViewModel>
	<parentViewModelGetter: #packages>

	self
		assert: [ parentPharoPackagesCoderViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ parentPharoPackagesCoderViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageCoderViewModel >> parentPharoPackagesCoderViewModel: aGtPharoPackagesCoderViewModel [
	"Assign a parent view model (${class:GtPharoPackagesCoderViewModel}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"
	<parentViewModelSetter: #packages>

	self
		assert: [ aGtPharoPackagesCoderViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoPackagesCoderViewModel := aGtPharoPackagesCoderViewModel
]

{ #category : #'api - accessing' }
GtPharoPackageCoderViewModel >> pharoPackageTagsCoderViewModel [
	"Return a composite view model (${class:GtPharoPackageTagsCoderViewModel}$) created for a collection of children from the domain model.
	Note: The view model is lazily instantiated."
	<return: #GtPharoPackageTagsCoderViewModel>

	^  pharoPackageTagsCoderViewModel ifNil: [ pharoPackageTagsCoderViewModel := self createPharoPackageTagsCoderViewModel ]
]

{ #category : #printing }
GtPharoPackageCoderViewModel >> printOn: aStream [
	aStream
		print: self pharoPackageTagCoderModel
]

{ #category : #'api - announcer' }
GtPharoPackageCoderViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoPackageCoderViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #package
]

{ #category : #'api - announcer' }
GtPharoPackageCoderViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoPackageCoderViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
