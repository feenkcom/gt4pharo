Class {
	#name : #GtValueNotUsedAdvice,
	#superclass : #GtMethodAdvice,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtValueNotUsedAdvice >> description [
	^ 'Variables and literals should be used, or they should be removed to simplify the code.'
]

{ #category : #private }
GtValueNotUsedAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ {GtRemoveValueFixItAction forCoder: coderModel node: aNode}
]

{ #category : #testing }
GtValueNotUsedAdvice >> matches: aNode from: aCriticRunner [
	aNode isErrorNode ifTrue: [ ^ false ].
	aNode isVariable
		ifTrue: [ ^ aNode isUsed not
				and: [ aNode parent isValueNode or: [ aNode parent isMessage ] ] ].
	^ aNode isLiteral and: [ aNode isUsed not ]
]

{ #category : #accessing }
GtValueNotUsedAdvice >> name [
	^ 'Value is not used'
]
