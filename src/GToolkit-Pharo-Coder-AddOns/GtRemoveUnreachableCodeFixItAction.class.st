Class {
	#name : #GtRemoveUnreachableCodeFixItAction,
	#superclass : #GtMethodAdviceFixItAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #examples }
GtRemoveUnreachableCodeFixItAction class >> removeStatementsInBlock [
	<gtExample>
	^ self
		testOriginal: 'a self something ifTrue: [self somethingElse ifTrue: [^1] ifFalse: [^2]. ^3]. ^4'
		generates: 'a self something ifTrue: [self somethingElse ifTrue: [^1] ifFalse: [^2]]. ^4'
		forNode: [ :method | method body statements first arguments first body statements first ]
]

{ #category : #'api - action' }
GtRemoveUnreachableCodeFixItAction >> description [
	^ 'Remove unreachable code'
]

{ #category : #'api - action' }
GtRemoveUnreachableCodeFixItAction >> id [
	^ GtRemoveUnreachableCodeFixItActionElementId
]

{ #category : #executing }
GtRemoveUnreachableCodeFixItAction >> updateSource [
	| string |
	string := SmaCCString on: node topParent completeSource.
	node parent periods
		do: [ :each | 
			each startPosition > node stopPosition
				ifTrue: [ string deleteFrom: each startPosition to: each stopPosition ] ].
	(node parent statements identityIndexOf: node) + 1
		to: node parent statements size
		do: [ :i | 
			| nodeToRemove |
			nodeToRemove := node parent statements at: i.
			string deleteWhitespaceBeforeIndex: nodeToRemove startPosition.
			string deleteFrom: nodeToRemove startPosition to: nodeToRemove stopPosition ].
	^ string asString
]
