Class {
	#name : #GtRedundantAssignmentCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #private }
GtRedundantAssignmentCritic >> attributesFor: aNode from: sourceCoder [
	^ {GtFixItAttributeWithDescription new
			description: self description;
			fixItActions: [ {GtRemoveValueFixItAction forCoder: sourceCoder node: aNode} ];
			yourself}
]

{ #category : #accessing }
GtRedundantAssignmentCritic >> description [
	^ 'Assignment statement is using same variable on both sides. Most likely it should refer to another variable.'
]

{ #category : #private }
GtRedundantAssignmentCritic >> locationFor: aSmaCCNode [
	| index |
	index := aSmaCCNode stopPosition.
	^ index to: index
]

{ #category : #testing }
GtRedundantAssignmentCritic >> matches: aNode [
	^ aNode isAssignment and: [ aNode variable = aNode value ]
]
