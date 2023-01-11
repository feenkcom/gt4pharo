Extension { #name : #GtPharoPragmaNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoPragmaNode >> completionActionStreamFor: aStrategy [
	| prefix index |
	index := aStrategy index.
	(self lessThan stopPosition = index and: [ self selectorParts isEmpty ])
		ifTrue: [ prefix := '' ].
	(self selectorParts size = 1
		and: [ self selectorParts first stopPosition = index ])
		ifTrue: [ prefix := self selectorParts first source ].
	prefix isNil ifTrue: [ ^ #() asAsyncStream ].
	^ (aStrategy pragmas asyncWeightedStreamStartingWith: prefix)
		collect: [ :each | 
			self
				actionForSelector: each
				startingWith: prefix
				at: index
				strategy: aStrategy ]
]
