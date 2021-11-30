Extension { #name : #GtPharoBlockNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoBlockNode >> completionActionStreamFor: aStrategy [
	body
		ifNotNil:
			[ (aStrategy index between: body startPosition and: body stopPosition)
				ifTrue: [ ^ body completionActionStreamFor: aStrategy ] ].
	^ #() asAsyncStream
]
