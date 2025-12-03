Class {
	#name : #GtRedundantAssignmentAdvice,
	#superclass : #GtMethodAdvice,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtRedundantAssignmentAdvice >> description [
	^ 'Assignment statement is using same variable on both sides. Most likely it should refer to another variable.'
]

{ #category : #private }
GtRedundantAssignmentAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ {GtRemoveValueFixItAction forCoder: coderModel node: aNode}
]

{ #category : #testing }
GtRedundantAssignmentAdvice >> matches: aNode from: aCriticRunner [
	aNode isErrorNode ifTrue: [ ^ false ].
	^ aNode isAssignment and: [ aNode variable = aNode value ]
]

{ #category : #accessing }
GtRedundantAssignmentAdvice >> name [
	^ 'Assignment to same value'
]
