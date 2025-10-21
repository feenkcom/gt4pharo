Extension { #name : #GtPharoBehaviorDefinitionSnippetCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> addEvaluateAddonsTo: anAst to: coderAddOns [
	<gtCoderContextMenuAddOns>
	(self
		addContextMenuItemFrom: GtSourceCoderCompileItShortcut new
		group: BrMenuItemGroupConfiguration evaluation
		withId: GtSourceCoderDoItActionId
		to: coderAddOns) ifNotNil: [ :anAction | anAction priority: 800 ].
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoBehaviorDefinitionSnippetCoder >> addRenameMethodAst: anAst to: coderAddOns from: aCoderViewModel [
	"Disable addOns"

	<gtCoderContextMenuAddOns>
	^ self
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

	addOns addShortcut: GtSourceCoderCompileItShortcut new
]
