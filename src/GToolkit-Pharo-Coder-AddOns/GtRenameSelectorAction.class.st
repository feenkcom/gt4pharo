Class {
	#name : #GtRenameSelectorAction,
	#superclass : #GtCoderViewModelRenameAction,
	#instVars : [
		'newSelector',
		'styler',
		'focusedIndex',
		'hasArguments',
		'completionStrategy',
		'highlighted'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtRenameSelectorAction class >> message: aGtPharoMessageNode textualCoderViewModel: aTextualCoderViewModel [
	^ self new
		message: aGtPharoMessageNode;
		pharoSourceCoderViewModel: aTextualCoderViewModel;
		yourself
]

{ #category : #accessing }
GtRenameSelectorAction class >> selector: aGtPharoLiteralNode textualCoderViewModel: aTextualCoderViewModel [
	^ self new
		selector: aGtPharoLiteralNode;
		pharoSourceCoderViewModel: aTextualCoderViewModel;
		yourself
]

{ #category : #accessing }
GtRenameSelectorAction class >> variable: aGtPharoVariableNode textualCoderViewModel: aTextualCoderViewModel [
	^ self new
		variable: aGtPharoVariableNode;
		pharoSourceCoderViewModel: aTextualCoderViewModel;
		yourself
]

{ #category : #accessing }
GtRenameSelectorAction >> addRenameAttributes [
	| text index |
	text := self pharoSourceCoderViewModel styledText
			ifNil: [ self pharoSourceCoderViewModel sourceText ].

	index := 1.
	coderAttributes := originalLocations
			collect: [ :each | 
				| attribute |
				attribute := GtRenameSelectorEditorAttribute new
						action: self;
						selectAll: selectAll;
						filter: filter;
						text: (self removeHighlightFrom: (text from: each first to: each last));
						requestInitialFocus: index = focusedIndex;
						focusedIndex: index;
						coordinateFocus: true;
						styler: styler;
						completionStrategy: completionStrategy.
				index := index + 1.

				self pharoSourceCoderViewModel
					addTextAttribute: attribute
					from: each first
					to: each last ].

	renameAttributes := coderAttributes
			flatCollect: [ :eachCoderAttribute | eachCoderAttribute textAttributes ].

	newSelector
		ifNotNil: [ newSelector keywords
				with: renameAttributes
				do: [ :each :attr | 
					attr
						text: (each last = $: ifTrue: [ each allButLast ] ifFalse: [ each ]) asRopedText ] ]
]

{ #category : #accessing }
GtRenameSelectorAction >> completionStrategy [
	^ completionStrategy
]

{ #category : #accessing }
GtRenameSelectorAction >> completionStrategy: anObject [
	completionStrategy := anObject
]

{ #category : #accessing }
GtRenameSelectorAction >> focusedIndex [
	^ focusedIndex
]

{ #category : #accessing }
GtRenameSelectorAction >> focusedIndex: anInteger [
	focusedIndex := anInteger.
	self announce: (GtRenameSelectorKeywordFocused new keyword: anInteger)
]

{ #category : #accessing }
GtRenameSelectorAction >> forBinaryOrKeyword [
	validationBlock := [ :str | 
		(self validateKeyword: str)
			or: [ (self validateBinary: str) or: [ self validateVariable: str ] ] ].
	styler := GtSelectorStyler new forBinaryOrKeyword.
	filter := GtSelectorInputFilter forBinaryOrKeywordMessage
]

{ #category : #accessing }
GtRenameSelectorAction >> forKeyword [
	validationBlock := [ :str | (self validateKeyword: str) or: [ self validateVariable: str ] ].
	styler := GtSelectorStyler new forKeyword.
	filter := GtSelectorInputFilter forKeywordMessage
]

{ #category : #accessing }
GtRenameSelectorAction >> forVariableOrUnaryMessage [
	super forVariableOrUnaryMessage.
	styler := GtSelectorStyler new forUnary.
	filter := GtSelectorInputFilter forUnaryMessage
]

{ #category : #accessing }
GtRenameSelectorAction >> highlighted [
	^ highlighted
]

{ #category : #accessing }
GtRenameSelectorAction >> highlighted: anInteger [
	highlighted := anInteger.
	renameAttributes
		ifNotNil: [ renameAttributes doWithIndex: [ :each :i | each highlight: i = anInteger ] ]
]

{ #category : #accessing }
GtRenameSelectorAction >> initialize [
	super initialize.
	allowAccept := false.
	focusedIndex := 1.
	highlighted := 0.
	self hasRefactoringPreview: true
]

{ #category : #accessing }
GtRenameSelectorAction >> isValid [
	validationBlock isNil ifTrue: [ ^ true ].
	^ renameAttributes
		allSatisfy: [ :each | validationBlock value: each text asString ]
]

{ #category : #accessing }
GtRenameSelectorAction >> message: aGtPharoMessageNode [
	originalLocations := aGtPharoMessageNode selectorParts
			collect: [ :each | each sourceInterval ].
	hasArguments := aGtPharoMessageNode arguments notEmpty.
	hasArguments
		ifTrue: [ aGtPharoMessageNode arguments size = 1
				ifTrue: [ self forBinaryOrKeyword ]
				ifFalse: [ self forKeyword ] ]
		ifFalse: [ self forVariableOrUnaryMessage ]
]

{ #category : #accessing }
GtRenameSelectorAction >> newSelector [
	^ renameAttributes
		ifNil: [ newSelector ]
		ifNotNil: [ (String
				streamContents: [ :stream | 
					renameAttributes
						do: [ :each | 
							| selector |
							selector := each text asString.
							stream nextPutAll: selector.
							(hasArguments and: [ selector numArgs < 1 ])
								ifTrue: [ stream nextPut: $: ] ] ]) asSymbol ]
]

{ #category : #accessing }
GtRenameSelectorAction >> newSelector: aSymbol [
	newSelector := aSymbol
]

{ #category : #accessing }
GtRenameSelectorAction >> newVariableName [
	^ self newSelector
]

{ #category : #accessing }
GtRenameSelectorAction >> removeHighlightFrom: aText [
	^ aText asRopedText copy
		clearAttributes: [ :each | each class = BlTextHighlightAttribute ]
]

{ #category : #accessing }
GtRenameSelectorAction >> selector: aGtPharoLiteralNode [
	| interval |
	interval := aGtPharoLiteralNode sourceInterval.
	aGtPharoLiteralNode value source first = $#
		ifTrue: [ interval := interval first + 1 to: interval last ].
	originalLocations := {interval}.
	hasArguments := false.
	self forVariableOrUnaryMessage
]

{ #category : #'as yet unclassified' }
GtRenameSelectorAction >> swapKeywordWithNext: anInteger [
	| text |
	text := (renameAttributes at: anInteger) text copy.
	(renameAttributes at: anInteger)
		text: (renameAttributes at: anInteger + 1) text copy.
	(renameAttributes at: anInteger + 1) text: text
]

{ #category : #accessing }
GtRenameSelectorAction >> tabAccept: forward [
]

{ #category : #accessing }
GtRenameSelectorAction >> updateName: blText [
	self announceEvent: #textUpdated
]

{ #category : #accessing }
GtRenameSelectorAction >> variable: aGtPharoVariableNode [
	originalLocations := {aGtPharoVariableNode sourceInterval}.
	hasArguments := false.
	self forVariableOrUnaryMessage
]
