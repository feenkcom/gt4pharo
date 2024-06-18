Class {
	#name : #GtPharoMethodCodersStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-Pharo-Coder-Examples-Scripter'
}

{ #category : #'steps - interactions' }
GtPharoMethodCodersStep >> expandAndFocusCompiledMethod: aCompiledMethod [
	self do
		label: ('Expand and focus {1}' format: { aCompiledMethod printString });
		block: [ :aMethodsCoderElement | 
			aMethodsCoderElement streamingCodersViewModel expandAndFocusCompiledMethod: aCompiledMethod ];
		referenceSender;
		onParentStepTarget: self
]

{ #category : #'steps - interactions' }
GtPharoMethodCodersStep >> forCompiledMethod: aCompiledMethod do: aMethodCoderStepBlock [
	"The compiled method coder must be visible."

	| aFutureTarget aMethodCoderStep | 
	aFutureTarget := BlDevScripterOneElementQueryEventTarget new.
	
	self do
		label: ('Get method coder element ID for {1}' format: { aCompiledMethod printString });
		block: [ :anInfiniteList | 
			anInfiniteList children 
				detect: [ :eachMethodCoder | eachMethodCoder textualCoderViewModel compiledMethod == aCompiledMethod ]
				ifFound: [ :aMethodCoder | 
					aFutureTarget // aMethodCoder id ]
				ifNone: [ AssertionFailure signal: ('Method coder element ID must be defined: ''{1}''' format: { aFutureTarget }) ] ];
		onParentStepTarget: self;
		// GtPharoStreamingMethodsCoderListId;
		/ #scrollable;
		onTopMost.
		
	aMethodCoderStep := self methodCoder
		label: ('Method coder {1}'  format: { aCompiledMethod printString });
		referenceSender;
		onParentStepTarget: self;
		updateTarget: aFutureTarget;
		onTopMost.

	aMethodCoderStepBlock value: aMethodCoderStep.
	
	^ aMethodCoderStep
]

{ #category : #'steps - interactions' }
GtPharoMethodCodersStep >> scrollToCompiledMethod: aCompiledMethod [
	self do
		label: ('Scroll to {1}' format: { aCompiledMethod printString });
		block: [ :aMethodsCoderElement | 
			aMethodsCoderElement streamingCodersViewModel scrollToCompiledMethod: aCompiledMethod ];
		referenceSender;
		onParentStepTarget: self.
		
	self wait forEmptySpaceTaskQueueTimeout: 3 seconds
]
