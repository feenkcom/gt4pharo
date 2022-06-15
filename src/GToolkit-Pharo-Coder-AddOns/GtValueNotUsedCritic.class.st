Class {
	#name : #GtValueNotUsedCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #private }
GtValueNotUsedCritic >> attributesFor: aNode from: sourceCoder [
	^ {GtFixItAttributeWithDescription new
			description: [:editorElement | self descriptionWithEditor: editorElement ];
			fixItActions: [ {GtRemoveValueFixItAction forCoder: sourceCoder node: aNode} ];
			yourself}
]

{ #category : #accessing }
GtValueNotUsedCritic >> description [
	^ 'Variables and literals should be used, or they should be removed to simplify the code.'
]

{ #category : #private }
GtValueNotUsedCritic >> locationFor: aSmaCCNode [
	| index |
	index := aSmaCCNode stopPosition.
	^ index to: index
]

{ #category : #testing }
GtValueNotUsedCritic >> matches: aNode [
	aNode isVariable
		ifTrue: [ ^ aNode isUsed not
				and: [ aNode parent isValueNode or: [ aNode parent isMessage ] ] ].
	^ aNode isLiteral and: [ aNode isUsed not ]
]
