Class {
	#name : #GtValueNotUsedCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtValueNotUsedCritic >> description [
	^ 'Variables and literals should be used, or they should be removed to simplify the code.'
]

{ #category : #private }
GtValueNotUsedCritic >> fixItActionsFor: aNode using: aCriticStyler [
	^ {GtRemoveValueFixItAction forCoder: aCriticStyler coderModel node: aNode}
]

{ #category : #testing }
GtValueNotUsedCritic >> matches: aNode from: aCriticRunner [
	aNode isVariable
		ifTrue: [ ^ aNode isUsed not
				and: [ aNode parent isValueNode or: [ aNode parent isMessage ] ] ].
	^ aNode isLiteral and: [ aNode isUsed not ]
]
