Class {
	#name : #GtTemporaryNotUsedCritic,
	#superclass : #GtMethodCritic,
	#instVars : [
		'variables'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtTemporaryNotUsedCritic >> description [
	^ 'Temporary variable is not used.'
]

{ #category : #accessing }
GtTemporaryNotUsedCritic >> finish: aNode from: criticRunner [
	(aNode isSequence and: [ aNode variables notEmpty ]) ifFalse: [ ^ self ].
	aNode variables
		do: [ :each | 
			(variables includes: each variableName)
				ifTrue: [ criticRunner foundIssue: self in: each.
					variables remove: each variableName ] ]
]

{ #category : #accessing }
GtTemporaryNotUsedCritic >> fixItActionsFor: aNode using: aCriticStyler [
	^ {GtRemoveTemporaryFixItAction forCoder: aCriticStyler coderModel node: aNode}
]

{ #category : #accessing }
GtTemporaryNotUsedCritic >> initialize [
	super initialize.
	variables := Set new
]

{ #category : #accessing }
GtTemporaryNotUsedCritic >> matches: aNode from: aCriticRunner [
	(aNode isSequence and: [ aNode variables notEmpty ])
		ifTrue: [ aNode variables do: [ :each | variables add: each variableName ] ].
	aNode isVariable
		ifTrue: [ (aNode parent isSequence
				and: [ aNode parent variables identityIncludes: aNode ])
				ifFalse: [ variables remove: aNode variableName ifAbsent: [  ] ] ].
	^ false
]
