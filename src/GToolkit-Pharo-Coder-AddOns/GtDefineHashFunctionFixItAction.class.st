Class {
	#name : #GtDefineHashFunctionFixItAction,
	#superclass : #GtMethodAdviceFixItAction,
	#instVars : [
		'methodClass'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #private }
GtDefineHashFunctionFixItAction >> allEqualsArguments [
	| searcher exprs |
	exprs := OrderedCollection new.
	searcher := RBParseTreeSearcher new
			matches: '``@left = ``@right'
			do: [ :msg :obj | 
				exprs add: msg receiver.
				exprs add: msg arguments first ].
	searcher executeTree: self equalsMethod ast.
	^ exprs
]

{ #category : #executing }
GtDefineHashFunctionFixItAction >> basicExecuteOn: anEditorElement [
	methodClass compile: self updateSource classified: 'comparing'.
	anEditorElement styleText
]

{ #category : #private }
GtDefineHashFunctionFixItAction >> combineHashExpressions: hashExpressions [
	| receiver |
	receiver := hashExpressions first.
	hashExpressions
		allButFirstDo: [ :node | 
			receiver := RBMessageNode
					receiver: receiver
					selector: #bitXor:
					arguments: {node} ].
	^ receiver
]

{ #category : #'api - action' }
GtDefineHashFunctionFixItAction >> description [
	^'Define hash function from = function'
]

{ #category : #private }
GtDefineHashFunctionFixItAction >> equalsMethod [
	^ methodClass >> #=
]

{ #category : #accessing }
GtDefineHashFunctionFixItAction >> hashExpressionForProperty: each [
	^ RBMessageNode
		receiver: (RBMessageNode receiver: each selector: #hash)
		selector: #hashMultiply
]

{ #category : #'api - action' }
GtDefineHashFunctionFixItAction >> id [
	^GtDefineHashFunctionFixItActionElementId
]

{ #category : #private }
GtDefineHashFunctionFixItAction >> isSelfProperty: each [
	^ (each isMessage and: [ each receiver isSelfVariable ])
		or: [ each isInstanceVariable ]
]

{ #category : #accessing }
GtDefineHashFunctionFixItAction >> methodClass: aClass [
	methodClass := aClass
]

{ #category : #private }
GtDefineHashFunctionFixItAction >> methodSourceForHashValue: return [
	^ (RBMethodNode selector: #hash body: (RBSequenceNode statements: {return})) formattedCode
]

{ #category : #executing }
GtDefineHashFunctionFixItAction >> updateSource [
	| properties hashExpressions receiver return exprs |
	exprs := self allEqualsArguments.
	properties := exprs select: [ :each | self isSelfProperty: each ].
	hashExpressions := properties
			collect: [ :each | self hashExpressionForProperty: each ].
	receiver := self combineHashExpressions: hashExpressions.
	return := RBReturnNode value: receiver.
	^self methodSourceForHashValue: return.
	
]
