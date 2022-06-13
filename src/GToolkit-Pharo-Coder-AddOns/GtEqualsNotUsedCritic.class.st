Class {
	#name : #GtEqualsNotUsedCritic,
	#superclass : #GtSendNotUsedCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtEqualsNotUsedCritic >> description [
	^ 'Comparison messages should be used. #= messages may be missing : for an assignment expression.'
]

{ #category : #private }
GtEqualsNotUsedCritic >> fixItActionsFor: aNode from: sourceCoder [
	| actions |
	actions := OrderedCollection new.
	(aNode selector = #=
		and: [ aNode parent notNil
				and: [ aNode parent isMessageSend and: [ aNode parent receiver isVariable ] ] ])
		ifTrue: [ actions
				add: (GtConvertToAssignmentFixItAction forCoder: sourceCoder node: aNode) ].
	actions addAll: (super fixItActionsFor: aNode from: sourceCoder).
	^ actions
]

{ #category : #accessing }
GtEqualsNotUsedCritic >> selectors [
	^ #(= ~= == ~~ < <= > >=)
]
