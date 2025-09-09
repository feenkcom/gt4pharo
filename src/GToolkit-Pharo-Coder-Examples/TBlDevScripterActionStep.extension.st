Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
TBlDevScripterActionStep >> methodCoders [
	^ self methodsCoder
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
TBlDevScripterActionStep >> methodCodersStep: aBlock [
	| step |
	step := self methodCoders.
	step referenceSender.
	aBlock value: step.
	step play
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
TBlDevScripterActionStep >> methodsCoder [
	^ self
		addStep: (GtPharoMethodsCoderStep new
				label: 'Pharo methods coder';
				referenceSender)
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
TBlDevScripterActionStep >> pharoCoder [
	^ self
		addStep: (GtPharoCoderStep new
				label: 'Pharo coder';
				referenceSender)
]
