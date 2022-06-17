Class {
	#name : #GtAssignmentNotNeededCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtAssignmentNotNeededCritic >> description [
	^ 'Assignment to local variable is not used'
]

{ #category : #private }
GtAssignmentNotNeededCritic >> fixItActionsFor: aNode using: aCriticStyler [
	^ {GtRemoveAssignmentFixItAction forCoder: aCriticStyler coderModel node: aNode}
]

{ #category : #private }
GtAssignmentNotNeededCritic >> fixItLocationFor: aSmaCCNode [
	^ aSmaCCNode assignmentToken stopPosition
]

{ #category : #styling }
GtAssignmentNotNeededCritic >> highlightPositionsFor: aSmaCCNode [
	^ {aSmaCCNode variable startPosition
			to: aSmaCCNode assignmentToken stopPosition}
]

{ #category : #testing }
GtAssignmentNotNeededCritic >> matches: aNode from: aCriticRunner [
	^ aNode isAssignment
		and: [ aNode parent notNil
				and: [ aNode parent isReturn and: [ aNode variable whoDefines notNil ] ] ]
]
