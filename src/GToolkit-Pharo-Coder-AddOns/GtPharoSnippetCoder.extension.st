Extension { #name : #GtPharoSnippetCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addConvertCascadesToStatementsFor: aNode to: coderAddOns [
	aNode isCascade ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Convert cascade to statements'
				description: (self nodeDescription: aNode))
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtSnippetConvertCascadesToStatementsController new
				node: aNode;
				sourceCoderViewModel: aCoderViewModel) executeIn: element ]
		id: #'context-menu--cascades-to-statements'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addConvertStatementsToCascadesFor: nodes to: coderAddOns [
	nodes size > 1 ifFalse: [ ^ self ].
	(nodes allSatisfy: [ :each | each isMessageSend ]) ifFalse: [ ^ self ].
	(nodes allSatisfy: [ :each | each receiver = nodes first receiver ])
		ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Convert statements to cascade'
				description: (self nodeDescription: nodes first))
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodesBlock: nodes)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtSnippetConvertStatementsToCascadesController new
				nodes: nodes;
				sourceCoderViewModel: aCoderViewModel) executeIn: element ]
		id: #'context-menu--statements-to-cascade'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addExtractTestContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	"<gtCoderContextMenuAddOns: 220>"

	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :nodes | 
			coderAddOns
				addContextMenuItem: 'Extract test'
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: nodes first startPosition
						to: nodes last stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel :element | 
					(GtExtractTestFromSnippetController new sourceCoderViewModel: aTextualViewModel)
						executeIn: element ]
				id: #'snippet-extract-test' ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addExtractVariableFor: aNode to: coderAddOns [
	(aNode isValueNode and: [ aNode isVariable not ]) ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Extract variable'
				description: (self nodeDescription: aNode))
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtSnippetExtractTemporaryRefactoringController new
				node: aNode;
				sourceCoderViewModel: aCoderViewModel) executeIn: element ]
		id: #'context-menu--extract-variable'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addInlineMethodFor: aNode to: coderAddOns from: aCoderViewModel [
	| class selector |
	aNode isMessageSend ifFalse: [ ^ false ].
	selector := aNode selector.
	class := aNode receiver isSuper
			ifTrue: [ self behavior ]
			ifFalse: [ GtPharoProgramNode
					typeOf: aNode receiver
					in: self behavior
					bindings: aCoderViewModel compositeVariableBindings ].
	class isNil
		ifTrue: [ Smalltalk globals
				allBehaviorsDo: [ :each | 
					(each includesSelector: selector)
						ifTrue: [ class notNil ifTrue: [ ^ self ].
							class := each ] ] ].
	class isNil ifTrue: [ ^ self ].
	class := class whichClassIncludesSelector: selector.
	class isNil ifTrue: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline send'
				description: aNode selector)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :each :element | 
			(GtSnippetInlineMessageRefactoringController new
				messageNode: aNode;
				implementorClass: class;
				snippetClass: self behavior;
				sourceCoderViewModel: each) executeIn: element ]
		id: #'context-menu--inline-send'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addInlineTempFor: aNode to: coderAddOns [
	| variable uses |
	aNode isAssignment ifTrue: [ variable := aNode variable ].
	aNode isVariable
		ifTrue: [ (aNode parent isAssignment and: [ aNode parent variable == aNode ])
				ifTrue: [ ^ self ].
			variable := aNode ].
	variable isNil ifTrue: [ ^ self ].
	uses := self allReferencesTo: variable.
	uses size < 2 ifTrue: [ ^ self ].
	uses first isAssignedTo ifFalse: [ ^ self ].
	2 to: uses size do: [ :i | (uses at: i) isAssignedTo ifTrue: [ ^ self ] ].
	uses size >= 2
		ifTrue: [ uses first stopPosition > uses second startPosition ifTrue: [ ^ self ] ].

	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline assignment'
				description: variable variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodesBlock: {uses first parent} , uses)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel :element | 
			(GtSnippetInlineVariableRefactoringController new
				node: uses first parent;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--inline-temp'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addRefactoringContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 210>
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :nodes | 
			| node |
			coderAddOns
				addContextMenuItem: 'Extract method'
				group: BrMenuItemGroupConfiguration refactoring
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: nodes first startPosition
						to: nodes last stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel :element | 
					(GtExtractMethodFromSnippetController new
						sourceCoderViewModel: aTextualViewModel) executeIn: element ]
				id: GtMethodCoderExtractMethodContextMenuItemId.

			coderAddOns
				addContextMenuItem: 'Extract example'
				group: BrMenuItemGroupConfiguration refactoring
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: nodes first startPosition
						to: nodes last stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel :element | 
					(GtExtractExampleFromSnippetController new
						sourceCoderViewModel: aTextualViewModel) executeIn: element ]
				id: #'snippet-extract-example'.

			node := nodes first.
			node
				withAllParentsDo: [ :aNode | self addExtractVariableFor: aNode to: coderAddOns ].
			self
				addInlineMethodFor: node
				to: coderAddOns
				from: aCoderViewModel.
			node withAllParentsDo: [ :n | self addInlineTempFor: n to: coderAddOns ].
			node
				withAllParentsDo: [ :n | self addConvertCascadesToStatementsFor: n to: coderAddOns ].
			self addConvertStatementsToCascadesFor: nodes to: coderAddOns ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> initializeAddOns: addOns [

	super initializeAddOns: addOns.

	addOns addStyler: (GtMethodAdviceStyler new isForWorkspace: true).

	addOns
		addMainAction: 'Evaluate' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doIt
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItActionId.
	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doItAndGo
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.
	addOns
		addMainAction: 'Debug' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :aCoderUIModel :anElement | aCoderUIModel debug ]
		id: GtSourceCoderDebugActionId.
	addOns
		addMainAction: 'Profile' translated
		icon: BrGlamorousVectorIcons performance
		action: [ :aCoderUIModel :anElement | 
			aCoderUIModel profileWithMessageTally ]
		id: GtSourceCoderProfileActionId
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> initializeAddOns: addOns viewModel: aViewModel [
	| action toggleModel |
	super initializeAddOns: addOns viewModel: aViewModel.
	toggleModel := aViewModel variableValueToggleModel.
	toggleModel ifNil: [^self].
	toggleModel
		when: BrToggleActivatedEvent
			do: [ :anEvent | 
				aViewModel
					addStyler: (GtContextVariableValueStyler new coderViewModel: aViewModel).
				aViewModel requestUpdateAddOns ];
		when: BrToggleDeactivatedEvent
			do: [ :anEvent | 
				aViewModel removeStylersOfClass: GtContextVariableValueStyler.
				aViewModel requestUpdateAddOns ].

	action := GtCoderToggleAction new
			title: 'Variable Values' translated;
			icon: BrGlamorousVectorIcons edit;
			toggleModel: toggleModel;
			activateBlock: [ :anEvent | toggleModel activate ];
			deactivateBlock: [ :anEvent | toggleModel deactivate ];
			id: GtPharoCoderVariableValuesActionId.

	addOns
		updateActionList: #mainActions
		withAction: action
		onlyNew: true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderDoItShortcut new;
		addShortcut: GtSourceCoderDoItAndInspectShortcut new;
		addShortcut: GtSnippetCoderExtractMethodShortcut new
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> isLocalVariable: aNode [
	^ aNode isLocallyDefined
		or:
			[ (self behavior allInstVarNames includes: aNode name source)
				or:
					[ (self behavior classVariables anySatisfy: [ :assoc | assoc key asString = aNode name source ])
						or: [ (Smalltalk globals includesKey: aNode name source asSymbol) not ] ] ]
]
