Class {
	#name : #GtPharoMethodDefinition,
	#superclass : #GtCodeDefinition,
	#instVars : [
		'sourceCode',
		'protocol',
		'selector'
	],
	#category : #'GToolkit-Pharo-Metamodels-Method - Definitions'
}

{ #category : #'instance creation' }
GtPharoMethodDefinition class >> fromCompiledMethod: aCompiledMethod [
	^ self new fromCompiledMethod: aCompiledMethod
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
	^ self sourceCode
]

{ #category : #'api - accepting' }
GtPharoMethodDefinition >> createChange [
	^ RBAddMethodToClassNamedChange compile: self sourceCode protocol: self protocol
]

{ #category : #initialization }
GtPharoMethodDefinition >> fromCompiledMethod: aCompiledMethod [
	sourceCode := aCompiledMethod sourceCode.
	protocol := aCompiledMethod protocol.
	selector := aCompiledMethod selector
]

{ #category : #accessing }
GtPharoMethodDefinition >> name [
	^ self selector
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
