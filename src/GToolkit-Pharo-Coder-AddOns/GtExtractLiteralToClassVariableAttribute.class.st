Class {
	#name : #GtExtractLiteralToClassVariableAttribute,
	#superclass : #GtRefactoringAttribute,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #private }
GtExtractLiteralToClassVariableAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| element label |
	element := BrHorizontalPane new.
	element fitContent.
	element margin: (BlInsets all: 3).
	element
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
					aStyle background: element theme status neutralBackgroundColor.
					aStyle border: BlBorder empty ];
				hovered: [ :aStyle | aStyle background: element theme status neutralBackgroundColor darker ]).
	label := GtRenameEditor new.
	label
		aptitude: BrGlamorousEditableLabelAptitude new glamorousCodeFont glamorousRegularSmallSize.
	label text: refactoringController getterReceiver.
	label
		padding: (BlInsets
				top: 2
				left: 4
				bottom: 2
				right: 4).
	self setupHandlersFor: label in: anEditorElement.
	(GtCompletionController
		on: label
		strategy: (GtStreamedBlockCompletionStrategy new
				streamingBlock: [ :string | 
					(refactoringController potentialReceivers asyncStreamStartingWith: string)
						merge: (GtPharoIndex current classNameTree asyncWeightedStreamStartingWith: string) ]))
		install.
	label
		switchToEditor;
		requestFocus.
	focusOnFirstShow
		ifTrue: [ label
				enqueueTask: [ focusOnFirstShow := false.
					label requestFocus ] asBlTask ].
	element addChild: label as: #classEditor.
	^ element
]

{ #category : #initialization }
GtExtractLiteralToClassVariableAttribute >> initialize [
	super initialize.
	self beReplace
]

{ #category : #testing }
GtExtractLiteralToClassVariableAttribute >> isClassName: aSymbol [
	| name |
	name := aSymbol.
	^ (self class environment bindingOf: name asSymbol) value
		ifNil: [ false ]
		ifNotNil: [ :value | value isBehavior and: [ value name sameContentAs: name ] ]
]

{ #category : #private }
GtExtractLiteralToClassVariableAttribute >> setupHandlersFor: label in: anEditorElement [
	label
		whenKey: BlKeyCombination escape editorDo: [ :aShortcutEvent | self cancel ];
		whenKey: BlKeyCombination builder shift tab build
			editorDo: [ :aShortcutEvent | 
				self
					focusNext: false
					in: anEditorElement
					from: label ];
		whenKey: BlKeyCombination tab
			editorDo: [ :aShortcutEvent | 
				self
					focusNext: true
					in: anEditorElement
					from: label ];
		whenKey: BlKeyCombination enter
			editorDo: [ :aShortcutEvent | 
				self
					focusNext: true
					in: anEditorElement
					from: label ].

	label when: BrEditorCancelWish do: [ :event | self cancel ].

	label
		when: BrEditorAcceptWish
		do: [ :aWish | 
			| className |
			className := aWish text asString trim.
			refactoringController receiverClassName: className ].

	label
		whenKey: BlKeyCombination arrowRight
		editorDo: [ :aShortcutEvent | 
			| cursors editor |
			editor := aShortcutEvent source editor.
			cursors := editor cursors positions.
			(cursors includes: editor text size)
				ifTrue: [ aShortcutEvent
						consumed: (self
								focusNext: true
								in: anEditorElement
								from: label) ]
				ifFalse: [ cursors notEmpty
						ifTrue: [ editor selectNone.
							editor moveCursorTo: cursors first + 1 ] ] ].
	label
		whenKey: BlKeyCombination arrowLeft
		editorDo: [ :aShortcutEvent | 
			| cursors editor |
			editor := aShortcutEvent source editor.
			cursors := editor cursors positions.
			(cursors includes: 0)
				ifTrue: [ aShortcutEvent
						consumed: (self
								focusNext: false
								in: anEditorElement
								from: label) ]
				ifFalse: [ cursors notEmpty
						ifTrue: [ editor selectNone.
							editor moveCursorTo: cursors first - 1 ] ] ].
	label
		whenKey: BlKeyCombination arrowDown
		editorDo: [ :aShortcutEvent | 
			aShortcutEvent
				consumed: (self
						focusNext: true
						in: anEditorElement
						from: label) ].
	label
		whenKey: BlKeyCombination arrowUp
		editorDo: [ :aShortcutEvent | 
			aShortcutEvent
				consumed: (self
						focusNext: false
						in: anEditorElement
						from: label) ]
]
