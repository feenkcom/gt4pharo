Class {
	#name : #GtUnoptimizedConditionalAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtUnoptimizedConditionalAdvice >> description [
	^ '((a and:[b]) and: [c]) can be written as (a and: [b and: [c]])'
]

{ #category : #private }
GtUnoptimizedConditionalAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ {GtReorderConditionalsFixItAction forCoder: coderModel node: aNode}
]

{ #category : #styling }
GtUnoptimizedConditionalAdvice >> highlightPositionsFor: aSmaCCNode [
	^ OrderedCollection new
		addAll: (aSmaCCNode receiver message selectorParts collect: #sourceInterval);
		addAll: (aSmaCCNode message selectorParts collect: #sourceInterval);
		yourself
]

{ #category : #accessing }
GtUnoptimizedConditionalAdvice >> matches: aNode from: aCriticRunner [
	| conditionals |
	aNode isErrorNode ifTrue: [ ^ false ].
	(aNode isMessageSend and: [ aNode receiver isMessageSend ])
		ifFalse: [ ^ false ].
	conditionals := #(and: or:).
	^ (conditionals includes: aNode message selector)
		and: [ aNode message selector = aNode receiver message selector
				and: [ aNode receiver message arguments first isBlock
						and: [ aNode message arguments first isBlock ] ] ]
]

{ #category : #accessing }
GtUnoptimizedConditionalAdvice >> name [
	^ 'Unoptimized conditional expression'
]

{ #category : #enumerating }
GtUnoptimizedConditionalAdvice >> potentialFilter [
	^ (#and: gtReferences | #or: gtReferences) asAsyncStream
]
