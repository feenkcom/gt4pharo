Extension { #name : 'GtPharoBlockNode' }

{ #category : '*GToolkit-Pharo-Completer' }
GtPharoBlockNode >> completionActionsFor: aStrategy [

	body ifNil: [ ^ #(  ) ].

	(aStrategy index between: body startPosition and: body stopPosition) 
		ifTrue: [ ^ body completionActionsFor: aStrategy ].
	^ #(  )
]
