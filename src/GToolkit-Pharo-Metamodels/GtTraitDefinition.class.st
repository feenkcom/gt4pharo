Class {
	#name : #GtTraitDefinition,
	#superclass : #GtBehaviorDefinition,
	#instVars : [
		'comment',
		'slots',
		'traits',
		'category',
		'methods'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtTraitDefinition class >> forNew [
	^ self new forNew
]

{ #category : #'instance creation' }
GtTraitDefinition class >> fromTrait: aTrait [
	^ self new fromTrait: aTrait
]

{ #category : #'instance creation' }
GtTraitDefinition class >> fromTrait: aTrait in: anEnvironment [
	^ self new fromTrait: aTrait in: anEnvironment
]

{ #category : #converting }
GtTraitDefinition >> asDefinitionString [
	<return: #String>
	| aStream |
	aStream := (String new: 800) writeStream.
	aStream
		nextPutAll: 'Trait named: ';
		store: self name.

	"Traits"
	aStream
		cr;
		tab;
		nextPutAll: 'uses: ';
		nextPutAll: self traits asDefinitionString.

	"Slots"
	aStream
		cr;
		tab;
		nextPutAll: 'slots: ';
		nextPutAll: self slots asDefinitionString.
	aStream
		cr;
		tab;
		nextPutAll: 'package: ';
		store: self category asDefinitionString.
	^ aStream contents
]

{ #category : #accessing }
GtTraitDefinition >> category [
	<return: #GtCategoryDefinition>

	^ category
]

{ #category : #accessing }
GtTraitDefinition >> comment [
	<return: #GtCommentDefinition>
	
	^ comment
]

{ #category : #'api - accepting' }
GtTraitDefinition >> createBehaviorChange [
	^ RBAddTraitChange definition: self asDefinitionString
]

{ #category : #'api - accepting' }
GtTraitDefinition >> createChange [
	| aCompositeChange theMethodsChange |

	aCompositeChange := (RBCompositeRefactoryChange named: 'Define trait').
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
GtTraitDefinition >> defaultNewTraitName [
	^ #TNameOfTrait
]

{ #category : #'api - accepting' }
GtTraitDefinition >> difference: aGtCodeDefinitionDifference toRefactoringsOf: aClass [
	^ aGtCodeDefinitionDifference asClassRefactorings: aClass
]

{ #category : #'api - accepting' }
GtTraitDefinition >> difference: aGtCodeDefinitionDifference toRefactoringsOf: aClass in: anRBModel [
	^ aGtCodeDefinitionDifference asClassRefactorings: aClass in: anRBModel
]

{ #category : #'api - accepting' }
GtTraitDefinition >> differenceWith: aTraitDefinition [
	| aDifference |
	
	self
		assert: [ aTraitDefinition class = self class ]
		description: [ 'Must be of the same type' ].
	
	aDifference := GtTraitDefinitionDifference new.

	self name = aTraitDefinition name
		ifFalse: [ aDifference nameFrom: aTraitDefinition name to: self name ].

	aDifference add: (self category differenceWith: aTraitDefinition category).
	aDifference add: (self slots differenceWith: aTraitDefinition slots).
	aDifference add: (self traits differenceWith: aTraitDefinition traits).

	^ aDifference
]

{ #category : #testing }
GtTraitDefinition >> exists [
	^ self class environment includesKey: self name asSymbol
]

{ #category : #initialization }
GtTraitDefinition >> forNew [
	name := self defaultNewTraitName.
	originalName := name.
	comment := GtCommentDefinition new parent: self.
	category := GtCategoryDefinition empty parent: self.
	slots := GtSlotsDefinition empty parent: self.
	traits := GtTraitsDefinition empty parent: self
]

{ #category : #initialization }
GtTraitDefinition >> fromTrait: aTrait [
	self fromTrait: aTrait in: self environment
]

{ #category : #initialization }
GtTraitDefinition >> fromTrait: aTrait in: anEnvironment [
	self
		assert: [ (aTrait isKindOf: self class) not ]
		description: [ 'Can not create definition from a definition' ].
	
	name := aTrait name.
	originalName := name.
	
	self environment: anEnvironment.
	"register me in the environment if I do not exist"
	self environment registerBehavior: self.	
	
	category := (GtCategoryDefinition fromBehavior: aTrait) parent: self.
	comment := (GtCommentDefinition fromBehavior: aTrait) parent: self.
	slots := (GtSlotsDefinition fromTrait: aTrait) parent: self.
	traits := (GtTraitsDefinition fromTrait: aTrait in: anEnvironment) parent: self.
	methods := GtPharoMethodsDefinition new parent: self
]

{ #category : #testing }
GtTraitDefinition >> hasSlotNamed: aString [
	(slots all anySatisfy: [ :each | each name = aString asSymbol ])
		ifTrue: [ ^ true ].
	^ traits all anySatisfy: [ :each | each hasSlotNamed: aString ]
]

{ #category : #testing }
GtTraitDefinition >> isValidForCreation [
	self name asSymbol = self defaultNewTraitName
		ifTrue: [ ^ false ].
	(Smalltalk includesKey: self name asSymbol)
		ifTrue: [ ^ false ].
	traits exists
		ifFalse: [ ^ false ].
	^ slots all
		allSatisfy: [ :each | 
			each isValidName
				and: [ traits all noneSatisfy: [ :trait | trait hasSlotNamed: each name ] ] ]
]

{ #category : #accessing }
GtTraitDefinition >> methods [
	^ methods
]

{ #category : #accessing }
GtTraitDefinition >> slots [
	<return: #GtSlotsDefinition>

	^ slots
]

{ #category : #accessing }
GtTraitDefinition >> traits [
	<return: #GtTraitsDefinition>
	
	^ traits
]

{ #category : #initialization }
GtTraitDefinition >> withMethodsFromTrait: aTrait [
	"Initialize methods from a given real Trait"
	
	methods := (GtPharoMethodsDefinition fromTrait: aTrait) parent: self
]
