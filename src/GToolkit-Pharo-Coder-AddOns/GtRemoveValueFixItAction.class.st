Class {
	#name : #GtRemoveValueFixItAction,
	#superclass : #GtMethodAdviceFixItAction,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #examples }
GtRemoveValueFixItAction class >> removeLiteralAtBeginning [
	<gtExample>
	self = GtRemoveValueFixItAction ifFalse: [ ^ self ].
	^ self
		testOriginal: 'a #(). Transcript print: 1'
		generates: 'a Transcript print: 1'
		forNode: [ :method | method body statements first ]
]

{ #category : #'api - action' }
GtRemoveValueFixItAction >> description [
	^ 'Remove unused expression'
]

{ #category : #'api - action' }
GtRemoveValueFixItAction >> id [
	^ GtRemoveValueFixItActionElementId
]

{ #category : #executing }
GtRemoveValueFixItAction >> nodeToRemove [
	^ node
]

{ #category : #executing }
GtRemoveValueFixItAction >> updateSource [
	| string nodeToRemove |
	nodeToRemove := self nodeToRemove.
	string := SmaCCString on: nodeToRemove topParent completeSource.
	string deleteFrom: nodeToRemove startPosition to: nodeToRemove stopPosition.
	nodeToRemove parent isSequence
		ifTrue: [ (nodeToRemove parent periods
				detect: [ :each | each startPosition > nodeToRemove stopPosition ]
				ifNone: [ nil ])
				ifNotNil: [ :periodToDelete | string deleteFrom: periodToDelete startPosition to: periodToDelete stopPosition ] ].
	self deleteStartOfLineWhitespace: string before: nodeToRemove.
	^ string asString
]
