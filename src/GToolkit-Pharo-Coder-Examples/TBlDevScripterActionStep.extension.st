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
	<scripterActionStep>
	
	^ self
		addStep: (GtPharoMethodsCoderStep new
				label: 'Pharo methods coder';
				referenceSender)
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
TBlDevScripterActionStep >> pharoCoder [
	<scripterActionStep>
	
	^ self
		addStep: (GtPharoCoderStep new
				label: 'Pharo coder';
				referenceSender)
]

{ #category : #'*GToolkit-Pharo-Coder-Examples' }
TBlDevScripterActionStep >> refactorings [
	<scripterActionStep>
	
	^ self
		addStep: (GtPharoRefactoringsStep new
				label: 'Pharo refactorings';
				referenceSender;
				onParentStepTarget: self)
]
