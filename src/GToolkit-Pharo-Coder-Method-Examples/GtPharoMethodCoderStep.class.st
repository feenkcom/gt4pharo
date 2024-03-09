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
		forEnqueuedSpaceTaskTimeout: 0.2 seconds;
		referenceSender.
	self wait
		forEmptySpaceTaskQueueTimeout: 0.2 seconds;
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
