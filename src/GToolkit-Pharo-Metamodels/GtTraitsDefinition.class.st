Class {
	#name : #GtTraitsDefinition,
	#superclass : #GtCompositeDefinition,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtTraitsDefinition class >> fromClass: aClass [
	^ self new fromClass: aClass
]

{ #category : #'instance creation' }
GtTraitsDefinition class >> fromClass: aClass in: anEnvironment [
	^ self new fromClass: aClass in: anEnvironment
]

{ #category : #'instance creation' }
GtTraitsDefinition class >> fromTrait: aTrait [
	^ self new fromTrait: aTrait
]

{ #category : #'instance creation' }
GtTraitsDefinition class >> fromTrait: aTrait in: anEnvironment [
	^ self new fromTrait: aTrait in: anEnvironment
]

{ #category : #'api - traits' }
GtTraitsDefinition >> addTrait: aTraitDefinition [
	| aTraitName |
	
	aTraitName := aTraitDefinition name.
	
	(self hasDefinitionNamed: aTraitName)
		ifTrue: [ self errorTraitAlreadyAdded: aTraitName ].

	definitions := definitions copyWith: aTraitDefinition.

	self notifyTraitAdded: aTraitDefinition
]

{ #category : #'api - traits' }
GtTraitsDefinition >> addTraitNamed: aSymbolOrString [
	| aTraitName aTrait aTraitDefinition |
	
	aTraitName := aSymbolOrString asSymbol.
	
	(self hasDefinitionNamed: aTraitName)
		ifTrue: [ self errorTraitAlreadyAdded: aTraitName ].

	(self doesTraitExist: aTraitName)
		ifFalse: [ self errorTraitDoesNotExist: aTraitName ].

	aTrait := self environment at: aTraitName.
	aTraitDefinition := (aTrait isKindOf: GtTraitDefinition)
		ifTrue: [ aTrait ]
		ifFalse: [ GtTraitDefinition fromTrait: aTrait ].

	definitions := definitions copyWith: aTraitDefinition.

	self notifyTraitAdded: aTraitDefinition
]

{ #category : #converting }
GtTraitsDefinition >> asDefinitionString [
	self isEmpty
		ifTrue: [ ^ '{}' ].

	^ String streamContents: [ :stream | 
		definitions
			do: [ :each | stream nextPutAll: each name ]
			separatedBy: [ stream nextPutAll: ' + ' ].
		stream space ]
]

{ #category : #'api - accepting' }
GtTraitsDefinition >> differenceWith: aGtTraitsDefinition [
	| theDifference |

	theDifference := GtTraitsDefinitionDifference new.

	GtCodeDefinitionDifference
		difference: self all
		with: aGtTraitsDefinition all
		addedDo: [ :eachTrait | theDifference add: (GtTraitAddedToDefinitionDifference new traitName: eachTrait name) ]
		removedDo: [ :eachTrait | theDifference add: (GtTraitRemovedFromDefinitionDifference new traitName: eachTrait name) ].

	^ theDifference
]

{ #category : #'api - traits' }
GtTraitsDefinition >> doesTraitExist: aTraitName [
	<return: #Boolean>

	^ self environment
		at: aTraitName
		ifPresent: [ :aGlobal | aGlobal isTrait or: [ aGlobal isKindOf: GtTraitDefinition ] ]
		ifAbsent: [ false ]
]

{ #category : #'private - errors' }
GtTraitsDefinition >> errorTraitAlreadyAdded: aSymbol [ 
	"Create an error notification that there is already a trait with a given name"

	GtBehaviorCoderHeaderTraitAlreadyAddedError signalFor: aSymbol
]

{ #category : #'private - errors' }
GtTraitsDefinition >> errorTraitDoesNotExist: aSymbol [ 
	"Create an error notification that a trait with a given name does not exist in the environment"

	GtBehaviorCoderHeaderTraitDoesNotExistError signalFor: aSymbol
]

{ #category : #'private - errors' }
GtTraitsDefinition >> errorTraitNotFound: aSymbol [ 
	"Create an error notification that there is no trait with a given name"

	GtBehaviorCoderHeaderTraitNotFoundError signalFor: aSymbol
]

{ #category : #testing }
GtTraitsDefinition >> exists [
	^ definitions allSatisfy: [ :each | each exists ]
]

{ #category : #initialization }
GtTraitsDefinition >> fromClass: aClass [
	self fromClass: aClass in: self environment
]

{ #category : #initialization }
GtTraitsDefinition >> fromClass: aClass in: anEnvironment [
	definitions := aClass traitComposition traits collect: [ :eachTrait | (GtTraitDefinition fromTrait: eachTrait in: anEnvironment) parent: self ]
]

{ #category : #initialization }
GtTraitsDefinition >> fromTrait: aTrait [
	self fromTrait: aTrait in: self environment
]

{ #category : #initialization }
GtTraitsDefinition >> fromTrait: aTrait in: anEnvironment [
	definitions := aTrait traitComposition traits collect: [ :eachTrait | (GtTraitDefinition fromTrait: eachTrait in: anEnvironment) parent: self ]
]

{ #category : #'api - traits' }
GtTraitsDefinition >> hasTraitNamed: aTraitName [
	^ self hasDefinitionNamed: aTraitName asSymbol
]

{ #category : #'private - notifying' }
GtTraitsDefinition >> notifyTraitAdded: aGtTraitDefinition [
	self dispatchEvent: (GtBehaviorTraitAdded new
		owner: self parent;
		trait: aGtTraitDefinition)
]

{ #category : #'private - notifying' }
GtTraitsDefinition >> notifyTraitRemoved: aGtTraitDefinition [
	self dispatchEvent: (GtBehaviorTraitRemoved new
		owner: self parent;
		trait: aGtTraitDefinition)
]

{ #category : #'private - notifying' }
GtTraitsDefinition >> notifyTraitRenamed: aGtTraitDefinition from: anOldName to: aNewName [
	self dispatchEvent: (GtBehaviorTraitRenamed new
		owner: self parent;
		trait: aGtTraitDefinition;
		oldName: anOldName;
		newName: aNewName)
]

{ #category : #'api - traits' }
GtTraitsDefinition >> removeTraitNamed: aSymbol [
	| aRemovedTrait |
	
	(self hasDefinitionNamed: aSymbol)
		ifFalse: [ self errorTraitNotFound: aSymbol ].
	
	aRemovedTrait := self traitNamed: aSymbol.
	definitions := definitions copyWithout: aRemovedTrait.
	self notifyTraitRemoved: aRemovedTrait
]

{ #category : #'api - traits' }
GtTraitsDefinition >> renameTraitNamed: aCurrentName to: aNewName [
	| aRenamedTrait |
	
	(self hasDefinitionNamed: aCurrentName)
		ifFalse: [ self errorTraitNotFound: aCurrentName ].
		
	(self hasDefinitionNamed: aNewName)
		ifTrue: [ self errorTraitAlreadyAdded: aCurrentName ].

	aRenamedTrait := self traitNamed: aCurrentName.
	aRenamedTrait name: aNewName.
	
	self
		notifyTraitRenamed: aRenamedTrait
		from: aCurrentName
		to: aNewName
]

{ #category : #'api - traits' }
GtTraitsDefinition >> traitNamed: aSymbol [
	<return: #GtTraitDefinition>
	
	^ self
		definitionNamed: aSymbol
		ifNone: [ self errorTraitNotFound: aSymbol ]
]
