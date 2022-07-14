Class {
	#name : #GtUnoptimizedToDoCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtUnoptimizedToDoCritic >> description [
	^ '#to:do: is optimized by the compiler and is faster than using (to:)do:'
]

{ #category : #private }
GtUnoptimizedToDoCritic >> fixItActionsFor: aNode using: aCriticStyler [
	^ {(GtRemoveParenthesisFixItAction
			forCoder: aCriticStyler coderModel
			node: aNode receiver)
			description: 'Convert to optimized #' , aNode receiver selector , aNode selector;
			yourself}
]

{ #category : #styling }
GtUnoptimizedToDoCritic >> highlightPositionsFor: aSmaCCNode [
	^ OrderedCollection new
		addAll: (aSmaCCNode receiver message selectorParts collect: #sourceInterval);
		addAll: (aSmaCCNode message selectorParts collect: #sourceInterval);
		yourself
]

{ #category : #accessing }
GtUnoptimizedToDoCritic >> matches: aNode from: aCriticRunner [
	(aNode isMessageSend and: [ aNode receiver isMessageSend ])
		ifFalse: [ ^ false ].
	^ aNode message selector = #do:
		and: [ #(to: #to:by:) includes: aNode receiver message selector ]
]

{ #category : #accessing }
GtUnoptimizedToDoCritic >> name [
	^ 'to:{by:}do: not optimized'
]

{ #category : #enumerating }
GtUnoptimizedToDoCritic >> potentialFilter [
	^ (#do: gtReferences & (#to: gtReferences | #to:by: gtReferences))
		asAsyncStream
]
