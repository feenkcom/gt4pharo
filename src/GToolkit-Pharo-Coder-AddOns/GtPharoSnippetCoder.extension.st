Extension { #name : #GtPharoSnippetCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addConvertCascadesToStatementsFor: aNode to: coderAddOns priority: aPriority context: aBuildContext [
	<return: #Boolean>
	aNode isCascade ifFalse: [ ^ false ].
	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Convert cascade to statements'
				description: (self nodeDescription: aNode))
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode documentId: aBuildContext documentId)
		leave: self removeHighlightsBlock
		action: [ :aCoderViewModel :element | 
			(GtSnippetConvertCascadesToStatementsController new
				node: aNode;
				sourceCoderViewModel: aCoderViewModel) executeIn: element ]
		id: #'context-menu--cascades-to-statements')
		ifNotNil: [ :anAction | anAction priority: aPriority ].
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addConvertStatementsToCascadesFor: nodes to: coderAddOns context: aBuildContext [
	<return: #GtCoderContextMenuAction or: nil>
	nodes size > 1 ifFalse: [ ^ nil ].
	(nodes allSatisfy: [ :each | each isMessageSend ]) ifFalse: [ ^ nil ].
	(nodes allSatisfy: [ :each | each receiver = nodes first receiver ])
		ifFalse: [ ^ nil ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Convert statements to cascade'
				description: (self nodeDescription: nodes first))
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodesBlock: nodes documentId: aBuildContext documentId)
		leave: self removeHighlightsBlock
		action: [ :aCoderViewModel :element | 
			(GtSnippetConvertStatementsToCascadesController new
				nodes: nodes;
				sourceCoderViewModel: aCoderViewModel) executeIn: element ]
		id: #'context-menu--statements-to-cascade'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addExtractTestContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<return: #GtCoderContextMenuAction or: nil>
	"<gtCoderContextMenuAddOns: 220>"
	| aDocumentId |
	aDocumentId := aCoderViewModel documentId.
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :nodes | 
			coderAddOns
				addContextMenuItem: 'Extract test'
				hover: (self highlightNodesFromFirstToLastBlock: nodes documentId: aDocumentId)
				leave: self removeHighlightsBlock
				action: [ :aTextualViewModel :element | 
					(GtExtractTestFromSnippetController new sourceCoderViewModel: aTextualViewModel)
						executeIn: element ]
				id: #'snippet-extract-test' ].

	^ nil
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addExtractVariableFor: aNode to: coderAddOns context: aBuildContext [
	(aNode isValueNode and: [ aNode isVariable not ]) ifFalse: [ ^ false ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Extract variable'
				description: (self nodeDescription: aNode))
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode documentId: aBuildContext documentId)
		leave: self removeHighlightsBlock
		action: [ :aCoderViewModel :element | 
			(GtSnippetExtractTemporaryRefactoringController new
				node: aNode;
				sourceCoderViewModel: aCoderViewModel) executeIn: element ]
		id: #'context-menu--extract-variable'.
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addInlineMethodFor: aNode to: coderAddOns from: aCoderViewModel [
	<return: #Boolean>
	self
		deprecated: 'Please use addInlineMethodFor:to:from:priority:context: instead.'
		transformWith: '`@receiver addInlineMethodFor: `@statements1 to: `@statements2 from: `@statements3'
				-> '`@receiver addInlineMethodFor: `@statements1 to: `@statements2 from: `@statements3 priority: nil context: GtCoderAddOnsBuildContext new'.

	^ self
		addInlineMethodFor: aNode
		to: coderAddOns
		from: aCoderViewModel
		priority: nil
		context: GtCoderAddOnsBuildContext new
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addInlineMethodFor: aNode to: coderAddOns from: aCoderViewModel priority: aPriority context: aBuildContext [
	<return: #Boolean>
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
				from: aCoderViewModel
				priority: aPriority
				context: aBuildContext ].
	class := class whichClassIncludesSelector: selector.
	class
		ifNil: [ (GtPharoIndex current implementersOf: aNode selector) ifEmpty: [ ^ false ] ].

	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline message'
				description: aNode message selector)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode documentId: aBuildContext documentId)
		leave: self removeHighlightsBlock
		action: [ :aSourceCoderViewModel :element | 
			(GtSnippetInlineMessageRefactoringController new
				messageNode: aNode;
				implementorClass: class;
				snippetClass: self behavior;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--inline-send')
		ifNotNil: [ :anAction | anAction priority: aPriority ].

	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addInlineMethodUnknownReceiverFor: aNode to: coderAddOns from: aCoderViewModel priority: aPriority context: aBuildContext [
	<return: #Boolean>
	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline message'
				description: aNode message selector)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode documentId: aBuildContext)
		leave: self removeHighlightsBlock
		action: [ :aSourceCoderViewModel :element | 
			| classes defaultClass |
			classes := GtPharoIndex current implementersOf: aNode selector.
			defaultClass := classes anyOne methodClass.
			(GtSnippetUnknownReceiverInlineMessageRefactoringController new
				implementor: defaultClass;
				node: aNode;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--inline-message')
		ifNotNil: [ :anAction | anAction priority: aPriority ].
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addInlineTempFor: aNode to: coderAddOns priority: aPriority context: aBuildContext [
	<return: #Boolean>
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

	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline assignment'
				description: variable variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self
				highlightNodesBlock: {uses first parent} , uses
				documentId: aBuildContext documentId)
		leave: self removeHighlightsBlock
		action: [ :aSourceCoderViewModel :element | 
			(GtSnippetInlineVariableRefactoringController new
				node: uses first parent;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--inline-temp')
		ifNotNil: [ :anAction | anAction priority: aPriority ].
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addRefactoringContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	| aDocumentId |
	aDocumentId := aCoderViewModel documentId.
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :nodes | 
			| node allParents |
			(coderAddOns
				addContextMenuItem: 'Extract method'
				group: BrMenuItemGroupConfiguration refactoring
				hover: (self
						highlightNodesFromFirstToLastBlock: nodes
						documentId: aDocumentId)
				leave: self removeHighlightsBlock
				action: [ :aTextualViewModel :element | 
					(GtExtractMethodFromSnippetController new
						sourceCoderViewModel: aTextualViewModel) executeIn: element ]
				id: GtMethodCoderExtractMethodContextMenuItemId)
				ifNotNil: [ :anAction | anAction priority: 210.01 ].
			(coderAddOns
				addContextMenuItem: 'Extract example'
				group: BrMenuItemGroupConfiguration refactoring
				hover: (self
						highlightNodesFromFirstToLastBlock: nodes
						documentId: aDocumentId)
				leave: self removeHighlightsBlock
				action: [ :aTextualViewModel :element | 
					(GtExtractExampleFromSnippetController new
						sourceCoderViewModel: aTextualViewModel) executeIn: element ]
				id: #'snippet-extract-example')
				ifNotNil: [ :anAction | anAction priority: 210.02 ].
			node := nodes first.
			allParents := node withAllParents.
			allParents
				detect: [ :aNode | 
					self
						addExtractVariableFor: aNode
						to: coderAddOns
						context: (GtCoderAddOnsBuildContext new documentId: aDocumentId) ]
				ifNone: [  ].
			self
				addInlineMethodFor: node
				to: coderAddOns
				from: aCoderViewModel
				priority: 210.03
				context: (GtCoderAddOnsBuildContext new documentId: aDocumentId).
			allParents
				detect: [ :n | 
					self
						addInlineTempFor: n
						to: coderAddOns
						priority: 210.04
						context: (GtCoderAddOnsBuildContext new documentId: aDocumentId) ]
				ifNone: [  ].
			allParents
				detect: [ :n | 
					self
						addConvertCascadesToStatementsFor: n
						to: coderAddOns
						priority: 210.05
						context: (GtCoderAddOnsBuildContext new documentId: aDocumentId) ]
				ifNone: [  ].
			(self
				addConvertStatementsToCascadesFor: nodes
				to: coderAddOns
				context: (GtCoderAddOnsBuildContext new documentId: aDocumentId))
				ifNotNil: [ :anAction | anAction priority: 210.06 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addSplitCascadeContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	| splitBeforeMessage aDocumentId |
	aDocumentId := aCoderViewModel documentId.
	splitBeforeMessage := self cascadeMessageToSplitAfter: aCoderViewModel.
	splitBeforeMessage ifNil: [ ^ self ].
	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Split cascade'
				description: splitBeforeMessage source)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: splitBeforeMessage documentId: aDocumentId)
		leave: self removeHighlightsBlock
		action: [ :cvm :element | 
			(GtSnippetSplitCascadesController new
				node: splitBeforeMessage;
				sourceCoderViewModel: cvm) executeIn: element ]
		id: #'context-menu--split-cascade')
		ifNotNil: [ :anAction | anAction priority: 221 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> initializeAddOns: addOns [

	super initializeAddOns: addOns.

	addOns addStyler: (GtMethodAdviceStyler new isForWorkspace: true).

	addOns
		addMainAction: 'Evaluate and inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doItAndGo
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.
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
			title: 'Variable values' translated;
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
