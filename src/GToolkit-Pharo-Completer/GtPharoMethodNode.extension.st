Extension { #name : #GtPharoMethodNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoMethodNode >> completionActionStreamFor: aStrategy [
	((self comments ifNil: [ #() ]) anySatisfy: [ :each | aStrategy index between: each first and: each last ])
		ifTrue: [ ^ #() asAsyncStream ].
	aStrategy index > pattern stopPosition ifTrue: [ ^ body completionActionStreamFor: aStrategy ].
	^ super completionActionStreamFor: aStrategy
]
