Class {
	#name : #GtRenameSelectorAction,
	#superclass : #GtCoderViewModelRenameAction,
	#instVars : [
		'message',
		'newSelector',
		'styler',
		'focusedIndex'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtRenameSelectorAction class >> message: aGtPharoMessageNode textualCoderViewModel: aTextualCoderViewModel [
	^ self new
		message: aGtPharoMessageNode;
		pharoSourceCoderViewModel: aTextualCoderViewModel;
		yourself
]

{ #category : #accessing }
GtRenameSelectorAction >> accept [
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
				attribute := GtRenameEditorAttribute new
						action: self;
						selectAll: selectAll;
						filter: filter;
						text: (text from: each first to: each last);
						requestInitialFocus: index = focusedIndex;
						coordinateFocus: true;
						styler: styler.
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
GtRenameSelectorAction >> focusedIndex [
	^ focusedIndex
]

{ #category : #accessing }
GtRenameSelectorAction >> focusedIndex: anInteger [
	focusedIndex := anInteger
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
GtRenameSelectorAction >> initialize [
	super initialize.
	focusedIndex := 1.
	self hasRefactoringPreview: true
]

{ #category : #accessing }
GtRenameSelectorAction >> isValid [
	validationBlock isNil ifTrue: [ ^ true ].
	^ renameAttributes
		allSatisfy: [ :each | validationBlock value: each text asString ]
]

{ #category : #accessing }
GtRenameSelectorAction >> message [
	^ message
]

{ #category : #accessing }
GtRenameSelectorAction >> message: aGtPharoMessageNode [
	message := aGtPharoMessageNode.
	originalLocations := message selectorParts
			collect: [ :each | each sourceInterval ].
	message arguments isEmpty
		ifTrue: [ self forVariableOrUnaryMessage ]
		ifFalse: [ message arguments size = 1
				ifTrue: [ self forBinaryOrKeyword ]
				ifFalse: [ self forKeyword ] ]
]

{ #category : #accessing }
GtRenameSelectorAction >> newSelector [
	^ renameAttributes
		ifNil: [ newSelector ]
		ifNotNil: [ | hasArguments |
			hasArguments := message arguments size > 0.
			(String
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
GtRenameSelectorAction >> tabAccept: forward [
]

{ #category : #accessing }
GtRenameSelectorAction >> updateName: blText [
	self announceEvent: #textUpdated
]
