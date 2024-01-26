Class {
	#name : #GtPharoVariableNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitVariable: self
]

{ #category : #converting }
GtPharoVariableNode >> asString [
	^ name source
]

{ #category : #converting }
GtPharoVariableNode >> asSymbol [
	^ self asString asSymbol
]

{ #category : #accessing }
GtPharoVariableNode >> findVariableNodeAt: anInteger [
	^ (anInteger between: self startPosition and: self stopPosition)
		ifTrue: [ self ]
]

{ #category : #accessing }
GtPharoVariableNode >> guessType: completionStrategy [
	^ (completionStrategy typeOfVariable: name value) ifNil: [ super guessType: completionStrategy ]
]

{ #category : #testing }
GtPharoVariableNode >> isAssignedTo [
	^ parent notNil and: [ parent isAssignment and: [ parent variable == self ] ]
]

{ #category : #testing }
GtPharoVariableNode >> isDeclaration [
	^ parent notNil
		and: [ self whoDefines
				ifNil: [ false ]
				ifNotNil: [ :node | node variables identityIncludes: self ] ]
]

{ #category : #testing }
GtPharoVariableNode >> isLocallyDefined [
	^ self allParents anySatisfy: [ :each | each defines: name value ]
]

{ #category : #testing }
GtPharoVariableNode >> isSpecialVariable [
	^ false
]

{ #category : #testing }
GtPharoVariableNode >> isStatementListPattern [
	^ self isStatementPattern and: [ self name source includes: $@ ]
]

{ #category : #testing }
GtPharoVariableNode >> isStatementPattern [
	^ self name source first = $` and: [ self name source includes: $. ]
]

{ #category : #testing }
GtPharoVariableNode >> isThisContext [
	^ false
]

{ #category : #testing }
GtPharoVariableNode >> isUndeclared [
	self isSelf ifTrue: [ ^ false ].
	self isSuper ifTrue: [ ^ false ].
	self isThisContext ifTrue: [ ^ false ].
	^ self whoDefines isNil
]

{ #category : #testing }
GtPharoVariableNode >> isVariable [
	^ true
]

{ #category : #generated }
GtPharoVariableNode >> name [
	^ name
]

{ #category : #generated }
GtPharoVariableNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtPharoVariableNode >> priority [
	^ 0
]

{ #category : #converting }
GtPharoVariableNode >> selector [
	^ self asSymbol
]

{ #category : #generated }
GtPharoVariableNode >> tokenVariables [
	^ #(#name)
]

{ #category : #accessing }
GtPharoVariableNode >> variableName [
	"Return the variable name as a symbol"
	<return: #Symbol>

	^ self name value asSymbol
]

{ #category : #accessing }
GtPharoVariableNode >> whoDefines [
	^ self allParents
		detect: [ :each | each isErrorNode not and: [ each defines: name value ] ]
		ifNone: [  ]
]
