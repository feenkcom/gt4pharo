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

{ #category : #'instace creation' }
GtClassDefinition class >> forNewBaseline [

	^ self new forNewBaseline
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

{ #category : #initialization }
GtClassDefinition >> baselineMethodSourceCode [

	^ self baselineMethodSourceCodeTemplate format: #( 'PackageOne' )
]

{ #category : #initialization }
GtClassDefinition >> baselineMethodSourceCodeTemplate [

	^ 'baseline: spec
	
	<baseline>
	"spec for: #''common'' do: [
	
		spec baseline: ''ExternalProject'' with: [
			spec repository: ''github://<organization>/<repository>:main/src'' ].
			
		spec package: ''{1}''.
		spec package: ''PackageTwo'' with: [ 
			spec requires: #( ''ExternalProject'' ''{1}'' ) ]
	]"'

]

{ #category : #accessing }
GtClassDefinition >> category [
	<return: #GtCategoryDefinition>

	^ category
]

{ #category : #'private - accessing' }
GtClassDefinition >> category: aGtCategoryDefinition [
	category := aGtCategoryDefinition parent: self
]

{ #category : #accessing }
GtClassDefinition >> classVariables [
	<return: #GtClassVariablesDefinition>

	^ classVariables
]

{ #category : #'private - accessing' }
GtClassDefinition >> classVariables: aGtClassVariablesDefinition [
	classVariables := aGtClassVariablesDefinition parent: self
]

{ #category : #accessing }
GtClassDefinition >> comment [
	<return: #GtCommentDefinition>
	
	^ comment
]

{ #category : #'private - accessing' }
GtClassDefinition >> comment: aGtCommentDefinition [
	comment := aGtCommentDefinition parent: self
]

{ #category : #'api - accepting' }
GtClassDefinition >> createBehaviorChange [
	^ GtRBAddClassChange definitionString: self asDefinitionString
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
	aDifference add: (self methods differenceWith: aClassDefinition methods).

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
GtClassDefinition >> forNewBaseline [
	| anEnvironment |
	name := self defaultNewClassName.
	originalName := name.
	
	anEnvironment := RGEnvironment new.
	anEnvironment backend: (RGReadOnlyImageBackend for: anEnvironment).
	
	layout := BaselineOf classLayout asRingMinimalDefinitionIn: anEnvironment.
	
	comment := GtCommentDefinition new parent: self.
	
	superclass := (GtClassSuperclassDefinition named: BaselineOf name) parent: self.
	category := GtCategoryDefinition empty parent: self.
	slots := GtSlotsDefinition empty parent: self.
	classVariables := GtClassVariablesDefinition empty parent: self.
	
	traits := GtTraitsDefinition empty parent: self.
	pools := GtPoolsDefinition empty parent: self.
	methods := GtPharoMethodsDefinition new parent: self.
	
	methods addMethod: self baselineMethodSourceCode protocol: 'baseline'.
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

{ #category : #'private - accessing' }
GtClassDefinition >> layout: aLayout [
	layout := aLayout
]

{ #category : #accessing }
GtClassDefinition >> methods [
	^ methods
]

{ #category : #'private - accessing' }
GtClassDefinition >> methods: aGtMethodsDefinition [
	methods := aGtMethodsDefinition parent: self
]

{ #category : #accessing }
GtClassDefinition >> pools [
	<return: #GtPoolsDefinition>
	
	^ pools
]

{ #category : #'private - accessing' }
GtClassDefinition >> pools: aGtPoolsDefinition [
	pools := aGtPoolsDefinition parent: self
]

{ #category : #accessing }
GtClassDefinition >> postCopy [
	<generatedFrom: #'GtPharoMethodTemplates>>#postCopyTemplate'>
	super postCopy.
	
	category := category copy parent: self.
	classVariables := classVariables copy parent: self.
	comment := comment copy parent: self.
	layout := layout copy.
	methods := methods copy parent: self.
	name := name copy.
	originalName := originalName copy.
	pools := pools copy parent: self.
	slots := slots copy parent: self.
	superclass := superclass copy parent: self.
	traits := traits copy parent: self.
]

{ #category : #accessing }
GtClassDefinition >> slots [
	<return: #GtSlotsDefinition>

	^ slots
]

{ #category : #'private - accessing' }
GtClassDefinition >> slots: aGtSlotsDefinition [
	slots := aGtSlotsDefinition parent: self
]

{ #category : #accessing }
GtClassDefinition >> storeOn: aStream [
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
		nextPutAll: 'classVariables:';
		space;
		store: self classVariables;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'comment:';
		space;
		store: self comment;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'layout:';
		space;
		store: self layout;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'methods:';
		space;
		store: self methods;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'name:';
		space;
		store: self name;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'pools:';
		space;
		store: self pools;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'slots:';
		space;
		store: self slots;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'superclass:';
		space;
		store: self superclass;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'traits:';
		space;
		store: self traits.
	aStream
		nextPut: $)
]

{ #category : #accessing }
GtClassDefinition >> superclass [
	<return: #GtClassSuperclassDefinition>

	^ superclass
]

{ #category : #'private - accessing' }
GtClassDefinition >> superclass: aGtBehaviorDefinition [
	superclass := aGtBehaviorDefinition parent: self
]

{ #category : #accessing }
GtClassDefinition >> traits [
	<return: #GtTraitsDefinition>
	
	^ traits
]

{ #category : #'private - accessing' }
GtClassDefinition >> traits: aGtTraitsDefinition [
	traits := aGtTraitsDefinition parent: self
]

{ #category : #initialization }
GtClassDefinition >> withMethodsFromClass: aClass [
	"Initialize methods from a given real Class"
	
	methods := (GtPharoMethodsDefinition fromClass: aClass) parent: self.
	traits do: [ :eachTraitDefinition |
		aClass environment
			at: eachTraitDefinition name
			ifPresent: [ :aTrait | eachTraitDefinition withMethodsFromTrait: aTrait ] ]
]
