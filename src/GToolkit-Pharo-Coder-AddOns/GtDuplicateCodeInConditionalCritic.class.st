Class {
	#name : #GtDuplicateCodeInConditionalCritic,
	#superclass : #GtMethodCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtDuplicateCodeInConditionalCritic >> description [
	^ 'Code at the beginning or end of #ifTrue:ifFalse: block is duplicated.'
]

{ #category : #accessing }
GtDuplicateCodeInConditionalCritic >> matches: aNode from: aCriticRunner [
	| first last |
	aNode isMessage ifFalse: [ ^ false ].
	(#(#ifTrue:ifFalse: #ifFalse:ifTrue:) includes: aNode selector)
		ifFalse: [ ^ false ].
	(aNode arguments allSatisfy: [ :each | each isBlock ]) ifFalse: [ ^ false ].
	first := aNode arguments first body statements.
	last := aNode arguments last body statements.
	(first isEmpty or: [ last isEmpty ]) ifTrue: [ ^ false ].
	^ first first = last first or: [ first last = last last ]
]

{ #category : #accessing }
GtDuplicateCodeInConditionalCritic >> name [
	^ 'Duplicate code in conditional'
]

{ #category : #enumerating }
GtDuplicateCodeInConditionalCritic >> potentialMethodsDo: aBlock [
	#ifTrue:ifFalse: gtReferences | #ifFalse:ifTrue: gtReferences
		| Halt gtReferences do: aBlock
]
