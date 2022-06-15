Class {
	#name : #GtAssignmentNotNeededCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #private }
GtAssignmentNotNeededCritic >> attributesFor: aNode from: sourceCoder [
	^ {GtFixItAttributeWithDescription new
			description: self description;
			fixItActions: [ {GtRemoveAssignmentFixItAction forCoder: sourceCoder node: aNode} ];
			yourself}
]

{ #category : #accessing }
GtAssignmentNotNeededCritic >> description [
	^ 'Assignment to local variable is not used'
]

{ #category : #styling }
GtAssignmentNotNeededCritic >> highlightPositionsFor: aSmaCCNode [
	^ {aSmaCCNode variable startPosition
			to: aSmaCCNode assignmentToken stopPosition}
]

{ #category : #private }
GtAssignmentNotNeededCritic >> locationFor: aSmaCCNode [
	| index |
	index := aSmaCCNode assignmentToken stopPosition.
	^ index to: index
]

{ #category : #testing }
GtAssignmentNotNeededCritic >> matches: aNode [
	^ aNode isAssignment
		and: [ aNode parent notNil
				and: [ aNode parent isReturn and: [ aNode variable whoDefines notNil ] ] ]
]
