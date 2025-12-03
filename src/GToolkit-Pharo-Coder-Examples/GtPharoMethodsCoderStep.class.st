Class {
	#name : #GtPharoMethodsCoderStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : 'GToolkit-Pharo-Coder-Examples-Scripter'
}

{ #category : #'steps - checks' }
GtPharoMethodsCoderStep >> assertNumberOfVisibleMethodsIsAtLeast: aNumber [
	^ self assert
		label: ('Number of visible methods is at least {1}' format: {aNumber});
		satisfies: [ :anElement | anElement childrenCount >= aNumber ]
			description: [ :anElement | 
				'There are {1} method coder elements, but at least {2} is expected'
					format: {anElement childrenCount.
							aNumber} ];
		referenceSender;
		onParentStepTarget: self;
		// GtPharoStreamingMethodsCoderListId;
		/ #scrollable
]

{ #category : #'steps - checks' }
GtPharoMethodsCoderStep >> assertNumberOfVisibleMethodsIsExactly: aNumber [
	^ self assert
		label: ('Number of visible methods is exactly {1}' format: {aNumber});
		satisfies: [ :anElement | anElement childrenCount = aNumber ]
			description: [ :anElement | 
				'There are {1} method coder elements, but {2} is expected'
					format: {anElement childrenCount.
							aNumber} ];
		referenceSender;
		onParentStepTarget: self;
		// GtPharoStreamingMethodsCoderListId;
		/ #scrollable
]

{ #category : #'steps - checks' }
GtPharoMethodsCoderStep >> assertScrollableDo: aBlock [
	^ self assert
		label: ('Scrollable element satisfies {1}' format: {aBlock printStringLimitedTo: 30});
		do: aBlock;
		referenceSender;
		onParentStepTarget: self;
		// GtPharoStreamingMethodsCoderListId;
		/ #scrollable
]

{ #category : #'steps - interactions' }
GtPharoMethodsCoderStep >> expandAndFocusCompiledMethod: aCompiledMethod [
	^ self do
		label: ('Expand and focus {1}' format: {aCompiledMethod printString});
		block: [ :aMethodsCoderElement | 
			aMethodsCoderElement streamingCodersViewModel
				expandAndFocusCompiledMethod: aCompiledMethod ];
		referenceSender;
		onParentStepTarget: self
]

{ #category : #'steps - interactions' }
GtPharoMethodsCoderStep >> forCompiledMethod: aCompiledMethod do: aMethodCoderStepBlock [
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
GtPharoMethodsCoderStep >> scrollToCompiledMethod: aCompiledMethod [
	self do
		label: ('Scroll to {1}' format: { aCompiledMethod printString });
		block: [ :aMethodsCoderElement | 
			aMethodsCoderElement streamingCodersViewModel scrollToCompiledMethod: aCompiledMethod ];
		referenceSender;
		onParentStepTarget: self.
		
	self wait forEmptySpaceTaskQueueTimeout: 3 seconds
]

{ #category : #'steps - interactions' }
GtPharoMethodsCoderStep >> waitForEnqueuedAndProcessedSpaceTasks [
	^ self
		substeps2: 'Wait for non-UI tasks'
		do: [ :aStep | 
			aStep wait forEnqueuedSpaceTaskTimeout: 2 seconds.
			aStep wait forEmptySpaceTaskQueueTimeout: 2 seconds ]
]
