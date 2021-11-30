Extension { #name : #GtPharoMethodSequenceNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoMethodSequenceNode >> completionActionStreamFor: aStrategy [
	pragmas
		do:
			[ :each | (aStrategy index between: each startPosition and: each stopPosition) ifTrue: [ ^ each completionActionStreamFor: aStrategy ] ].
	^ super completionActionStreamFor: aStrategy
]
