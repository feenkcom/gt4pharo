Extension { #name : #GtPharoBehaviorDefinitionSnippetCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> addEvaluateAddonsTo: anAst to: coderAddOns [
	<gtCoderContextMenuAddOns>
	(self
		addContextMenuItemFrom: GtSourceCoderCompileItShortcut new
		group: (BrMenuItemGroupConfiguration evaluation priority: 1)
		withId: GtSourceCoderDoItActionId
		to: coderAddOns) ifNotNil: [ :anAction | anAction priority: 1 ].
		
	(self
		addContextMenuItemFrom: GtSourceCoderDiscardChangesShortcut new
		group: BrMenuItemGroupConfiguration editing
		withId: nil
		to: coderAddOns) ifNotNil: [ :anAction | anAction priority: 1 ].
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> addRenameMethodAst: anAst to: coderAddOns from: aCoderViewModel [
	"Disable addOns"

	<gtCoderContextMenuAddOns>
	^ self
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> copyClassDefinitionSnippetFor: anAST into: coderAddOns viewModel: aCoderViewModel [
	<gtAstCoderAddOns: 2>
	self isModified
		ifTrue: [ ^ self ].

	coderAddOns
		addMainAction: 'Copy class definition snippet' translated
		icon: BrGlamorousVectorIcons clipboard
		action: [ :aCoderUIModel :anElement | 
			self onCopyClassDefinitionSnippetFrom: anElement ]
		id: GtMethodCoderDiscardChangesActionId
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> initializeAddOns: addOns [

	super initializeAddOns: addOns.

	addOns addStyler: (GtMethodAdviceStyler new isForWorkspace: true).

	addOns
		addMainAction: 'Save' translated
		icon: BrGlamorousVectorIcons accept
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor compileIt
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItActionId.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> initializeAddOns: addOns viewModel: aViewModel [
	super initializeAddOns: addOns viewModel: aViewModel.

	self initializeSearchTextAddOns: addOns viewModel: aViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderCompileItShortcut new;
		addShortcut: GtSourceCoderDiscardChangesShortcut new
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> modifiedMessageAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 2>

	self isModified
		ifFalse: [ ^ self ].

	coderAddOns
		addMainAction: 'Discard changes' translated
		icon: BrGlamorousVectorIcons cancel
		action: [ :aCoderUIModel :anElement | aCoderUIModel discardChanges ]
		id: GtMethodCoderDiscardChangesActionId
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> onCopyClassDefinitionSnippetFrom: anElement [
	| aString |
	behavior ifNil: [ ^ self ].

	aString := self
			forPharo12AndNewer: [ '({1}) install' format: {behavior definitionString} ]
			forPharo11: [ behavior definitionString ].
			
	Clipboard clipboardText: aString
]
