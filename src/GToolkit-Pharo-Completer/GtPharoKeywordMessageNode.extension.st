Extension { #name : #GtPharoKeywordMessageNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoKeywordMessageNode >> keywordArrayWithToken: aToken [
	| hasInserted keywords |
	hasInserted := false.
	keywords := OrderedCollection new.
	self selectorParts
		do: [ :each | 
			hasInserted
				ifFalse: [ aToken startPosition < each startPosition
						ifTrue: [ hasInserted := true.
							keywords add: aToken source ] ].
			keywords add: each source ].
	hasInserted ifFalse: [ keywords add: aToken source ].
	^ keywords
]
