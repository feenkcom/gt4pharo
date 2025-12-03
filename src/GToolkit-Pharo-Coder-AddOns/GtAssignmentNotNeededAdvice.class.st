Class {
	#name : #GtAssignmentNotNeededAdvice,
	#superclass : #GtMethodAdvice,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtAssignmentNotNeededAdvice >> description [
	^ 'Assignment to local variable is not used'
]

{ #category : #private }
GtAssignmentNotNeededAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ {GtRemoveAssignmentFixItAction forCoder: coderModel node: aNode}
]

{ #category : #private }
GtAssignmentNotNeededAdvice >> fixItLocationFor: aSmaCCNode [
	^ aSmaCCNode assignmentToken stopPosition
]

{ #category : #styling }
GtAssignmentNotNeededAdvice >> highlightPositionsFor: aSmaCCNode [
	^ {aSmaCCNode variable startPosition
			to: aSmaCCNode assignmentToken stopPosition}
]

{ #category : #testing }
GtAssignmentNotNeededAdvice >> matches: aNode from: aCriticRunner [
	^ aNode isErrorNode not
		and: [ aNode isAssignment
				and: [ aNode parent notNil
						and: [ aNode parent isReturn and: [ aNode variable whoDefines notNil ] ] ] ]
]

{ #category : #accessing }
GtAssignmentNotNeededAdvice >> name [
	^ 'Assignment is not needed'
]
