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
GtEqualsNotUsedCritic >> fixItActionsFor: aNode using: aCriticStyler [
	| actions |
	actions := OrderedCollection new.
	(aNode selector = #=
		and: [ aNode parent notNil
				and: [ aNode parent isMessageSend and: [ aNode parent receiver isVariable ] ] ])
		ifTrue: [ actions
				add: (GtConvertToAssignmentFixItAction forCoder: aCriticStyler coderModel node: aNode) ].
	actions addAll: (super fixItActionsFor: aNode using: aCriticStyler).
	^ actions
]

{ #category : #accessing }
GtEqualsNotUsedCritic >> selectors [
	^ #(= ~= == ~~ < <= > >=)
]
