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
GtPharoMethodCoderStep >> assertCoderIsModified [
	| anAssertStep |
	anAssertStep := self assert
			label: 'Assert method is modified';
			satisfies: [ :aCoderElement | aCoderElement textualCoderViewModel isModified ]
				description: [ 'Source code must be modified' ];
			referenceSender;
			onParentStepTarget: self;
			onThisOrDeepChildElementId: GtSourceCoderEditorId;
			onTopMost.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertCoderIsWithoutModifications [
	| anAssertStep |
	anAssertStep := self assert
			label: 'Assert method is not modified';
			satisfies: [ :aCoderElement | aCoderElement textualCoderViewModel isModified not ]
				description: [ 'Source code must not be modified' ];
			referenceSender;
			onParentStepTarget: self;
			onThisOrDeepChildElementId: GtSourceCoderEditorId;
			onTopMost.

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
GtPharoMethodCoderStep >> assertEditorTextAsStringIs: aString [
	| anAssertStep |
	anAssertStep := self assert
			label: ('Assert editor text is: {1}' format: {aString});
			value: [ :aCoderElement | aCoderElement text asString ]
				equals: aString;
			referenceSender;
			onParentStepTarget: self;
			onThisOrDeepChildElementId: GtSourceCoderEditorId;
			onTopMost.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertExampleAssertionHighlightFrom: aStartIndex to: aStopIndex [
	| anAssertStep |
	anAssertStep := self assert
			label: ('Assert example highlight between {1} and {2}'
					format: { aStartIndex. aStopIndex });
			satisfies: [ :aCoderElement | 
					| isStartIndexValid isStopIndexValid |
					isStartIndexValid := false.
					isStopIndexValid := false.
					aCoderElement text attributesFinder
						findAttributesSuchThat: [ :anAttribute | anAttribute isKindOf: BlTextHighlightAttribute]
						indicesDo: [ :aStart :aStop :anAttribute |
							isStartIndexValid := isStartIndexValid | (aStart = aStartIndex).
							isStopIndexValid := isStopIndexValid | (aStop = aStopIndex) ].
					isStartIndexValid & isStopIndexValid ]
				description: [ :aCoderElement |
					String streamContents: [ :aStream | 
						| isRepeated |
						isRepeated := false.
						aStream 
							nextPutAll: 'Example highlight must be from ';
							print: aStartIndex;
							nextPutAll: ' to ';
							print: aStopIndex;
							nextPutAll: ', but is: '.
						aCoderElement text attributesFinder
							findAttributesSuchThat: [ :anAttribute | 
								anAttribute isKindOf: BlTextHighlightAttribute]
							indicesDo: [ :aStart :aStop :anAttribute |
								isRepeated ifTrue: [ aStream nextPutAll: ', ' ].
								isRepeated := true.
								aStream print: aStart; nextPut: $-; print: aStop ] ] ];
			referenceSender;
			onParentStepTarget: self;
			onThisOrDeepChildElementId: GtSourceCoderEditorId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertExampleReturnValueIsKindOf: aReturnValueClass [
	| anAssertStep |
	anAssertStep := self assert
			label: ('Assert example return value is kind of {1}'
					format: { aReturnValueClass });
			satisfies: [ :aCoderElement | 
					| anExample |
					anExample := aCoderElement textualCoderViewModel example.
					anExample isNotNil and: [ anExample returnValue isKindOf: aReturnValueClass ] ]
				description: [ :aCoderElement |
					| anExample aReturnValue |
					anExample := aCoderElement textualCoderViewModel example.
					anExample 
						ifNil: [ 'Example must be non-nil with {1} kind of return value'
							format: { aReturnValueClass } ]
						ifNotNil: [
							aReturnValue := anExample returnValue.
							'Example return value is kind of {1}, but must be kind of {2}: {3}'
							format: { aReturnValue class. aReturnValueClass. aReturnValue } ] ];
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
GtPharoMethodCoderStep >> assertFixItPopoverExists [
	^ self assert
		label: 'Assert fix-it popover exists';
		exists;
		referenceSender;
		onPopover;
		// #'error-fix-it'
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
			label: 'Assert header method class is not visible';
			satisfies: [ :aButton | aButton parent visibility = BlVisibility gone ]
				description: [ :aButton | 'Method class header must be hidden: {1}' format: {aButton parent} ];
			referenceSender;
			onParentStepTarget: self;
			// GtPharoHeaderMethodBehaviorId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertHeaderMethodBehaviorIsVisible [
	| anAssertStep |
	anAssertStep := self assert
			label: 'Assert header method class is visible';
			satisfies: [ :aButton | aButton parent visibility = BlVisibility visible ]
				description: [ :aButton | 'Method class header must be visible: {1}' format: {aButton parent} ];
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
GtPharoMethodCoderStep >> assertHeaderProviderIsNotVisible [
	| anAssertStep |
	anAssertStep := self assert
			label: 'Assert header provider class is not visible';
			satisfies: [ :aButton | aButton parent visibility = BlVisibility gone ]
				description: [ :aButton | 'Provider class header must be hidden: {1}' format: {aButton parent} ];
			referenceSender;
			onParentStepTarget: self;
			// GtPharoHeaderProviderBehaviorId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertHeaderProviderIsVisible [
	| anAssertStep |
	anAssertStep := self assert
			label: 'Assert header provider class is visible';
			satisfies: [ :aButton | aButton parent visibility = BlVisibility visible ]
				description: [ :aButton | 'Provider class header must be visible: {1}' format: {aButton parent} ];
			referenceSender;
			onParentStepTarget: self;
			// GtPharoHeaderProviderBehaviorId.

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
GtPharoMethodCoderStep >> assertParentExampleValueIsKindOf: aReturnValueClass [
	| anAssertStep |
	anAssertStep := self assert
			label: ('Assert parent example return value is kind of {1}'
					format: { aReturnValueClass });
			satisfies: [ :aCoderElement | 
					| aParentExample |
					aParentExample := aCoderElement textualCoderViewModel parentExample.
					aParentExample isNotNil and: [ aParentExample returnValue isKindOf: aReturnValueClass ] ]
				description: [ :aCoderElement |
					| anExample aReturnValue |
					anExample := aCoderElement textualCoderViewModel parentExample.
					anExample 
						ifNil: [ 'Parent example must be non-nil with {1} kind of return value'
							format: { aReturnValueClass } ]
						ifNotNil: [
							aReturnValue := anExample returnValue.
							'Parent example return value is kind of {1}, but must be kind of {2}: {3}'
							format: { aReturnValue class. aReturnValueClass. aReturnValue } ] ];
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
			label: 'Assert play and inspect button does not exist';
			notExists;
			referenceSender;
			onParentStepTarget: self;
			// GtPharoMethodPlayAndInspectActionId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertPlayAndInspectExampleActionExists [
	| anAssertStep |
	anAssertStep := self check
			label: 'Assert play and inspect example button exists';
			exists;
			referenceSender;
			onParentStepTarget: self;
			// GtMethodCoderPlayAndInspectExampleActionId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertPlayAndInspectExampleActionNotExists [
	| anAssertStep |
	anAssertStep := self check
			label: 'Assert play and inspect example button does not exist';
			notExists;
			referenceSender;
			onParentStepTarget: self;
			// GtMethodCoderPlayAndInspectExampleActionId.

	^ anAssertStep
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertPrintItString: aString [
	^ self assert
		label: ('Assert print-it is {1}' format: { aString });
		value: [ :aLabel | aLabel text asString ] equals: aString;
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorId;
		// GtCoderPrintStringElementId;
		onTopMost.
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertSaveAlreadyExistingMethodDialogIsClosed [
	^ self assert
		label: 'Assert save already existing method disalog is closed';
		notExists;
		onPopover;
		// GtPharoMethodSaveExistingQuestionElement
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertSaveAlreadyExistingMethodDialogIsOpen [
	^ self assert
		label: 'Assert save already existing method disalog is open';
		exists;
		onPopover;
		// GtPharoMethodSaveExistingQuestionElement
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertSearchTextCurrentIndexIs: anIndex [
	^ self assert
		label: ('Assert found text index is: {1}' format: { anIndex });
		value: [ :anElement | anElement markerContext selectedIndex ] equals: anIndex;
		onPopover;
		// GtTextualCoderSearchTextElement
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertSearchTextDialogIsClosed [
	^ self assert
		label: 'Assert search text dialog is open';
		notExists;
		onPopover;
		// GtTextualCoderSearchTextElement
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertSearchTextDialogIsOpen [
	^ self assert
		label: 'Assert search text dialog is open';
		exists;
		onPopover;
		// GtTextualCoderSearchTextElement
]

{ #category : #'steps - checks' }
GtPharoMethodCoderStep >> assertSearchTextTotalCountIs: anIndex [
	^ self assert
		label: ('Assert found total items is: {1}' format: { anIndex });
		value: [ :anElement | anElement markerContext totalCount ] equals: anIndex;
		onPopover;
		// GtTextualCoderSearchTextElement
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
GtPharoMethodCoderStep >> browseBehavior [
	^ self shortcut
		label: 'Browse behavior';
		combination: BlKeyCombination primaryB;
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorInnerId;
		onTopMost
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> browseImplementors [
	^ self shortcut
		label: 'Browse implementors';
		combination: BlKeyCombination primaryM;
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorInnerId;
		onTopMost
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> browseSenders [
	^ self shortcut
		label: 'Browse senders';
		combination: BlKeyCombination primaryN;
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorInnerId;
		onTopMost
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> clickOnContinueCompilingExistingMethod [
	^ self click
		label: 'Click on continue compiling existing method';
		onPopover;
		// GtPharoMethodSaveExistingQuestionElement;
		// #confirm
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> clickOnHeaderMethodBehavior [
	| aClickStep |
	aClickStep := self click
			label: 'Click on header method behavior';
			referenceSender;
			// GtPharoHeaderMethodBehaviorId.

	^ aClickStep
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> clickOnHeaderProviderBehavior [
	| aClickStep |
	aClickStep := self click
			label: 'Click on header provider behavior';
			referenceSender;
			// GtPharoHeaderProviderBehaviorId.

	^ aClickStep
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> clickOnMethodCoderExpander: anExpanderIndex insideDo: anInsideBlock [
	| aRootStep |
	self click
		label: ('Click on expander number {1}' format: {anExpanderIndex});
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
			// GtPharoMethodPlayAndInspectActionId.
	^ aClickStep
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> clickOnPlayAndInspectExampleButton [
	| aClickStep |
	aClickStep := self click
			referenceSender;
			label: 'Click on play and inspect example button';
			// GtMethodCoderPlayAndInspectExampleActionId;
			onTopMost.
	^ aClickStep
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> clickOnPlayButton [
	| aClickStep |
	aClickStep := self click
			referenceSender;
			label: 'Click on play button';
			// GtSourceCoderDoItActionId.
	^ aClickStep
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> clickOnSaveButton [
	| aClickStep |
	aClickStep := self click
			referenceSender;
			label: 'Click on save button';
			// GtMethodCoderSaveActionId;
			onTopMost.
	^ aClickStep
]

{ #category : #'steps - accessing' }
GtPharoMethodCoderStep >> coderModelDo: aBlock [
	^ self do
		label: 'Access coder model';
		block: [ :anElement | aBlock cull: anElement textualCoderViewModel coderModel ];
		onParentStepTarget: self
]

{ #category : #'steps - accessing' }
GtPharoMethodCoderStep >> coderViewModelDo: aBlock [
	^ self do
		label: 'Access coder view model';
		block: [ :anElement | aBlock cull: anElement textualCoderViewModel ];
		onParentStepTarget: self
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> editorDo: aBlock [
	^ self do
		referenceSender;
		label: 'Access editor';
		block: aBlock;
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorId;
		onTopMost
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> editorTextDo: aBlock [
	^ self do
		referenceSender;
		label: 'Access editor text';
		block: [ :anEditor | aBlock cull: anEditor text ];
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorId;
		onTopMost
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> formatCode [
	^ self shortcut
		label: 'Format code';
		combination: BlKeyCombination primaryShiftF;
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorInnerId;
		onTopMost
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
GtPharoMethodCoderStep >> moveCursorToEnd [
	^ self do
		referenceSender;
		label: 'Move cursor to end';
		block: [ :anEditor | 
			anEditor navigator
				moveToEnd;
				apply ];
		onParentStepTarget: self;
		// GtSourceCoderEditorId;
		onTopMost
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> playAndInspect [
	^ self shortcut
		label: 'Play and inspect';
		combination: BlKeyCombination primaryG;
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorInnerId;
		onTopMost
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> printIt [
	^ self shortcut
		label: 'Print result';
		combination: BlKeyCombination primaryP;
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorInnerId;
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
GtPharoMethodCoderStep >> searchNext [
	^ self shortcut
		label: 'Search next text occurence';
		combination: BlKeyCombination return;
		onPopover;
		// GtTextualCoderSearchTextElement;
		// #pattern
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> searchPrevious [
	^ self shortcut
		label: 'Search previous text occurence';
		combination: BlKeyCombination primaryReturn;
		onPopover;
		// GtTextualCoderSearchTextElement;
		// #pattern
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> searchText [
	^ self shortcut
		label: 'Open search text dialog';
		combination: BlKeyCombination primaryF;
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorInnerId;
		onTopMost
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> searchTextClose [
	^ self shortcut
		label: 'Close search text dialog';
		combination: BlKeyCombination escape;
		onPopover;
		// GtTextualCoderSearchTextElement;
		// #pattern
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> searchType: aString [
	"The event is eventually handled in {{gtMethod:BrTextEditorInsertionHandler>>#textInputEvent:}}. 
	Note that all characters must be printable, otherwise the event is ignored."

	^ self type
		referenceSender;
		label: ('Search text: {1}' format: {aString lines first printStringLimitedTo: 30});
		text: aString;
		onPopover;
		// GtTextualCoderSearchTextElement;
		// #pattern
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
GtPharoMethodCoderStep >> selectAll [
	^ self shortcut
		label: 'Select all editor text';
		combination: BlKeyCombination primaryA;
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorInnerId;
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

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> typeText: aString [
	"The event is eventually handled in {{gtMethod:BrTextEditorInsertionHandler>>#textInputEvent:}}. 
	Note that all characters must be printable, otherwise the event is ignored."

	^ aString lines size = 1
		ifTrue: [ self type
				referenceSender;
				label: ('Type text: {1}' format: {aString lines first printStringLimitedTo: 30});
				text: aString;
				onParentStepTarget: self;
				onThisOrDeepChildElementId: GtSourceCoderEditorId;
				onTopMost ]
		ifFalse: [ self
				substeps2: 'Type lines'
				do: [ :eachStep | 
					aString lines
						do: [ :eachLine | 
							(Character tab split: eachLine)
								do: [ :eachPart | 
									eachStep type
										referenceSender;
										label: ('Type text: {1}' format: {aString lines first});
										text: eachPart;
										onParentStepTarget: eachStep;
										onThisOrDeepChildElementId: GtSourceCoderEditorId;
										onTopMost ]
								separatedBy: [ eachStep keyPress
										label: 'Press tab';
										key: BlKeyboardKey tab ] ]
						separatedBy: [ eachStep keyPress
								label: 'Press return';
								key: BlKeyboardKey return ] ] ]
]

{ #category : #'steps - interactions' }
GtPharoMethodCoderStep >> unfoldNoise [
	^ self shortcut
		label: 'Unfold Noise';
		combination: BlKeyCombinationBuilder new primary shift n build;
		onParentStepTarget: self;
		onThisOrDeepChildElementId: GtSourceCoderEditorId;
		onTopMost
]
