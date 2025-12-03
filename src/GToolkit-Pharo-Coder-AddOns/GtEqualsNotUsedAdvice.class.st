Class {
	#name : #GtEqualsNotUsedAdvice,
	#superclass : #GtSendNotUsedAdvice,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtEqualsNotUsedAdvice >> description [
	^ 'Comparison messages should be used. #= messages may be missing : for an assignment expression.'
]

{ #category : #private }
GtEqualsNotUsedAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	| actions |
	actions := OrderedCollection new.
	(aNode selector = #=
		and: [ aNode parent notNil
				and: [ aNode parent isMessageSend and: [ aNode parent receiver isVariable ] ] ])
		ifTrue: [ actions
				add: (GtConvertToAssignmentFixItAction forCoder: coderModel node: aNode) ].
	actions addAll: (super fixItActionsForNode: aNode coderModel: coderModel).
	^ actions
]

{ #category : #accessing }
GtEqualsNotUsedAdvice >> selectors [
	^ #(= ~= == ~~ < <= > >=)
]
