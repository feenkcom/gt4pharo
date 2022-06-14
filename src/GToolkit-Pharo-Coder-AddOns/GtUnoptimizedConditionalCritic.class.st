Class {
	#name : #GtUnoptimizedConditionalCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #private }
GtUnoptimizedConditionalCritic >> attributesFor: aNode from: sourceCoder [
	^ {GtFixItAttributeWithDescription new
			description: self description;
			fixItActions: [ {GtReorderConditionalsFixItAction forCoder: sourceCoder node: aNode} ];
			yourself}
]

{ #category : #accessing }
GtUnoptimizedConditionalCritic >> description [
	^ '((a and:[b]) and: [c]) can be written as (a and: [b and: [c]])'
]

{ #category : #styling }
GtUnoptimizedConditionalCritic >> highlightPositionsFor: aSmaCCNode [
	^ OrderedCollection new
		addAll: (aSmaCCNode receiver message selectorParts collect: #sourceInterval);
		addAll: (aSmaCCNode message selectorParts collect: #sourceInterval);
		yourself
]

{ #category : #private }
GtUnoptimizedConditionalCritic >> locationFor: aSmaCCNode [
	| index |
	index := aSmaCCNode selectorParts last stopPosition.
	^ index to: index
]

{ #category : #accessing }
GtUnoptimizedConditionalCritic >> matches: aNode [
	| conditionals |
	(aNode isMessageSend and: [ aNode receiver isMessageSend ])
		ifFalse: [ ^ false ].
	conditionals := #(and: or:).
	^ (conditionals includes: aNode message selector)
		and: [ aNode message selector = aNode receiver message selector
				and: [ aNode receiver message arguments first isBlock
						and: [ aNode message arguments first isBlock ] ] ]
]
