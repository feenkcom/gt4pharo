Extension { #name : 'GtPharoMethodNode' }

{ #category : '*GToolkit-Pharo-Completer' }
GtPharoMethodNode >> completionActionsFor: aStrategy [
	((self comments ifNil: [ #() ])
		anySatisfy: [ :each | aStrategy index between: each first and: each last ])
		ifTrue: [ ^ #() ].
	aStrategy index > pattern stopPosition
		ifTrue: [ ^ body completionActionsFor: aStrategy ].
	^ super completionActionsFor: aStrategy
]
