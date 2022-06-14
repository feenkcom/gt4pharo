Class {
	#name : #GtSendNotUsedCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #testing }
GtSendNotUsedCritic class >> isAbstract [
	^ self = GtSendNotUsedCritic
]

{ #category : #private }
GtSendNotUsedCritic >> attributesFor: aNode from: sourceCoder [
	^ {GtFixItAttributeWithDescription new
			description: self description;
			fixItActions: [ self fixItActionsFor: aNode from: sourceCoder ];
			yourself}
]

{ #category : #private }
GtSendNotUsedCritic >> fixItActionsFor: aNode from: sourceCoder [
	^ {GtRemoveMessageFixItAction forCoder: sourceCoder node: aNode}
]

{ #category : #accessing }
GtSendNotUsedCritic >> locationFor: aSmaCCNode [
	| index |
	index := aSmaCCNode selectorParts last stopPosition.
	^ index to: index
]

{ #category : #accessing }
GtSendNotUsedCritic >> matches: aNode [
	| parent |
	aNode isMessage ifFalse: [ ^ false ].
	aNode isUsed ifTrue: [ ^ false ].
	^ self selectors includes: aNode selector
]

{ #category : #accessing }
GtSendNotUsedCritic >> selectors [
	self subclassResponsibility
]
