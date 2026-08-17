"
I explore whether `BrTextEditorModel>>#addHighlight:overMarker:` can safely enable `beNotOverwritableByStyler`, the way `#addHighlight:overRange:` already does.

`GtMethodAdvice>>#styleFixIt:using:` attaches a cursor-enter/leave handler over a fix-it marker: entering calls `#addHighlight:overMarker:`, leaving calls `#removeHighlightsWithId:`. As the user keeps typing, the styler recomputes the whole AST and replaces the marker + handler with fresh instances; the *old* handler is simply discarded rather than properly ""left"", so its highlight is never explicitly removed. Today that highlight is still cleared because the styler wipes every attribute it does not recognise as `beNotOverwritableByStyler` before reapplying. If `beNotOverwritableByStyler` were enabled there too (matching `#addHighlight:overRange:`), that highlight would survive the wipe and become orphaned: still painted, no longer backed by a live marker or fix-it button.

My examples reproduce this with a `#'method1'` body edited to contain an extra period (`self..`), which `GtUnnecessaryPeriodAdvice` flags with a fix-it. `#debuggerAfterTypingExtraPeriod` establishes the baseline. `#noLeakedHighlightAfterFurtherTyping` continues typing unrelated text and confirms today's behaviour leaves no orphaned highlight. `#leakedHighlightWhenOverMarkerHighlightNotOverwritableByStyler` temporarily patches the flag on (restoring the original method afterwards) and demonstrates the orphaned highlight the comment on `#addHighlight:overMarker:` warns about.
"
Class {
	#name : #GtScripterCoderAdviceHighlightOverMarkerStylerExamples,
	#superclass : #Object,
	#traits : 'TGtScripterDebuggerExamples',
	#classTraits : 'TGtScripterDebuggerExamples classTrait',
	#category : #'GToolkit-Pharo-Coder-Examples-Examples'
}

