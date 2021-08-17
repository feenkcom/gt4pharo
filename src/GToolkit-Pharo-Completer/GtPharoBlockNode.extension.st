Extension { #name : 'GtPharoBlockNode' }

{ #category : '*GToolkit-Pharo-Completer' }
GtPharoBlockNode >> completionActionsFor: aStrategy [
	(aStrategy index between: body startPosition and: body stopPosition)
		ifTrue: [ ^ body completionActionsFor: aStrategy ].
	^ #()
]
