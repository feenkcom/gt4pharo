Class {
	#name : #GtClassDefinition,
	#superclass : #GtBehaviorDefinition,
	#instVars : [
		'layout',
		'category',
		'comment',
		'slots',
		'classVariables',
		'traits',
		'pools',
		'superclass',
		'methods'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtClassDefinition class >> forNew [
	^ self new forNew
]

{ #category : #'instance creation' }
GtClassDefinition class >> fromClass: aClass [
	^ self new fromClass: aClass
]

{ #category : #'instance creation' }
GtClassDefinition class >> fromClass: aClass in: anEnvironment [
	^ self new fromClass: aClass in: anEnvironment
]

{ #category : #converting }
GtClassDefinition >> asDefinitionString [
	<return: #String>
	| aStream |

	aStream := (String new: 800) writeStream.
	aStream nextPutAll: self superclass asDefinitionString.

	aStream nextPutAll: ' subclass: ';
			store: self name.

	(self traits isEmpty) ifFalse: [
		aStream cr; tab; nextPutAll: 'uses: ';
			nextPutAll: self traits asDefinitionString ].		
			
	(self layout layoutName = #FixedLayout) ifFalse: [
		aStream cr; tab; nextPutAll: 'layout: ';
			nextPutAll: self layout layoutName].
	
	"Slots"
	aStream cr; tab; nextPutAll: 'slots: ';
			nextPutAll: self slots asDefinitionString.
	
	"Class vars"
	aStream cr; tab; nextPutAll: 'classVariables: ';
			nextPutAll: self classVariables asDefinitionString.
	
	"Pool Dictionaries"
	aStream cr; tab; nextPutAll: 'poolDictionaries: ';
		store: self pools asDefinitionString.

	aStream cr; tab; nextPutAll: 'package: ';
			store: self category asDefinitionString.

	self superclass hasSuperclass ifFalse: [ 
		aStream nextPutAll: '.'; cr.
		aStream nextPutAll: self name.
		aStream space; nextPutAll: 'superclass: nil'. ].

	^ aStream contents
]

{ #category : #converting }
GtClassDefinition >> asMethodsDefinitionString [
	<return: #String>
	| aStream |

	aStream := (String new: 800) writeStream.
	
	methods ifNotNil: [ :theMethods |
		| anIndex |
		anIndex := 0.
		theMethods do: [ :eachMethod |
			anIndex := anIndex + 1.
			
			anIndex > 1
				ifTrue: [ aStream cr; cr ].
			
			aStream
				nextPutAll: self name; cr; tab; nextPutAll: 'compile:'; space;
				print: eachMethod sourceCode;
				cr; tab; nextPutAll: 'classified:'; space;
				print: eachMethod protocol;
				nextPut: $. ] ].

	^ aStream contents
]

{ #category : #accessing }
GtClassDefinition >> category [
	<return: #GtCategoryDefinition>

	^ category
]

{ #category : #accessing }
GtClassDefinition >> classVariables [
	<return: #GtClassVariablesDefinition>

	^ classVariables
]

{ #category : #accessing }
GtClassDefinition >> comment [
	<return: #GtCommentDefinition>
	
	^ comment
]

{ #category : #'api - accepting' }
GtClassDefinition >> createBehaviorChange [
	^ RBAddClassWithSlotsChange definition: self asDefinitionString
]

{ #category : #'api - accepting' }
GtClassDefinition >> createChange [
	| aCompositeChange theMethodsChange |

	aCompositeChange := (RBCompositeRefactoryChange named: 'Define class').
	self category isValidForCreation
		ifTrue: [
			aCompositeChange addChange: self category createPackageChange ].
	
	aCompositeChange addChange: self createBehaviorChange.
	
	theMethodsChange := self methods createChange.
	theMethodsChange changes do: [ :eachMethodChange |
		eachMethodChange
			behaviorName: self name;
			isMeta: false ].
	aCompositeChange addChange: theMethodsChange.

	aCompositeChange addChange: (self comment createChange behaviorName: self name).

	^ aCompositeChange
]

{ #category : #initialization }
GtClassDefinition >> defaultNewClassName [
	^ #NameOfSubclass
]

{ #category : #'api - accepting' }
GtClassDefinition >> difference: aGtCodeDefinitionDifference toRefactoringsOf: aClass [
	^ aGtCodeDefinitionDifference asClassRefactorings: aClass
]

{ #category : #'api - accepting' }
GtClassDefinition >> difference: aGtCodeDefinitionDifference toRefactoringsOf: aClass in: anRBModel [
	^ aGtCodeDefinitionDifference asClassRefactorings: aClass in: anRBModel
]

{ #category : #'api - accepting' }
GtClassDefinition >> differenceWith: aClassDefinition [
	| aDifference |
	
	self
		assert: [ aClassDefinition class = self class ]
		description: [ 'Must be of the same type' ].
	
	aDifference := GtClassDefinitionDifference new.

	self name = aClassDefinition name
		ifFalse: [ aDifference nameFrom: aClassDefinition name to: self name ].

	aDifference add: (self superclass differenceWith: aClassDefinition superclass).
	aDifference add: (self category differenceWith: aClassDefinition category).
	aDifference add: (self slots differenceWith: aClassDefinition slots).
	aDifference add: (self classVariables differenceWith: aClassDefinition classVariables).
	aDifference add: (self traits differenceWith: aClassDefinition traits).
	aDifference add: (self pools differenceWith: aClassDefinition pools).

	^ aDifference
]

{ #category : #testing }
GtClassDefinition >> exists [
	^ Smalltalk globals includesKey: self name asSymbol
]

{ #category : #initialization }
GtClassDefinition >> forNew [
	| anEnvironment |
	name := self defaultNewClassName.
	originalName := name.
	
	anEnvironment := RGEnvironment new.
	anEnvironment backend: (RGReadOnlyImageBackend for: anEnvironment).
	
	layout := Object classLayout asRingMinimalDefinitionIn: anEnvironment.
	
	comment := GtCommentDefinition new parent: self.
	
	superclass := (GtClassSuperclassDefinition named: Object name) parent: self.
	category := GtCategoryDefinition empty parent: self.
	slots := GtSlotsDefinition empty parent: self.
	classVariables := GtClassVariablesDefinition empty parent: self.
	
	traits := GtTraitsDefinition empty parent: self.
	pools := GtPoolsDefinition empty parent: self.
	methods := GtPharoMethodsDefinition new parent: self
]

{ #category : #initialization }
GtClassDefinition >> fromClass: aClass [
	self fromClass: aClass in: self environment
]

{ #category : #initialization }
GtClassDefinition >> fromClass: aClass in: anEnvironment [
	| anEnvironmentForLayout |
	"Initialize me from a given real Class"

	self
		assert: [ anEnvironment notNil ]
		description: [ 'Environment must not be nil' ].

	name := aClass name.
	originalName := aClass name.

	self environment: anEnvironment.
	"register me in the environment if I do not exist"
	self environment registerBehavior: self.

	anEnvironmentForLayout := RGEnvironment new.
	anEnvironmentForLayout backend: (RGReadOnlyImageBackend for: anEnvironmentForLayout).

	layout := aClass classLayout asRingMinimalDefinitionIn: anEnvironmentForLayout.

	comment := (GtCommentDefinition fromBehavior: aClass) parent: self.

	superclass := (GtClassSuperclassDefinition fromClass: aClass) parent: self.
	category := (GtCategoryDefinition fromBehavior: aClass) parent: self.
	slots := (GtSlotsDefinition fromClass: aClass) parent: self.
	classVariables := (GtClassVariablesDefinition fromClass: aClass) parent: self.

	traits := (GtTraitsDefinition fromClass: aClass in: anEnvironment) parent: self.
	pools := (GtPoolsDefinition fromClass: aClass) parent: self.
	methods := GtPharoMethodsDefinition new parent: self
]

{ #category : #testing }
GtClassDefinition >> isValidForCreation [
	self name asSymbol = self defaultNewClassName
		ifTrue: [ ^ false ].
	(Smalltalk includesKey: self name asSymbol)
		ifTrue: [ ^ false ].
	self name isEmpty
		ifTrue: [ ^ false ].
	category package name isEmpty
		ifTrue: [ ^ false ].
	superclass exists
		ifFalse: [ ^ false ].
	traits exists
		ifFalse: [ ^ false ].
	(pools all allSatisfy: [ :each | each exists ])
		ifFalse: [ ^ false ].
	(slots all
		allSatisfy:
			[ :each | each isValidName and: [ (superclass hasSlotNamed: each name) not ] ])
		ifFalse: [ ^ false ].
	^ classVariables all
		allSatisfy: [ :each | 
			each isValidName
				and: [ (superclass hasClassVariableNamed: each name) not ] ]
]

{ #category : #accessing }
GtClassDefinition >> layout [
	^ layout
]

{ #category : #accessing }
GtClassDefinition >> methods [
	^ methods
]

{ #category : #accessing }
GtClassDefinition >> pools [
	<return: #GtPoolsDefinition>
	
	^ pools
]

{ #category : #accessing }
GtClassDefinition >> slots [
	<return: #GtSlotsDefinition>

	^ slots
]

{ #category : #accessing }
GtClassDefinition >> superclass [
	<return: #GtClassSuperclassDefinition>

	^ superclass
]

{ #category : #accessing }
GtClassDefinition >> traits [
	<return: #GtTraitsDefinition>
	
	^ traits
]

{ #category : #initialization }
GtClassDefinition >> withMethodsFromClass: aClass [
	"Initialize methods from a given real Class"
	
	methods := (GtPharoMethodsDefinition fromClass: aClass) parent: self
]
