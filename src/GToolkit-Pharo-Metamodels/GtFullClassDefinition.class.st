Class {
	#name : #GtFullClassDefinition,
	#superclass : #GtBehaviorDefinition,
	#instVars : [
		'classSideDefinition',
		'instanceSideDefinition'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #'instance creation' }
GtFullClassDefinition class >> forNew [
	^ self new forNew
]

{ #category : #'instance creation' }
GtFullClassDefinition class >> fromClass: aClass [
	^ self new fromClass: aClass
]

{ #category : #'instance creation' }
GtFullClassDefinition class >> fromClass: aClass in: anEnvironment [
	^ self new fromClass: aClass in: anEnvironment
]

{ #category : #'instance creation' }
GtFullClassDefinition class >> fromHeaderDictionary: aDictionary [
	| definition className superclassName package tag comment classVariables instanceSlotNames classSlotNames poolNames traitNames |

	className := aDictionary at: 'name'.
	superclassName := aDictionary at: 'superclassName'.
	package := aDictionary at: 'package'.
	tag := aDictionary at: 'tag' ifAbsent: [ '' ].
	comment := aDictionary at: 'comment' ifAbsent: [ '' ].
	instanceSlotNames := aDictionary at: 'instanceSlots' ifAbsent: [ #() ].
	classVariables := aDictionary at: 'classVariables' ifAbsent: [ #() ].
	poolNames := aDictionary at: 'pools' ifAbsent: [ #() ].
	traitNames := aDictionary at: 'traits' ifAbsent: [ #() ].
	classSlotNames := aDictionary at: 'classSlots' ifAbsent: [ #() ].

	definition := self forNew.
	definition name: className.
	definition instanceSideDefinition superclass name: superclassName.

	definition instanceSideDefinition category package name: package.
	definition instanceSideDefinition category tag name: tag.

	instanceSlotNames do: [ :eachName | definition instanceSideDefinition slots addSlotNamed: eachName ].
	classVariables do: [ :eachName | definition instanceSideDefinition classVariables addClassVariableNamed: eachName ].
	poolNames do: [ :eachName | definition instanceSideDefinition pools addPoolNamed: eachName ].
	traitNames do: [ :eachName | definition instanceSideDefinition traits addTraitNamed: eachName ].
	classSlotNames do: [ :eachName | definition classSideDefinition slots addSlotNamed: eachName ].
	
	definition comment content: comment.
	
	^ definition
]

{ #category : #converting }
GtFullClassDefinition >> asDefinitionString [
	^ self instanceSideDefinition asDefinitionString, '.', String cr, String cr, self classSideDefinition asDefinitionString
]

{ #category : #accessing }
GtFullClassDefinition >> classSideDefinition [
	^ classSideDefinition
]

{ #category : #'private - accessing' }
GtFullClassDefinition >> classSideDefinition: aGtMetaclassDefinition [
	classSideDefinition := aGtMetaclassDefinition parent: self
]

{ #category : #accessing }
GtFullClassDefinition >> comment [
	<return: #GtCommentDefinition>
	
	^ self instanceSideDefinition comment
]

{ #category : #'api - accepting' }
GtFullClassDefinition >> createChange [
	| aCompositeChange |

	aCompositeChange := (RBCompositeRefactoryChange named: 'Define full class').	
	aCompositeChange addChange: self instanceSideDefinition createChange.
	aCompositeChange addChange: self classSideDefinition createChange.
	^ aCompositeChange
]

{ #category : #'api - accepting' }
GtFullClassDefinition >> differenceWith: aGtCodeDefinition [
	^ GtFullClassDefinitionDifference new
		instanceSideDifference:
			(instanceSideDefinition
				differenceWith: aGtCodeDefinition instanceSideDefinition);
		classSideDifference:
			(classSideDefinition
				differenceWith: aGtCodeDefinition classSideDefinition);
		yourself
]

{ #category : #initialization }
GtFullClassDefinition >> forNew [
	name := self defaultNewClassName.
	originalName := name.
	
	instanceSideDefinition := GtClassDefinition forNew parent: self.
	classSideDefinition := GtMetaclassDefinition forNew parent: self
]

{ #category : #initialization }
GtFullClassDefinition >> fromClass: aClass [
	self fromClass: aClass in: self environment
]

{ #category : #initialization }
GtFullClassDefinition >> fromClass: aClass in: anEnvironment [
	self
		assert: [ anEnvironment notNil ]
		description: [ 'Environment must not be nil' ].
	
	self environment: anEnvironment.

	name := aClass name.
	originalName := aClass name.
	
	instanceSideDefinition := (GtClassDefinition fromClass: aClass instanceSide in: anEnvironment) parent: self.
	classSideDefinition := (GtMetaclassDefinition fromMetaclass: aClass classSide in: anEnvironment) parent: self.
	
	"we should replace class with full class definition"
	self environment at: self name put: self.
]

{ #category : #accessing }
GtFullClassDefinition >> instanceSideDefinition [
	^ instanceSideDefinition
]

{ #category : #'private - accessing' }
GtFullClassDefinition >> instanceSideDefinition: aGtClassDefinition [
	instanceSideDefinition := aGtClassDefinition parent: self
]

{ #category : #accessing }
GtFullClassDefinition >> name: aSymbol [
	super name: aSymbol.
	
	self instanceSideDefinition name: aSymbol.
	self classSideDefinition name: aSymbol
]

{ #category : #accessing }
GtFullClassDefinition >> postCopy [
	<generatedFrom: #'GtPharoMethodTemplates>>#postCopyTemplate'>
	super postCopy.
	
	classSideDefinition := classSideDefinition copy parent: self.
	instanceSideDefinition := instanceSideDefinition copy parent: self.
	name := name copy.
	originalName := originalName copy.
]

{ #category : #accessing }
GtFullClassDefinition >> storeHeaderAsDictionary [
	| aDictionary |

	aDictionary := OrderedDictionary new.

	aDictionary at: 'name' put: self name.
	aDictionary at: 'superclassName' put: self instanceSideDefinition superclass name.
	aDictionary at: 'package' put: self instanceSideDefinition category package name.
	
	self instanceSideDefinition category tag name
		ifNotEmpty: [ :aTagName | aDictionary at: 'tag' put: aTagName ].
		
	(self instanceSideDefinition slots collect: [ :eachSlot | eachSlot name ])
		ifNotEmpty: [ :theSlots | aDictionary at: 'instanceSlots' put: theSlots asArray ].
		
	(self instanceSideDefinition classVariables collect: [ :eachVar | eachVar name ])
		ifNotEmpty: [ :theClassVariables | aDictionary at: 'classVariables' put: theClassVariables asArray ].
		
	(self instanceSideDefinition pools collect: [ :eachPool | eachPool name ])
		ifNotEmpty: [ :thePools | aDictionary at: 'pools' put: thePools asArray ].
		
	(self instanceSideDefinition traits collect: [ :eachTrait | eachTrait name ])
		ifNotEmpty: [ :theTraits | aDictionary at: 'traits' put: theTraits asArray ].
		
	(self classSideDefinition slots collect: [ :eachSlot | eachSlot name ])
		ifNotEmpty: [ :theSlots | aDictionary at: 'classSlots' put: theSlots asArray ].
	
	self comment content
		ifNotEmpty: [ :aComment | aDictionary at: 'comment' put: aComment ].

	^ aDictionary
]

{ #category : #accessing }
GtFullClassDefinition >> storeOn: aStream [
	<generatedFrom: #'GtPharoMethodTemplates>>#storeOnTemplate'>
	aStream
		nextPut: $(;
		nextPutAll: self class name;
		space;
		nextPutAll: 'new'.
	aStream
		space;
		nextPutAll: 'classSideDefinition:';
		space;
		store: self classSideDefinition;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'instanceSideDefinition:';
		space;
		store: self instanceSideDefinition;
		nextPut: $;.
	aStream
		space;
		nextPutAll: 'name:';
		space;
		store: self name.
	aStream
		nextPut: $)
]

{ #category : #initialization }
GtFullClassDefinition >> withMethodsFromClass: aClass [
	self instanceSideDefinition withMethodsFromClass: aClass
]
