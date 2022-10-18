Class {
	#name : #GtRenameSelectorAction,
	#superclass : #GtCoderViewModelRenameAction,
	#instVars : [
		'message',
		'newSelector'
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
	| text first |
	text := self pharoSourceCoderViewModel styledText
			ifNil: [ self pharoSourceCoderViewModel sourceText ].

	first := true.
	coderAttributes := originalLocations
			collect: [ :each | 
				| attribute |
				attribute := GtRenameEditorAttribute new
						action: self;
						selectAll: selectAll;
						filter: filter;
						text: (text from: each first to: each last);
						requestInitialFocus: first;
						isForSelector: true.
				first := false.

				self pharoSourceCoderViewModel
					addTextAttribute: attribute
					from: each first
					to: each last ].

	renameAttributes := coderAttributes
			flatCollect: [ :eachCoderAttribute | eachCoderAttribute textAttributes ].

	newSelector
		ifNotNil: [ newSelector keywords
				with: renameAttributes
				do: [ :each :attr | attr text: each asRopedText ] ]
]

{ #category : #accessing }
GtRenameSelectorAction >> isValid [
	validationBlock isNil ifTrue: [ ^ true ].
	^ renameAttributes
		allSatisfy: [ :each | validationBlock value: each text asString ]
]

{ #category : #accessing }
GtRenameSelectorAction >> lostFocus [
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
		ifNotNil: [ (String
				streamContents: [ :stream | renameAttributes do: [ :each | stream nextPutAll: each text asString ] ])
				asSymbol ]
]

{ #category : #accessing }
GtRenameSelectorAction >> newSelector: anObject [

	newSelector := anObject
]

{ #category : #accessing }
GtRenameSelectorAction >> tabAccept: forward [
]

{ #category : #accessing }
GtRenameSelectorAction >> updateName: blText [
	self announceEvent: #textUpdated
]
