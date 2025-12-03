Class {
	#name : #GtTemporaryNotUsedAdvice,
	#superclass : #GtMethodAdvice,
	#instVars : [
		'variables'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtTemporaryNotUsedAdvice >> description [
	^ 'Temporary variable is not used.'
]

{ #category : #accessing }
GtTemporaryNotUsedAdvice >> finish: aNode from: criticRunner [
	aNode isErrorNode ifTrue: [ ^ self ].
	(aNode isSequence and: [ aNode variables notEmpty ]) ifFalse: [ ^ self ].
	aNode variables
		do: [ :each | 
			(variables includes: each variableName)
				ifTrue: [ criticRunner foundIssue: self in: each.
					variables remove: each variableName ] ]
]

{ #category : #accessing }
GtTemporaryNotUsedAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ {GtRemoveTemporaryFixItAction forCoder: coderModel node: aNode}
]

{ #category : #accessing }
GtTemporaryNotUsedAdvice >> initialize [
	super initialize.
	variables := Set new
]

{ #category : #accessing }
GtTemporaryNotUsedAdvice >> matches: aNode from: aCriticRunner [
	aNode isErrorNode ifTrue: [ ^ false ].
	(aNode isSequence and: [ aNode variables notEmpty ])
		ifTrue: [ aNode variables do: [ :each | variables add: each variableName ] ].
	aNode isVariable
		ifTrue: [ (aNode parent isSequence
				and: [ aNode parent variables identityIncludes: aNode ])
				ifFalse: [ variables remove: aNode variableName ifAbsent: [  ] ] ].
	^ false
]

{ #category : #accessing }
GtTemporaryNotUsedAdvice >> name [
	^ 'Temporary is not used'
]
