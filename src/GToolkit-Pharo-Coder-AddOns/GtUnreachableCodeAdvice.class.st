Class {
	#name : #GtUnreachableCodeAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtUnreachableCodeAdvice >> description [
	^ 'Code after a return is unreachable.'
]

{ #category : #'as yet unclassified' }
GtUnreachableCodeAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ {GtRemoveUnreachableCodeFixItAction forCoder: coderModel node: aNode}
]

{ #category : #styling }
GtUnreachableCodeAdvice >> fixItLocationFor: aSmaCCNode [
	^ aSmaCCNode stopPosition
]

{ #category : #testing }
GtUnreachableCodeAdvice >> matches: aNode from: aCriticRunner [
	aNode parent ifNil: [ ^ false ].
	aNode parent isSequence ifFalse: [ ^ false ].
	aNode parent statements size > 1 ifFalse: [ ^ false ].
	aNode parent statements last == aNode ifTrue: [ ^ false ].
	^ aNode lastIsReturn
]

{ #category : #accessing }
GtUnreachableCodeAdvice >> name [
	^ 'Unreachable code'
]
