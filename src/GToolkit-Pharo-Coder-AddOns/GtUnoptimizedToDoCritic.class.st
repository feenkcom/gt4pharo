Class {
	#name : #GtUnoptimizedToDoCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #private }
GtUnoptimizedToDoCritic >> attributesFor: aNode from: sourceCoder [
	^ {GtFixItAttributeWithDescription new
			description: [:editorElement | self descriptionWithEditor: editorElement ];
			fixItActions: [ {(GtRemoveParenthesisFixItAction forCoder: sourceCoder node: aNode receiver)
						description: 'Convert to optimized #' , aNode receiver selector , aNode selector;
						yourself} ];
			yourself}
]

{ #category : #accessing }
GtUnoptimizedToDoCritic >> description [
	^ '#to:do: is optimized by the compiler and is faster than using (to:)do:'
]

{ #category : #styling }
GtUnoptimizedToDoCritic >> highlightPositionsFor: aSmaCCNode [
	^ OrderedCollection new
		addAll: (aSmaCCNode receiver message selectorParts collect: #sourceInterval);
		addAll: (aSmaCCNode message selectorParts collect: #sourceInterval);
		yourself
]

{ #category : #private }
GtUnoptimizedToDoCritic >> locationFor: aSmaCCNode [
	| index |
	index := aSmaCCNode selectorParts last stopPosition.
	^ index to: index
]

{ #category : #accessing }
GtUnoptimizedToDoCritic >> matches: aNode [
	(aNode isMessageSend and: [ aNode receiver isMessageSend ])
		ifFalse: [ ^ false ].
	^ aNode message selector = #do:
		and: [ #(to: #to:by:) includes: aNode receiver message selector ]
]
