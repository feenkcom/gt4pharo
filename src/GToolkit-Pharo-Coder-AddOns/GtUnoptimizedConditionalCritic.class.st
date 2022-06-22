Class {
	#name : #GtUnoptimizedConditionalCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtUnoptimizedConditionalCritic >> description [
	^ '((a and:[b]) and: [c]) can be written as (a and: [b and: [c]])'
]

{ #category : #private }
GtUnoptimizedConditionalCritic >> fixItActionsFor: aNode using: aCriticStyler [
	^ {GtReorderConditionalsFixItAction
			forCoder: aCriticStyler coderModel
			node: aNode}
]

{ #category : #styling }
GtUnoptimizedConditionalCritic >> highlightPositionsFor: aSmaCCNode [
	^ OrderedCollection new
		addAll: (aSmaCCNode receiver message selectorParts collect: #sourceInterval);
		addAll: (aSmaCCNode message selectorParts collect: #sourceInterval);
		yourself
]

{ #category : #accessing }
GtUnoptimizedConditionalCritic >> matches: aNode from: aCriticRunner [
	| conditionals |
	(aNode isMessageSend and: [ aNode receiver isMessageSend ])
		ifFalse: [ ^ false ].
	conditionals := #(and: or:).
	^ (conditionals includes: aNode message selector)
		and: [ aNode message selector = aNode receiver message selector
				and: [ aNode receiver message arguments first isBlock
						and: [ aNode message arguments first isBlock ] ] ]
]

{ #category : #accessing }
GtUnoptimizedConditionalCritic >> name [
	^ 'Unoptimized conditional expression'
]

{ #category : #enumerating }
GtUnoptimizedConditionalCritic >> potentialFilter [
	^ (#and: gtReferences | #or: gtReferences) asAsyncStream
]
