Extension { #name : #GtPharoSnippetCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addConvertCascadesToStatementsFor: aNode to: coderAddOns [
	aNode isCascade ifFalse: [ ^ false ].
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
		id: #'context-menu--cascades-to-statements'.
	^ true
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
	(aNode isValueNode and: [ aNode isVariable not ]) ifFalse: [ ^ false ].
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
		id: #'context-menu--extract-variable'.
	^ true
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
	class
		ifNil: [ ^ self
				addInlineMethodUnknownReceiverFor: aNode
				to: coderAddOns
				from: aCoderViewModel ].
	class := class whichClassIncludesSelector: selector.
	class
		ifNil: [ (GtPharoIndex current implementersOf: aNode selector) ifEmpty: [ ^ false ] ].

	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline message'
				description: aNode message selector)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel :element | 
			(GtSnippetInlineMessageRefactoringController new
				messageNode: aNode;
				implementorClass: class;
				snippetClass: self behavior;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--inline-send'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addInlineMethodUnknownReceiverFor: aNode to: coderAddOns from: aCoderViewModel [
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline message'
				description: aNode message selector)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel :element | 
			| classes defaultClass |
			classes := GtPharoIndex current implementersOf: aNode selector.
			defaultClass := classes anyOne methodClass.
			(GtSnippetUnknownReceiverInlineMessageRefactoringController new
				implementor: defaultClass;
				node: aNode;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--inline-message'.
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addInlineTempFor: aNode to: coderAddOns [
	| variable uses |
	aNode isAssignment ifTrue: [ variable := aNode variable ].
	aNode isVariable
		ifTrue: [ (aNode parent isAssignment and: [ aNode parent variable == aNode ])
				ifTrue: [ ^ false ].
			variable := aNode ].
	variable isNil ifTrue: [ ^ false ].
	uses := self allReferencesTo: variable.
	uses first isDeclaration ifTrue: [ uses removeFirst ].
	uses size < 2 ifTrue: [ ^ false ].
	uses first isAssignedTo ifFalse: [ ^ false ].
	2 to: uses size do: [ :i | (uses at: i) isAssignedTo ifTrue: [ ^ false ] ].
	uses size >= 2
		ifTrue: [ uses first stopPosition > uses second startPosition ifTrue: [ ^ false ] ].

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
		id: #'context-menu--inline-temp'.
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addRefactoringContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 210>
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :nodes | 
			| node allParents |
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
			allParents := node withAllParents.
			allParents
				detect: [ :aNode | self addExtractVariableFor: aNode to: coderAddOns ]
				ifNone: [  ].
			self
				addInlineMethodFor: node
				to: coderAddOns
				from: aCoderViewModel.
			allParents
				detect: [ :n | self addInlineTempFor: n to: coderAddOns ]
				ifNone: [  ].
			allParents
				detect: [ :n | self addConvertCascadesToStatementsFor: n to: coderAddOns ]
				ifNone: [  ].
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
		onlyNew: true.
	
	self initializeSearchTextAddOns: addOns viewModel: aViewModel
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
