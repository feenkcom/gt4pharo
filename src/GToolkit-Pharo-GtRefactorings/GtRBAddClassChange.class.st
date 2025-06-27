Class {
	#name : #GtRBAddClassChange,
	#superclass : #RBAddClassChange,
	#instVars : [
		'definitionString',
		'properties'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #private }
GtRBAddClassChange class >> definitionPatterns [
	^ #('`@superclass subclass: `#className uses: `@traitExpression slots: `@slotsExpression classVariables: `@classVariableSlots poolDictionaries: `#poolDictionaries package: `#category'
	'`@superclass subclass: `#className slots: `@slotsExpression classVariables: `@classVariableSlots poolDictionaries: `#poolDictionaries package: `#category'
	'`@superclass subclass: `#className uses: `@traitExpression slots: `@slotsExpression classVariables: `@classVariableSlots package: `#category'
	'`@superclass subclass: `#className slots: `@slotsExpression classVariables: `@classVariableSlots package: `#category')
		flatCollect: [ :each | 
			Array
				with: each
				with:
					(each copyReplaceAll: '`@superclass' with: 'ProtoObject')
						, '. `className superclass: `@superclass' ]
]

{ #category : #'instance creation' }
GtRBAddClassChange class >> definitionString: aString [
	^ self
		forPharo12: [ self new
				definitionString: aString;
				fillOutDefinition;
				yourself ]
		forPharo11AndPharo10: [ super definitionString: aString ]
]

{ #category : #accessing }
GtRBAddClassChange >> category [
	^ properties
		at: #category
		ifPresent: [ :cat | 
			properties
				at: #packageTagName
				ifPresent: [ :t | cat , '-' , t ]
				ifAbsent: [ cat ] ]
		ifAbsent: [ (self packageTagName
				ifNil: [ self packageName ]
				ifNotNil: [ :tag | self packageName , '-' , tag ])
				ifNil: [ self forPharo12: [  ] forPharo11AndPharo10: [ super category ] ] ]
]

{ #category : #accessing }
GtRBAddClassChange >> classInstanceVariableNames [
	"Pharo 12"

	^ properties
		at: #classInstanceVariableNames
		ifAbsent: [ self
				forPharo12: [ super classInstanceVariableNames ]
				forPharo11AndPharo10: [ #() ] ]
]

{ #category : #accessing }
GtRBAddClassChange >> classVariableNames [
	^ (properties
		at: #classVariableNames
		ifAbsent: [ self forPharo12: [  ] forPharo11AndPharo10: [ super classVariableNames ] ])
		ifNil: [ #() ]
]

{ #category : #accessing }
GtRBAddClassChange >> comment [
	"Pharo 12"

	^ properties at: #comment ifAbsent: [  ]
]

{ #category : #accessing }
GtRBAddClassChange >> definition [
	^ definitionString ifNil: [ super definition ]
]

{ #category : #accessing }
GtRBAddClassChange >> definitionString [
	^ definitionString
]

{ #category : #accessing }
GtRBAddClassChange >> definitionString: anObject [
	definitionString := anObject
]

{ #category : #private }
GtRBAddClassChange >> fillOutDefinition [
	"Pharo 12"

	| ast ignore |
	ast := RBParser parseExpression: definitionString.
	ignore := IdentitySet new.
	ast
		nodesDo: [ :each | 
			each isDynamicArray ifTrue: [ ignore addAll: each allChildren ].
			(each isMessage and: [ (ignore includes: each) not ])
				ifTrue: [ self updateDefinitionFromMessage: each ] ]
]

{ #category : #actions }
GtRBAddClassChange >> generateChanges [
	"Pharo 12"

	^ definitionString
		ifNotNil: [ (self class compiler
				source: definitionString;
				logged: true;
				evaluate) fluidInstall ]
		ifNil: [ super generateChanges ]
]

{ #category : #comparing }
GtRBAddClassChange >> hash [
	^ definitionString ifNil: [ super hash ] ifNotNil: [ definitionString hash ]
]

{ #category : #initialization }
GtRBAddClassChange >> initialize [
	super initialize.
	properties := Dictionary new
]

{ #category : #accessing }
GtRBAddClassChange >> instanceVariableNames [
	^ properties
		at: #instanceVariableNames
		ifAbsent: [ self forPharo12: [ #() ] forPharo11AndPharo10: [ super instanceVariableNames ] ]
]

{ #category : #private }
GtRBAddClassChange >> namesInArray: arg [
	^ arg statements
		collect: [ :each | 
			| node |
			node := each.
			[ node isMessage ] whileTrue: [ node := node receiver ].
			node isVariable ifTrue: [ node name ] ifFalse: [ node value asString ] ]
]

{ #category : #private }
GtRBAddClassChange >> namesInString: aString [
	| names scanner token |
	names := OrderedCollection new.
	scanner := RBScanner on: (ReadStream on: aString).
	[ scanner atEnd ]
		whileFalse: [ token := scanner next.
			token isIdentifier ifTrue: [ names add: token value ] ].
	^ names asArray
]

{ #category : #accessing }
GtRBAddClassChange >> package [
	"Pharo 12"

	^ self packageName
		ifNil: [ super package ]
		ifNotNil: [ :packageName | RPackageOrganizer default packageNamed: packageName ]
]

{ #category : #accessing }
GtRBAddClassChange >> packageName [
	^ (properties at: #category ifPresent: [ :cat | self packageNameFor: cat ])
		ifNotNil: [ :packageName | packageName asSymbol ]
]

{ #category : #convenience }
GtRBAddClassChange >> packageNameFor: aString [
	| index |
	(RPackageOrganizer default includesPackageNamed: aString) ifTrue: [ ^ aString ].
	index := aString lastIndexOf: $-.
	index <= 1 ifTrue: [ ^ nil ].
	^ self packageNameFor: (aString first: index - 1)
]

{ #category : #accessing }
GtRBAddClassChange >> packageTagName [
	^ properties
		at: #packageTagName
		ifAbsent: [ properties
				at: #category
				ifPresent: [ :cat | 
					(self packageNameFor: cat)
						ifNotNil: [ :packageName | packageName size = cat size ifFalse: [ cat allButFirst: packageName size + 1 ] ] ] ]
]

{ #category : #printing }
GtRBAddClassChange >> printOn: aStream [
	definitionString
		ifNotNil: [ aStream nextPutAll: definitionString ]
		ifNil: [ super printOn: aStream ]
]

{ #category : #accessing }
GtRBAddClassChange >> sharedPoolNames [
	^ (properties
		at: #sharedPoolNames
		ifAbsent: [ self forPharo12: [  ] forPharo11AndPharo10: [ super sharedPoolNames ] ])
		ifNil: [ #() ]
]

{ #category : #accessing }
GtRBAddClassChange >> superclassName [
	^ properties
		at: #superclassName
		ifAbsent: [ self forPharo12: [  ] forPharo11AndPharo10: [ super superclassName ] ]
]

{ #category : #accessing }
GtRBAddClassChange >> tag [
	"Pharo 12"

	^ self package
		ifNil: [  ]
		ifNotNil: [ :package | self packageTagName ifNotNil: [ :tag | package tagNamed: tag ifAbsent: [  ] ] ]
]

{ #category : #private }
GtRBAddClassChange >> updateDefinitionFromMessage: aMessageSend [
	| keywords args |
	keywords := aMessageSend keywords.
	args := aMessageSend arguments.
	(keywords first = 'subclass:'
		or: [ keywords first = '<<' or: [ keywords first endsWith: 'Subclass:' ] ])
		ifTrue: [ properties at: #superclassName put: aMessageSend receiver name.
			className := args first value.
			isMeta := false ].
	keywords
		with: args
		do: [ :key :arg | 
			key = 'instanceVariableNames:'
				ifTrue: [ properties at: #instanceVariableNames put: (self namesInString: arg value) ].
			key = 'slots:'
				ifTrue: [ properties at: #instanceVariableNames put: (self namesInArray: arg) ].
			key = 'classVariableNames:'
				ifTrue: [ properties at: #classVariableNames put: (self namesInString: arg value) ].
			key = 'sharedVariables:'
				ifTrue: [ properties at: #classVariableNames put: (self namesInArray: arg) ].
			key = 'poolDictionaries:'
				ifTrue: [ properties at: #sharedPoolNames put: (self namesInString: arg value) ].
			key = 'sharedPools:'
				ifTrue: [ properties at: #sharedPoolNames put: (self namesInArray: arg) ].
			key = 'classSlots:'
				ifTrue: [ properties at: #classInstanceVariableNames put: (self namesInArray: arg) ].
			key = 'category:' ifTrue: [ properties at: #category put: arg value ].
			key = 'package:' ifTrue: [ properties at: #category put: arg value ].
			key = 'tag:' ifTrue: [ properties at: #packageTagName put: arg value ].
			key = 'comment:' ifTrue: [ properties at: #comment put: arg value ] ]
]
