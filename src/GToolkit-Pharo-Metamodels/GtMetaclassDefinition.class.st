Class {
	#name : #GtMetaclassDefinition,
	#superclass : #GtBehaviorDefinition,
	#instVars : [
		'slots',
		'category',
		'methods'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtMetaclassDefinition class >> forNew [
	^ self new forNew
]

{ #category : #'instance creation' }
GtMetaclassDefinition class >> fromMetaclass: aMetaclass [
	^ self new fromMetaclass: aMetaclass
]

{ #category : #'instance creation' }
GtMetaclassDefinition class >> fromMetaclass: aMetaclass in: anEnvironment [
	^ self new fromMetaclass: aMetaclass in: anEnvironment
]

{ #category : #converting }
GtMetaclassDefinition >> asDefinitionString [
	^ String streamContents: [:stream |
		stream
			nextPutAll: self name;
			space;
			nextPutAll: 'class';
			crtab;
			nextPutAll: 'slots: ';
			nextPutAll: self slots asDefinitionString ]
]

{ #category : #accessing }
GtMetaclassDefinition >> category [
	<return: #GtCategoryDefinition>

	^ category
]

{ #category : #'private - accessing' }
GtMetaclassDefinition >> category: aGtCategoryDefinition [
	category := aGtCategoryDefinition parent: self
]

{ #category : #accessing }
GtMetaclassDefinition >> classOrMetaClass [
	| instanceName |
	instanceName := self originalName.
	(instanceName endsWith: ' class')
		ifTrue: [ instanceName := instanceName allButLast: 6 ].
	^ (self class environment at: instanceName asSymbol ifAbsent: [  ])
		ifNotNil: [ :cls | cls class ]
]

{ #category : #'api - accepting' }
GtMetaclassDefinition >> createBehaviorChange [
	^ GtRBAddMetaclassWithSlotsChange definition: self asDefinitionString
]

{ #category : #'api - accepting' }
GtMetaclassDefinition >> createChange [
	| aCompositeChange theMethodsChange |

	aCompositeChange := (RBCompositeRefactoryChange named: 'Define metaclass').	
	aCompositeChange addChange: self createBehaviorChange.
	
	theMethodsChange := self methods createChange.
	theMethodsChange changes do: [ :eachMethodChange |
		eachMethodChange
			behaviorName: self name;
			isMeta: true ].
	aCompositeChange addChange: theMethodsChange.

	^ aCompositeChange
]

{ #category : #'api - accepting' }
GtMetaclassDefinition >> differenceWith: aMetaclassDefinition [
	| aDifference |
	
	self
		assert: [ aMetaclassDefinition class = self class ]
		description: [ 'Must be of the same type' ].
	
	aDifference := GtMetaclassDefinitionDifference new.

	self name = aMetaclassDefinition name
		ifFalse: [ aDifference nameFrom: aMetaclassDefinition name to: self name ].

	aDifference add: (self slots differenceWith: aMetaclassDefinition slots).

	^ aDifference
]

{ #category : #initialization }
GtMetaclassDefinition >> forNew [
	"Initialize me from a new Metaclass"
	
	name := self defaultNewClassName.
	originalName := name.
	
	category := GtCategoryDefinition empty parent: self.
	slots := GtSlotsDefinition empty parent: self.
	methods := GtPharoMethodsDefinition new parent: self
]

{ #category : #initialization }
GtMetaclassDefinition >> fromMetaclass: aMetaclass [
	"Initialize me from a given real Metaclass"

	self fromMetaclass: aMetaclass in: self environment
]

{ #category : #initialization }
GtMetaclassDefinition >> fromMetaclass: aMetaclass in: anEnvironment [
	"Initialize me from a given real Metaclass"
	self
		assert: [ anEnvironment notNil ]
		description: [ 'Environment must not be nil' ].

	self environment: anEnvironment.
	
	name := aMetaclass instanceSide name.
	originalName := name.
	
	category := (GtCategoryDefinition fromBehavior: aMetaclass) parent: self.
	slots := (GtClassSlotsDefinition fromClass: aMetaclass) parent: self.
	methods := GtPharoMethodsDefinition new parent: self
]

{ #category : #testing }
GtMetaclassDefinition >> isForMetaclass [
	^ true
]

{ #category : #accessing }
GtMetaclassDefinition >> methods [
	^ methods
]

{ #category : #'private - accessing' }
GtMetaclassDefinition >> methods: aGtMethodsDefinition [
	methods := aGtMethodsDefinition parent: self
]

{ #category : #accessing }
GtMetaclassDefinition >> postCopy [
	<generatedFrom: #'GtPharoMethodTemplates>>#postCopyTemplate'>
	super postCopy.
	
	category := category copy parent: self.
	name := name copy.
	originalName := originalName copy.
	slots := slots copy parent: self.
	methods := methods copy parent: self
]

{ #category : #accessing }
GtMetaclassDefinition >> slots [
	<return: #GtSlotsDefinition>

	^ slots
]

{ #category : #'private - accessing' }
GtMetaclassDefinition >> slots: aGtSlotsDefinition [
	slots := aGtSlotsDefinition parent: self
]

{ #category : #accessing }
GtMetaclassDefinition >> storeOn: aStream [
	<generatedFrom: #'GtPharoMethodTemplates>>#storeOnTemplate'>
	aStream
		nextPut: $(;
		nextPutAll: self class name;
		space;
		nextPutAll: 'new'.
	aStream
		space;
		nextPutAll: 'category:';
		space;
		store: self category;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'name:';
		space;
		store: self name;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'slots:';
		space;
		store: self slots.
	aStream
		space;
		nextPutAll: 'methods:';
		space;
		store: self methods.
	aStream
		nextPut: $)
]
