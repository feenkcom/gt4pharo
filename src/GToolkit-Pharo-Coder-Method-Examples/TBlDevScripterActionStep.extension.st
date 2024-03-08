Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*GToolkit-Pharo-Coder-Method-Examples' }
TBlDevScripterActionStep >> methodCoder [
	^ self
		addStep: (GtPharoMethodCoderStep new
				label: 'Pharo method coder';
				referenceSender)
]

{ #category : #'*GToolkit-Pharo-Coder-Method-Examples' }
TBlDevScripterActionStep >> methodCoderStep: aBlock [
	| step |
	step := self methodCoder.
	step referenceSender.
	aBlock value: step.
	step play
]
