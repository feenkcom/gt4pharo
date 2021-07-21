Class {
	#name : #GtPharoMethodDefinition,
	#superclass : #GtCodeDefinition,
	#instVars : [
		'sourceCode',
		'protocol',
		'selector',
		'methodParts'
	],
	#category : #'GToolkit-Pharo-Metamodels-Method - Definitions'
}

{ #category : #'instance creation' }
GtPharoMethodDefinition class >> fromCompiledMethod: aCompiledMethod [
	^ self new fromCompiledMethod: aCompiledMethod
]

{ #category : #adding }
GtPharoMethodDefinition >> addMethodPart: aGtPharoMethodPartDefinition [
	self
		methodPartWithId: aGtPharoMethodPartDefinition id
		ifFound: [ :anExistingMethodPart | anExistingMethodPart sourceCode: aGtPharoMethodPartDefinition sourceCode ]
		ifNone: [ methodParts add: aGtPharoMethodPartDefinition ]
]

{ #category : #adding }
GtPharoMethodDefinition >> addMethodPartSource: aSourceCode id: anObjectId [
	self addMethodPart: (GtPharoMethodPartDefinition new sourceCode: aSourceCode; id: anObjectId)
]

{ #category : #accessing }
GtPharoMethodDefinition >> arguments [
	^ (GtPharoParser
		parse: self sourceCode
		startingAt: GtPharoParser startingStateForMethod)
			variables collect: [ :eachVariableNode | eachVariableNode variableName ]
]

{ #category : #converting }
GtPharoMethodDefinition >> asDefinitionString [
	^ self fullSourceCode
]

{ #category : #'api - accepting' }
GtPharoMethodDefinition >> createChange [
	^ GtRBAddMethodToClassNamedChange compile: self fullSourceCode protocol: self protocol
]

{ #category : #initialization }
GtPharoMethodDefinition >> fromCompiledMethod: aCompiledMethod [
	sourceCode := aCompiledMethod sourceCode.
	protocol := aCompiledMethod protocol.
	selector := aCompiledMethod selector
]

{ #category : #accessing }
GtPharoMethodDefinition >> fullSourceCode [
	^ String streamContents: [ :aStream |
		aStream nextPutAll: self sourceCode.
		self methodParts do: [ :eachMethodPart |
			aStream cr; tab.
			aStream nextPutAll: eachMethodPart sourceCode ] ]
]

{ #category : #testing }
GtPharoMethodDefinition >> hasPragmaNamed: aSelector [
	^ self pragmas anySatisfy: [ :eachPragma | eachPragma selector = aSelector ]
]

{ #category : #initialization }
GtPharoMethodDefinition >> initialize [
	super initialize.
	
	methodParts := OrderedCollection new
]

{ #category : #accessing }
GtPharoMethodDefinition >> methodPartWithId: anObjectId ifFound: aFoundBlock ifNone: noneBlock [
	^ self methodParts
		detect: [ :eachMethodPart | eachMethodPart id = anObjectId ]
		ifFound: aFoundBlock
		ifNone: noneBlock
]

{ #category : #accessing }
GtPharoMethodDefinition >> methodParts [
	^ methodParts
]

{ #category : #accessing }
GtPharoMethodDefinition >> name [
	^ self selector
]

{ #category : #accessing }
GtPharoMethodDefinition >> pragmaNamed: aSelector [
	<return: #Pragma of: nil>

	^ self pragmas
		detect: [ :eachPragma | eachPragma selector = aSelector ]
		ifNone: [ nil ]
]

{ #category : #accessing }
GtPharoMethodDefinition >> pragmas [
	<return: #Collection of: #Pragma>

	^ (GtPharoParser
		parse: self fullSourceCode
		startingAt: GtPharoParser startingStateForMethod) pragmas
			collect: [ :eachPragmaNode |
				Pragma new
					method: self;
					arguments: (eachPragmaNode values collect: [ :eachValue | eachValue literalValue ]);
					selector: eachPragmaNode selector ]
]

{ #category : #printing }
GtPharoMethodDefinition >> printOn: aStream [
	aStream print: self selector
]

{ #category : #accessing }
GtPharoMethodDefinition >> protocol [
	^ protocol
]

{ #category : #accessing }
GtPharoMethodDefinition >> protocol: anObject [
	protocol := anObject
]

{ #category : #accessing }
GtPharoMethodDefinition >> selector [
	^ selector
]

{ #category : #accessing }
GtPharoMethodDefinition >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
GtPharoMethodDefinition >> sourceCode: aString [
	sourceCode := aString.
	selector := RBParser parseMethodPattern: sourceCode
]
