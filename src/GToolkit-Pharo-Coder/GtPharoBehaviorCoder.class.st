Class {
	#name : #GtPharoBehaviorCoder,
	#superclass : #GtCoderModel,
	#traits : 'TGtCoderTrait + TGtCoderWithObjectHolder',
	#classTraits : 'TGtCoderTrait classTrait + TGtCoderWithObjectHolder classTrait',
	#instVars : [
		'class',
		'definitionCoder'
	],
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #constants }
GtPharoBehaviorCoder class >> behaviorNameEditorName [
	^ #'behavior-coder--behavior-name-editor'
]

{ #category : #'instance creation' }
GtPharoBehaviorCoder class >> forClass: aBehavior [
	^ self new
		forClass: aBehavior;
		yourself
]

{ #category : #'instance creation' }
GtPharoBehaviorCoder class >> forObject: anObject [
	^ self new
		forObject: anObject;
		yourself
]

{ #category : #'api - converting' }
GtPharoBehaviorCoder >> asNewCoderModelWithSameSubject [
	"Return new coder model with same subject (e.g., package, class, method)"
	<return: #GtCoderModel>
	^ self hasObject 
		ifTrue: [ self class forObject: self object ] 
		ifFalse: [ self class forClass: self behavior ]
]

{ #category : #accessing }
GtPharoBehaviorCoder >> behavior [
	<return: #Behavior>

	^ class
]

{ #category : #accessing }
GtPharoBehaviorCoder >> classIconAddOnsInto: coderAddOns for: aViewModel [ 
	<gtAstCoderAddOns: 10>
	| iconName |
	
	iconName := self behavior gtCustomSystemIconNameOrNil.
	iconName ifNil: [ 
		"We only show the icon in case it is a custom one"
		^ self ].
	
	coderAddOns
		addPreview: 'Class Icon'
		stencil: [ 
			(aViewModel behavior gtSafeIconNamed: iconName) asElement ]
]

{ #category : #accessing }
GtPharoBehaviorCoder >> coderName [
	^ self theClass name
]

{ #category : #initialize }
GtPharoBehaviorCoder >> createRemoveClassPreviewElementWithSource: anElement [ 
	"Hook method that can be replaced in case another element is needed"
	^ GtPharoRemoveClassPreviewStencil new
			classToRemove: self theClass;
			anElement: anElement;
			create
]

{ #category : #accessing }
GtPharoBehaviorCoder >> definitionCoder [
	<return: #GtPharoBehaviorDefinitionCoder>

	^ definitionCoder
]

{ #category : #initialize }
GtPharoBehaviorCoder >> forClass: aClass [
	self objectHolder: GtCoderUndefinedObject default.
	self initializeClass: aClass.
]

{ #category : #initialize }
GtPharoBehaviorCoder >> forObject: anObject [
	self object: anObject.
]

{ #category : #'gt-extension' }
GtPharoBehaviorCoder >> gtLiveFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Class';
		priority: 1;
		stencil: self;
		actionButtonIcon: BrGlamorousVectorIcons browse
			action: [ :aButton | self theClass browse ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			action: [ :aButton | aButton phlow spawnObject: self theClass ]
]

{ #category : #accessing }
GtPharoBehaviorCoder >> icon [
	^ BrGlamorousIcons classicon
]

{ #category : #initialize }
GtPharoBehaviorCoder >> initializeAddOns: addOns viewModel: aGtPharoMethodCoderViewModel [

	super
		initializeAddOns: addOns
		viewModel: aGtPharoMethodCoderViewModel.

	(addOns
		addDropDownWithPreviewAction: 'Remove' translated
		icon: BrGlamorousVectorIcons remove
		action: [ :aButtonElement :aButtonModel :anEvent | 
			self removeClass ]
		stencil: [ :element | 
			self createRemoveClassPreviewElementWithSource: element ]) 
				id: GtBehaviorCoderBehaviorDeleteButtonId
]

{ #category : #initialize }
GtPharoBehaviorCoder >> initializeClass: aClass [
	self
		assert: [ class isNil ]
		description: [ 'Can not change the behavior behind this coder' ].

	class := aClass.
	definitionCoder := GtPharoBehaviorDefinitionCoder forBehavior: class
]

{ #category : #testing }
GtPharoBehaviorCoder >> isForClass [
	^ true
]

{ #category : #accessing }
GtPharoBehaviorCoder >> name [
	^ self theClass name
]

{ #category : #'private - announcement handling' }
GtPharoBehaviorCoder >> onMethodsCoderFiltersChanged: aGtCodersFiltersChanged [
	self announcer announce: aGtCodersFiltersChanged.
]

{ #category : #'api - object' }
GtPharoBehaviorCoder >> onObjectHolderChanged [
	"Trait users can perform other actions using this hook."

	self
		ifObject: [ :anObject | 
			self initializeClass: anObject class instanceSide ]
		ifNone: [  ]
]

{ #category : #accessing }
GtPharoBehaviorCoder >> package [
	^ self theClass package
]

{ #category : #accessing }
GtPharoBehaviorCoder >> packageTag [
	| tag |
	tag := self package tagOrNilOf: self theClass.
	(tag isNil or: [ tag isRoot ]) ifTrue: [ ^ nil ].
	^ tag
]

{ #category : #printing }
GtPharoBehaviorCoder >> printOn: aStream [
	aStream
		nextPutAll: 'Behavior Coder';
		space;
		nextPut: $(;
		print: self name;
		nextPut: $)
]

{ #category : #actions }
GtPharoBehaviorCoder >> removeClass [
	(RBRemoveClassChange removeClassName: self theClass name) gtExecuteWithUndo
]

{ #category : #accessing }
GtPharoBehaviorCoder >> theClass [
	<return: #Class>

	^ class
]

{ #category : #'api - navigation' }
GtPharoBehaviorCoder >> withMethodProtocol: aMethodProtocol source: aSource [

	self announce: (GtClassCoderMethodProtocolNavigationAnnouncement new 
		source: aSource;
		methodProtocol: aMethodProtocol)
]

{ #category : #'api - navigation' }
GtPharoBehaviorCoder >> withSelectedMethod: aMethod [
	self
		assert: [ class instanceSide = aMethod methodClass instanceSide ]
		description: [ 'Can not select a method from a different class' ].

	self announce: (GtClassCoderMethodNavigationAnnouncement new method: aMethod)
]

{ #category : #'api - navigation' }
GtPharoBehaviorCoder >> withSelectedMethods: aCollectionOfMethods [
	self
		assert: [ aCollectionOfMethods
				allSatisfy: [ :eachMethod | class instanceSide = eachMethod methodClass instanceSide ] ]
		description: [ 'Can not select a method from a different class' ].

	self
		announce: (GtClassCoderMethodsNavigationAnnouncement new methods: aCollectionOfMethods)
]

{ #category : #accessing }
GtPharoBehaviorCoder >> withSlot: aSlot source: aSource [ 
	self announce: (GtClassCoderSlotNavigationAnnouncement new 
		source: aSource;
		slot: aSlot)
]
