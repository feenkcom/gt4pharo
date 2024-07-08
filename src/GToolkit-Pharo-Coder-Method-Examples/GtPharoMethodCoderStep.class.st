Class {
	#name : #GtPharoMethodCoderStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-Pharo-Coder-Method-Examples-Scripter'
}

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertBinding: aBindingKey is: anObject [
	| anAssertStep |
	anAssertStep := self check
			label: ('Assert binding {1} is {2}'
					format: {aBindingKey.
							anObject});
			value: [ :aCoderElement | 
					aCoderElement textualCoderViewModel evaluationContext
						variableValueOf: aBindingKey
						ifPresent: [ :aValue | aValue ]
						ifAbsent: [ nil ] ]
				equals: anObject;
			referenceSender;
			onParentStepTarget: self.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertBindingIsNotDefined: aBindingKey [
	| anAssertStep aBindingValue |
	anAssertStep := self check
			label: ('Assert binding {1} is not defined' format: {aBindingKey});
			satisfies: [ :aCoderElement | 
					| isDefined |
					aCoderElement textualCoderViewModel evaluationContext
						variableValueOf: aBindingKey
						ifPresent: [ :aValue | 
							isDefined := true.
							aBindingValue := aValue ]
						ifAbsent: [ isDefined := false ].
					isDefined not ]
				description: [ 'Binding {1} value must not be defined. Its value is {2}.'
						format: {aBindingKey.
								aBindingValue} ];
			referenceSender;
			onParentStepTarget: self.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertCompiledMethodIs: aCompiledMethod [
	| anAssertStep |
	anAssertStep := self check
			label: ('Assert compiled method is {1}' format: {aCompiledMethod printString});
			value: [ :aCoderElement | aCoderElement textualCoderViewModel compiledMethod ]
				equals: aCompiledMethod;
			referenceSender;
			onParentStepTarget: self.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertExplicitProviderClassIs: aBehavior [
	| anAssertStep |
	anAssertStep := self assert
			label: ('Assert explicit provider class is {1}' format: {aBehavior});
			value: [ :aCoderElement | aCoderElement textualCoderViewModel explicitProviderClass ]
				equals: aBehavior;
			referenceSender;
			onParentStepTarget: self.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertHeaderMethodBehaviorIs: aBehavior [
	| anAssertStep |
	self assertHeaderProviderIsVisible referenceSender.

	anAssertStep := self assert
			label: ('Assert header provider class is {1}' format: {aBehavior});
			value: [ :aButton | aButton label asString ] equals: aBehavior name asString;
			referenceSender;
			onParentStepTarget: self;
			// GtPharoHeaderMethodBehaviorId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertHeaderMethodBehaviorIsNotVisible [
	| anAssertStep |
	anAssertStep := self assert
			label: 'Assert header provider class is not visible';
			satisfies: [ :aButton | aButton parent visibility = BlVisibility gone ]
				description: [ :aButton | 'Provider class header must be hidden: {1}' format: {aButton parent} ];
			referenceSender;
			onParentStepTarget: self;
			// GtPharoHeaderMethodBehaviorId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertHeaderProviderBehaviorIs: aBehavior [
	| anAssertStep |
	anAssertStep := self assert
			label: ('Assert header receiver class is {1}' format: {aBehavior});
			value: [ :aButton | aButton label asString ] equals: aBehavior name asString;
			referenceSender;
			onParentStepTarget: self;
			// GtPharoHeaderProviderBehaviorId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertHeaderProviderIsVisible [
	| anAssertStep |
	anAssertStep := self assert
			label: 'Assert header provider class is not visible';
			satisfies: [ :aButton | aButton parent visibility = BlVisibility visible ]
				description: [ :aButton | 'Provider class header must be hidden: {1}' format: {aButton parent} ];
			referenceSender;
			onParentStepTarget: self;
			// GtPharoHeaderMethodBehaviorId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertMethodExpandersCountIs: aNumber [
	| anAssertStep |
	anAssertStep := self check
			label: ('Assert {1} method {2}'
					format: {aNumber.
							'expander' asPluralBasedOn: aNumber});
			do: [ :aCoderElement | self privateAssertExpandersCount: aNumber coderElement: aCoderElement ];
			referenceSender;
			onParentStepTarget: self.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertPlayAndInspectActionExists [
	| anAssertStep |
	anAssertStep := self check
			label: 'Assert play and inspect button exists';
			exists;
			referenceSender;
			onParentStepTarget: self;
			// GtPharoMethodPlayAndInspectActionId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertPlayAndInspectActionNotExists [
	| anAssertStep |
	anAssertStep := self check
			label: 'Assert play and inspect button exists';
			notExists;
			referenceSender;
			onParentStepTarget: self;
			// GtPharoMethodPlayAndInspectActionId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertPrintItString: aString [
	^ self assert
		label: ('Assert print-it is {1}' format: { aString });
		value: [ :aLabel | aLabel text asString ] equals: aString;
		onParentStepTarget: self;
		// GtSourceCoderEditorId;
		// GtCoderPrintStringElementId;
		onTopMost.
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertSelfObjectIs: anObject [
	| anAssertStep |
	anAssertStep := self assert
			label: ('Assert self object is {1}' format: {anObject});
			value: [ :aCoderElement | aCoderElement textualCoderViewModel selfObject ]
				equals: anObject;
			referenceSender;
			onParentStepTarget: self.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertTargetBehaviorIs: aBehavior [
	| anAssertStep |
	anAssertStep := self assert
			label: ('Assert behavior is {1}' format: {aBehavior});
			value: [ :aCoderElement | aCoderElement textualCoderViewModel evaluationContext targetBehavior ]
				equals: aBehavior;
			referenceSender;
			onParentStepTarget: self.

	^ anAssertStep
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> clickOnMethodCoderExpander: anExpanderIndex insideDo: anInsideBlock [
	| aRootStep |
	self click
		label: ('Click on expander number {1}' format: {anExpanderIndex});
		onParentStepTarget: self;
		referenceSender;
		// (GtPharoMethodExpanderId indexed: anExpanderIndex);
		onTopMost.

	self wait
		forEnqueuedSpaceTaskTimeout: 0.4 seconds;
		referenceSender.
	self wait
		forEmptySpaceTaskQueueTimeout: 0.4 seconds;
		referenceSender.

	aRootStep := self methodCoder
			label: 'Embedded method coder';
			referenceSender;
			onParentStepTarget: self;
			// (GtPharoEmbeddedMethodId indexed: anExpanderIndex);
			onTopMost.

	anInsideBlock value: aRootStep.

	^ aRootStep
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> clickOnPlayAndInspectButton [
	| aClickStep |
	aClickStep := self click
			referenceSender;
			label: 'Click on play and inspect button';
			onParentStepTarget: self;
			// GtPharoMethodPlayAndInspectActionId.
	^ aClickStep
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> clickOnPlayAndInspectExampleButton [
	| aClickStep |
	aClickStep := self click
			referenceSender;
			label: 'Click on play and inspect example button';
			onParentStepTarget: self;
			// GtMethodCoderPlayAndInspectExampleActionId;
			onTopMost.
	^ aClickStep
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> methodCoderExpander: anExpanderIndex insideDo: anInsideBlock [
	| aRootStep |
	aRootStep := self methodCoder
			label: 'Embedded method coder';
			referenceSender;
			onParentStepTarget: self;
			// (GtPharoEmbeddedMethodId indexed: anExpanderIndex);
			onTopMost.

	anInsideBlock value: aRootStep.

	^ aRootStep
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> printIt [
	^ self shortcut
		label: 'Print result';
		combination: BlKeyCombination primaryP;
		onParentStepTarget: self;
		// GtSourceCoderEditorId;
		onTopMost
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> privateAssertExpandersCount: aNumber coderElement: aCoderElement [
	| allCounts missingExpanders extraExpanders unexpectedExpander |
	allCounts := (1 to: aNumber)
			collect: [ :anIndex | 
				| aQuery |
				aQuery := aCoderElement query // (GtPharoMethodExpanderId indexed: anIndex).
				aQuery all size ].

	missingExpanders := Array
			streamContents: [ :aStream | 
				allCounts
					withIndexDo: [ :aCount :anIndex | aCount = 0 ifTrue: [ aStream nextPut: anIndex ] ] ].

	extraExpanders := Array
			streamContents: [ :aStream | 
				allCounts
					withIndexDo: [ :aCount :anIndex | aCount > 1 ifTrue: [ aStream nextPut: anIndex ] ] ].

	self
		assert: (extraExpanders isEmpty and: [ missingExpanders isEmpty ])
		description: [ String
				streamContents: [ :aStream | 
					aStream nextPutAll: 'There are '.
					extraExpanders
						ifNotEmpty: [ aStream nextPutAll: 'expanders with the same index: '.
							extraExpanders
								do: [ :anIndex | aStream print: anIndex ]
								separatedBy: [ aStream nextPutAll: ', ' ].

							missingExpanders ifNotEmpty: [ aStream nextPutAll: ', and ' ] ].

					missingExpanders
						ifNotEmpty: [ aStream nextPutAll: 'missing expanders with index: '.
							missingExpanders
								do: [ :anIndex | aStream print: anIndex ]
								separatedBy: [ aStream nextPutAll: ', ' ] ] ] ].

	unexpectedExpander := aCoderElement query
			// (GtPharoMethodExpanderId indexed: aNumber + 1).
	self
		assert: unexpectedExpander all size = 0
		description: [ 'There is at least one more expander compared to {1} expected expanders'
				format: {aNumber} ]
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> select: aString from: aFromIndex to: aToIndex [
	^ self do
		referenceSender;
		label: ('Select text "{3}" from {1} to {2}'
				format: {aFromIndex. aToIndex. aString});
		block: [ :anEditor | 
			anEditor selecter
				from: aFromIndex to: aToIndex;
				select.
			self assert: anEditor editor selectedText asString equals: aString ];
		onParentStepTarget: self;
		// GtSourceCoderEditorId;
		onTopMost
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> toggleMethodCoderExpander: anExpanderIndex insideDo: anInsideBlock [
	| aRootStep |
	self click
		label: ('Expand method coder expander number {1}' format: {anExpanderIndex});
		onParentStepTarget: self;
		// (GtPharoMethodExpanderId indexed: anExpanderIndex);
		onTopMost.

	self wait
		forEnqueuedSpaceTaskTimeout: 0.2 seconds;
		referenceSender.
	self wait
		forEmptySpaceTaskQueueTimeout: 0.2 seconds;
		referenceSender.

	aRootStep := self methodCoder
			label: 'Embedded method coder';
			referenceSender;
			onParentStepTarget: self;
			// GtSourceCoderEditorId;
			// GtSourceCoderExpandedContentElement.

	anInsideBlock value: aRootStep.

	self click
		label: ('Collapse method coder expander number {1}' format: {anExpanderIndex});
		onParentStepTarget: self;
		// (GtPharoMethodExpanderId indexed: anExpanderIndex);
		onTopMost.

	^ aRootStep
]
