Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
TBlDevScripterActionStep >> methodCoders [
	^ self
		addStep: (GtPharoMethodCodersStep new
				label: 'Pharo method coders';
				referenceSender)
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
TBlDevScripterActionStep >> methodCodersStep: aBlock [
	| step |
	step := self methodCoders.
	step referenceSender.
	aBlock value: step.
	step play
]