{ #category : #'examples - support' }
GtScripterCoderAdviceHighlightOverMarkerStylerExamples >> assertAttribute: anAttributeClass presentAt: aPosition in: aBrText [
	<return: #Boolean>
	^ (aBrText attributesAt: aPosition)
		anySatisfy: [ :each | each isKindOf: anAttributeClass ]
]

{ #category : #'examples - support' }
GtScripterCoderAdviceHighlightOverMarkerStylerExamples >> assertHighlightAttribute: anId presentAt: aPosition in: aBrText [
	<return: #Boolean>
	^ (aBrText attributesAt: aPosition)
		anySatisfy: [ :each | (each isKindOf: BlTextHighlightAttribute) and: [ each id = anId ] ]
]

{ #category : #examples }
GtScripterCoderAdviceHighlightOverMarkerStylerExamples >> debuggerAfterTypingExtraPeriod [
	"Open a debugger stopped in #method1, replace its body with 'self..' (an extra
	period after the sole statement), and confirm GtUnnecessaryPeriodAdvice's fix-it
	marker and its error highlight both land on the same, last character — the extra
	period itself. This is the sane baseline the other examples build on."

	<gtExample>
	<return: #BlScripter>
	| environment realClass debuggerElement scripter editorText lastPosition |
	environment := self dummyClassForAdviceHighlightExample.
	realClass := environment anyDummyClass realClass.

	debuggerElement := self
			debuggerOn: [ realClass new method1 ]
			stoppingAt: [ :context | context selector = #method1 ].

	scripter := BlScripter new.
	scripter element: debuggerElement.
	scripter userData at: #environment put: environment.

	scripter do
		label: 'Set window size';
		block: [ :aSpace | aSpace extent: 1000 @ 700 ];
		onSpace;
		play.

	scripter methodCoder
		label: 'Replace the method body with an extra period';
		selectAll;
		typeText: 'method1
	self..';
		// (GtExpandableContextMethodCoderId indexed: 1);
		play.

	scripter assert
		label: 'The fix-it marker and the error highlight are both on the extra period';
		satisfies: [ :aDebuggerElement |
			editorText := (aDebuggerElement allChildrenBreadthFirstSelect: [ :each | each isKindOf: BrEditor ])
				first text.
			lastPosition := editorText size.
			(self assertAttribute: GtFixItMarkerAttribute presentAt: lastPosition in: editorText)
				and: [ self assertHighlightAttribute: #'advice--error' presentAt: lastPosition in: editorText ] ];
		play.

	^ scripter
]

{ #category : #'examples - support' }
GtScripterCoderAdviceHighlightOverMarkerStylerExamples >> dummyClassForAdviceHighlightExample [
	"Answer a dummy class holding a placeholder #method1 to stop a debugger in.
	The returned environment removes the class from the system again."

	<return: #GtPharoDummyEnvironment>
	| environment realClass |
	environment := GtPharoDummiesGenerator withPackages: 1 classes: 1.
	realClass := environment anyDummyClass realClass.

	GtPharoCodeModifier current
		compileMethodSource: 'method1
	1 + 1'
		in: realClass
		protocol: 'examples'.

	^ environment
]

{ #category : #examples }
GtScripterCoderAdviceHighlightOverMarkerStylerExamples >> leakedHighlightWhenOverMarkerHighlightNotOverwritableByStyler [
	"Temporarily enable beNotOverwritableByStyler in
	BrTextEditorModel>>#addHighlight:overMarker: (restoring the original method
	afterwards, whether this example passes or fails) and repeat the exact same
	recipe as #noLeakedHighlightAfterFurtherTyping. This time the error highlight
	survives the restyle that wipes its own marker and fix-it button, leaking onto
	the unrelated text typed afterwards — reproducing what Note 1 on
	#addHighlight:overMarker: warns about.
	See https://github.com/feenkcom/gtoolkit/issues/5158"

	<gtExample>
	<return: #BlScripter>
	| originalMethod originalSource patchedSource scripter editorText leaked |
	originalMethod := BrTextEditorModel >> #addHighlight:overMarker:.
	originalSource := originalMethod sourceCode.
	patchedSource := originalSource
		copyReplaceAll: '"beNotOverwritableByStyler"'
		with: 'beNotOverwritableByStyler'.
	self assert: patchedSource ~= originalSource.

	^ [ GtPharoCodeModifier current
			compileMethodSource: patchedSource
			in: BrTextEditorModel
			protocol: originalMethod protocol.

		scripter := self debuggerAfterTypingExtraPeriod.

		scripter methodCoder
			label: 'Type more, unrelated to the extra period';
			typeText: ' self';
			// (GtExpandableContextMethodCoderId indexed: 1);
			play.

		scripter assert
			label: 'The error highlight leaked onto text that has no fix-it of its own';
			satisfies: [ :aDebuggerElement |
				editorText := (aDebuggerElement allChildrenBreadthFirstSelect: [ :each | each isKindOf: BrEditor ])
					first text.
				leaked := self
					positionsWithLeakedHighlight: #'advice--error'
					markerAttributeClass: GtFixItMarkerAttribute
					in: editorText.
				leaked isNotEmpty ];
			play.

		scripter ]
		ensure: [
			GtPharoCodeModifier current
				compileMethodSource: originalSource
				in: BrTextEditorModel
				protocol: originalMethod protocol ]
]

{ #category : #examples }
GtScripterCoderAdviceHighlightOverMarkerStylerExamples >> noLeakedHighlightAfterFurtherTyping [
	"Continue typing unrelated content right after the extra period and confirm today's
	behaviour (beNotOverwritableByStyler commented out in #addHighlight:overMarker:)
	leaves no orphaned highlight: every restyle correctly wipes the stale highlight along
	with its stale marker."

	<gtExample>
	<return: #BlScripter>
	| scripter editorText leaked |
	scripter := self debuggerAfterTypingExtraPeriod.

	scripter methodCoder
		label: 'Type more, unrelated to the extra period';
		typeText: ' self';
		// (GtExpandableContextMethodCoderId indexed: 1);
		play.

	scripter assert
		label: 'No leaked highlight: the styler correctly cleared the stale highlight';
		satisfies: [ :aDebuggerElement |
			editorText := (aDebuggerElement allChildrenBreadthFirstSelect: [ :each | each isKindOf: BrEditor ])
				first text.
			leaked := self
				positionsWithLeakedHighlight: #'advice--error'
				markerAttributeClass: GtFixItMarkerAttribute
				in: editorText.
			leaked isEmpty ];
		play.

	^ scripter
]

{ #category : #'examples - support' }
GtScripterCoderAdviceHighlightOverMarkerStylerExamples >> positionsWithLeakedHighlight: anId markerAttributeClass: aMarkerAttributeClass in: aBrText [
	"Answer the positions that carry the highlight with id anId but no live marker of
	aMarkerAttributeClass at the same position — i.e. an orphaned, leaked highlight."

	<return: #Collection of: #Integer>
	| leaked |
	leaked := OrderedCollection new.
	1 to: aBrText size do: [ :aPosition |
		((self assertHighlightAttribute: anId presentAt: aPosition in: aBrText)
			and: [ (self assertAttribute: aMarkerAttributeClass presentAt: aPosition in: aBrText) not ])
			ifTrue: [ leaked add: aPosition ] ].
	^ leaked
]
