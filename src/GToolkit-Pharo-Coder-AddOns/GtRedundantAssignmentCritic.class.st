Class {
	#name : #GtRedundantAssignmentCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtRedundantAssignmentCritic >> description [
	^ 'Assignment statement is using same variable on both sides. Most likely it should refer to another variable.'
]

{ #category : #private }
GtRedundantAssignmentCritic >> fixItActionsFor: aNode using: aCriticStyler [
	^ {GtRemoveValueFixItAction forCoder: aCriticStyler coderModel node: aNode}
]

{ #category : #testing }
GtRedundantAssignmentCritic >> matches: aNode from: aCriticRunner [
	^ aNode isAssignment and: [ aNode variable = aNode value ]
]
