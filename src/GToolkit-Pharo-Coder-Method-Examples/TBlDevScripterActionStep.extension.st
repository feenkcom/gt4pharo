Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*GToolkit-Pharo-Coder-Method-Examples' }
TBlDevScripterActionStep >> methodCoder [
	^ self
		addStep: (GtPharoMethodCoderStep new
				label: 'Pharo method coder';
				referenceSender)
]
