Class {
	#name : #GtPharoMethodCodersStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-Pharo-Coder-Examples-Scripter'
}

{ #category : #'steps - interactions' }
GtPharoMethodCodersStep >> scrollToCompiledMethod: aCompiledMethod [
	self do
		label: ('Scroll to {1}' format: { aCompiledMethod printString });
		block: [ :aMethodsCoderElement | 
			aMethodsCoderElement streamingCodersViewModel scrollToCompiledMethod: aCompiledMethod ];
		referenceSender;
		onParentStepTarget: self
]
