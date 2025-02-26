Class {
	#name : #GtDuplicateCodeInConditionalAdvice,
	#superclass : #GtMethodAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtDuplicateCodeInConditionalAdvice >> description [
	^ 'Code at the beginning or end of #ifTrue:ifFalse: block is duplicated.'
]

{ #category : #accessing }
GtDuplicateCodeInConditionalAdvice >> matches: aNode from: aCriticRunner [
	| first last |
	aNode isErrorNode ifTrue: [ ^ false ].
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
GtDuplicateCodeInConditionalAdvice >> name [
	^ 'Duplicate code in conditional'
]

{ #category : #enumerating }
GtDuplicateCodeInConditionalAdvice >> potentialFilter [
	^ (#ifTrue:ifFalse: gtReferences | #ifFalse:ifTrue: gtReferences
		| Halt gtReferences) asAsyncStream
]
