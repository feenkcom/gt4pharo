Extension { #name : #GtPharoMessageNode }

{ #category : #'*GToolkit-Pharo-Completer' }
GtPharoMessageNode >> receiver [
	((parent isKindOf: GtPharoMessageSendNode)
		or: [ parent isKindOf: GtPharoCascadeNode ]) ifTrue: [ ^ parent receiver ].
	(parent isKindOf: SmaCCErrorNode)
		ifTrue: [ (parent stackContents notEmpty
				and: [ parent stackContents first isArray
						and: [ parent stackContents first first isKindOf: GtPharoProgramNode ] ])
				ifTrue: [ ^ parent stackContents first first ] ].
	^ (self nodeOfType: GtPharoValueNode) ifNil: [ self ]
]
