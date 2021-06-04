"
# GtPharoBehaviorCoder View Model
## Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - {{gtMethod:GtPharoBehaviorNavigationViewModel>>#parentPharoBehaviorsNavigationViewModel}} returns a parent view model ({{gtClass:GtPharoBehaviorsNavigationViewModel}}) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - {{gtMethod:GtPharoBehaviorNavigationViewModel>>#parentPharoBehaviorsNavigationViewModel:}} allows users to assign a non-null parent view model ({{gtClass:GtPharoBehaviorsNavigationViewModel}}).
 - {{gtMethod:GtPharoBehaviorNavigationViewModel>>#hasParentPharoBehaviorsNavigationViewModel}} can be used to test if a parent view model ({{gtClass:GtPharoBehaviorsNavigationViewModel}}) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using {{gtMethod:GtPharoBehaviorNavigationViewModel>>#hasParentPharoBehaviorsNavigationViewModel}} before trying to access {{gtMethod:GtPharoBehaviorNavigationViewModel>>#parentPharoBehaviorsNavigationViewModel}}
## Additional `selectedBehaviorViewModel` api for a child view model
{{gtClass:GtPharoBehaviorNavigationViewModel}} is a child of the {{gtClass:GtPharoBehaviorsNavigationViewModel}} which supports `selectedBehaviorViewModel` property. Since that property is a single choice out of many, it is useful for the child view model to implement an additional api to ease the wor process with the property.
A few of the most useful api methods are:
 - {{gtMethod:GtPharoBehaviorNavigationViewModel>>#isSelectedBehavior}} allows users to check if a particular child view model is the property value of the the parent view model ({{gtMethod:GtPharoBehaviorsNavigationViewModel>>#selectedBehaviorViewModel}}).
 - {{gtMethod:GtPharoBehaviorNavigationViewModel>>#isOnlySelectedBehavior}} allows users to check if a particular child view model is the property value of the the parent view model ({{gtMethod:GtPharoBehaviorsNavigationViewModel>>#selectedBehaviorViewModel}}) and that thre are no child view models of {{gtClass:GtPharoBehaviorNavigationViewModel}} that have the sasme property `selectedBehaviorViewModel` set.
 - {{gtMethod:GtPharoBehaviorNavigationViewModel>>#deselectOtherEntities}} ensures that none of the {{gtClass:GtPharoBehaviorNavigationViewModel}} child view models have `selectedBehaviorViewModel` property set. It is useful when users want to make sure that some view model is a leaf in the hierarchy of view models with which have assigned `selectedBehaviorViewModel` property.
 - {{gtMethod:GtPharoBehaviorNavigationViewModel>>#notifyBehaviorSelected}} sends an announcement ({{gtClass:GtPharoBehaviorNavigationViewModelSelected}}) indicating that the child view model is now the property value in the parent view model ({{gtMethod:GtPharoBehaviorsNavigationViewModel>>#selectedBehaviorViewModel}}). At this point {{gtMethod:GtPharoBehaviorNavigationViewModel>>#isSelectedBehavior}} returns `true`.
 - {{gtMethod:GtPharoBehaviorNavigationViewModel>>#notifyBehaviorDeselected}} sends an announcement ({{gtClass:GtPharoBehaviorNavigationViewModelDeselected}}) indicating that the child view model is no more the property value in the parent view model ({{gtMethod:GtPharoBehaviorsNavigationViewModel>>#selectedBehaviorViewModel}}). At this point {{gtMethod:GtPharoBehaviorNavigationViewModel>>#isSelectedBehavior}} returns `false`.

"
Class {
	#name : #GtPharoBehaviorNavigationViewModel,
	#superclass : #Object,
	#traits : 'TGtWithPharoBehaviorCoderModel',
	#classTraits : 'TGtWithPharoBehaviorCoderModel classTrait',
	#instVars : [
		'announcer',
		'parentPharoBehaviorsNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - announcer' }
GtPharoBehaviorNavigationViewModel >> announce: anAnnouncement [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch an event to the parent view model if it is assigned"
	self hasParentPharoBehaviorsNavigationViewModel
		ifTrue: [ self parentPharoBehaviorsNavigationViewModel announce: anAnnouncement ].
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> deselectOtherEntities [
	"deselect any selected child"
	<propertyUnsetOthers: #selectedBehaviorViewModel>
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> hasOtherSelectedEntities [
	"Return true if there are other selected entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #selectedBehaviorViewModel>

	^ false
]

{ #category : #'api - accessing' }
GtPharoBehaviorNavigationViewModel >> hasParentPharoBehaviorsNavigationViewModel [
	"Return true if the parent view model is attached"
	<return: #Boolean>
	<parentViewModelTester: #behaviors>

	^ parentPharoBehaviorsNavigationViewModel notNil
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> isOnlySelectedBehavior [
	"Return true if only this behavior is selected and not any of the children"
	<return: #Boolean>

	^ self isSelectedBehavior and: [ self hasOtherSelectedEntities not ]
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoBehaviorNavigationViewModel [
	"Return true if this is a view model of Behavior, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoBehaviorsNavigationViewModel [
	"Return true if this is a view model of Behaviors, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoPackageNavigationViewModel [
	"Return true if this is a view model of Package, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoPackagesNavigationViewModel [
	"Return true if this is a view model of Packages, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoTagNavigationViewModel [
	"Return true if this is a view model of Tag, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoBehaviorNavigationViewModel >> isPharoTagsNavigationViewModel [
	"Return true if this is a view model of Tags, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> isSelectedBehavior [
	"Return true if this behavior is selected"
	<return: #Boolean>

	^ self parentPharoBehaviorsNavigationViewModel hasSelectedBehaviorViewModel
		and: [ self parentPharoBehaviorsNavigationViewModel selectedBehaviorViewModel == self ]
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> notifyBehaviorDeselected [
	<propertyUnsetNotifier: #selectedBehaviorViewModel>

	self announce: (GtPharoBehaviorNavigationViewModelDeselected new behaviorViewModel: self)
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> notifyBehaviorSelected [
	<propertySetNotifier: #selectedBehaviorViewModel>

	self announce: (GtPharoBehaviorNavigationViewModelSelected new behaviorViewModel: self)
]

{ #category : #'api - accessing' }
GtPharoBehaviorNavigationViewModel >> parentPharoBehaviorsNavigationViewModel [
	"Return a parent view model which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model."
	<return: #GtPharoBehaviorsNavigationViewModel>
	<parentViewModelGetter: #behaviors>

	self
		assert: [ parentPharoBehaviorsNavigationViewModel notNil ]
		description: [ 'Parent view model is not assigned!' ].

	^ parentPharoBehaviorsNavigationViewModel
]

{ #category : #'api - accessing' }
GtPharoBehaviorNavigationViewModel >> parentPharoBehaviorsNavigationViewModel: aGtPharoBehaviorsNavigationViewModel [
	"Assign a parent view model (${class:GtPharoBehaviorsNavigationViewModel}$) which is used to access various state properties,
	for example parent view model is responsible for knowing a selected child view model.
	In order for the child to know if it is selected, that child should know the parent view model"
	<parentViewModelSetter: #behaviors>

	self
		assert: [ aGtPharoBehaviorsNavigationViewModel notNil ]
		description: [ 'Parent view model must not be nil' ].

	parentPharoBehaviorsNavigationViewModel := aGtPharoBehaviorsNavigationViewModel
]

{ #category : #printing }
GtPharoBehaviorNavigationViewModel >> printOn: aStream [
	aStream
		print: self pharoBehaviorCoderModel
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> selectBehavior [
	"Just select a behavior without changing children"
	<propertySetter: #selectedBehaviorViewModel>

	self parentPharoBehaviorsNavigationViewModel selectBehaviorViewModel: self
]

{ #category : #'api - selection' }
GtPharoBehaviorNavigationViewModel >> selectBehaviorWithoutOtherEntities [
	"Select a behavior and deselect other selected children"

	self deselectOtherEntities.
	self selectBehavior
]

{ #category : #'api - announcer' }
GtPharoBehaviorNavigationViewModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - accessing' }
GtPharoBehaviorNavigationViewModel >> viewModelName [
	"Return a symbolic name of this view model which helps to create (view model -> element class) mappings.
	Note: The symbolic name of the view model is the exact name that was used
	in the view model declaration from which this view model was generated"
	<return: #Symbol>

	^ #behavior
]

{ #category : #'api - announcer' }
GtPharoBehaviorNavigationViewModel >> when: anAnnouncementClass do: aBlock [
	(announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtPharoBehaviorNavigationViewModel >> when: anAnnouncementClass send: aSelector to: anObject [
	(announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
