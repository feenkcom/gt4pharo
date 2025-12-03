Class {
	#name : #GtMessageReceiverAttribute,
	#superclass : #GtRefactoringDropDownAttribute,
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtMessageReceiverAttribute >> buttonId [
	^ #receiverDropDown
]

{ #category : #accessing }
GtMessageReceiverAttribute >> buttonLabel [
	^ refactoringController receiver
]

{ #category : #accessing }
GtMessageReceiverAttribute >> createEditableLabelIn: anEditorElement [
	| label |
	label := GtRenameEditor new.
	label
		aptitude: BrGlamorousEditableLabelAptitude new glamorousCodeFont glamorousRegularSmallSize.
	label text: refactoringController receiverClassName.
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
					((refactoringController potentialTypes asyncStreamStartingWith: string)
						merge: ((GtPharoIndex current classNameTree asyncWeightedStreamStartingWith: string)
								collect: [ :each | 
									{each.
										each , ' class'} asAsyncStream ]) flatten) withoutDuplicates ]))
		install.
	label
		switchToEditor;
		requestFocus.
	^ label
]

{ #category : #accessing }
GtMessageReceiverAttribute >> currentSelection [
	^ refactoringController receiver
]

{ #category : #accessing }
GtMessageReceiverAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| element |
	element := super doAffect: aTBrTextEditorTextualPiece in: anEditorElement.
	refactoringController showReceiverType
		ifTrue: [ element
				addChild: (self createEditableLabelIn: anEditorElement)
				as: #editableLabel ].
	^ element
]

{ #category : #initialization }
GtMessageReceiverAttribute >> initialize [
	super initialize.
	self focusOnFirstShow: false
]

{ #category : #testing }
GtMessageReceiverAttribute >> isClassName: aSymbol [
	| name |
	name := aSymbol.
	(name endsWith: ' class') ifTrue: [ name := name allButLast: 6 ].
	^ (self class environment bindingOf: name asSymbol) value
		ifNil: [ false ]
		ifNotNil: [ :value | value isBehavior and: [ value name sameContentAs: name ] ]
]

{ #category : #'as yet unclassified' }
GtMessageReceiverAttribute >> listId [
	^ #receiverList
]

{ #category : #accessing }
GtMessageReceiverAttribute >> receivers [
	^ self items
]

{ #category : #accessing }
GtMessageReceiverAttribute >> receivers: aCollection [
	self items: aCollection
]

{ #category : #private }
GtMessageReceiverAttribute >> select: anObject [
	refactoringController receiver: anObject
]

{ #category : #accessing }
GtMessageReceiverAttribute >> setupHandlersFor: label in: anEditorElement [
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
			(self isClassName: className)
				ifTrue: [ refactoringController receiverClassName: className ] ].

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
