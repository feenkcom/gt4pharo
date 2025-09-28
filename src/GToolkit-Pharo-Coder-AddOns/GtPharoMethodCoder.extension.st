Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addAddParameterRefactoringFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	| method valueNode label |
	(aNode isMethod
		or: [ aNode isMethodPattern or: [ aNode parent isMethodPattern ] ])
		ifFalse: [ aNode isMessage
				ifTrue: [ valueNode := aNode parent ]
				ifFalse: [ aNode isValueNode ifTrue: [ valueNode := aNode ] ].
			[ valueNode notNil and: [ valueNode parent isKindOf: GtPharoLiteralNode ] ]
				whileTrue: [ valueNode := valueNode parent ].
			(valueNode isNil or: [ valueNode isVariableDefinition ]) ifTrue: [ ^ nil ] ].
	method := aNode topParent.
	method selector isBinary ifTrue: [ ^ nil ].
	label := valueNode
			ifNil: [ self createLabel: 'Add parameter' description: method selector ]
			ifNotNil: [ self createLabel: 'Extract as parameter' description: method selector ].
	^ coderAddOns
		addContextMenuItem: label
		group: BrMenuItemGroupConfiguration refactoring
		hover: (valueNode ifNotNil: [ self highlightNodeBlock: valueNode ])
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtAddParameterRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				parameterNode: valueNode;
				methodNode: method) executeIn: element ]
		id: #'context-menu--add-parameter'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addClassAccessorRefactoringsFor: aNode to: coderAddOns [
	self
		deprecated: 'Please use addClassAccessorRefactoringsFor:to:priority: instead.'
		transformWith: '`@receiver addClassAccessorRefactoringsFor: `@statements1 to: `@statements2'
				-> '`@receiver addClassAccessorRefactoringsFor: `@statements1 to: `@statements2 priority: nil'.
	
	self
		addClassAccessorRefactoringsFor: aNode
		to: coderAddOns
		priority: nil
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addClassAccessorRefactoringsFor: aNode to: coderAddOns priority: aPriority [
	aNode isVariable ifFalse: [ ^ nil ].
	aNode whoDefines notNil ifTrue: [ ^ nil ].
	(self behavior allClassVarNames includes: aNode variableName)
		ifFalse: [ ^ nil ].
	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Abstract variable'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtAbstractClassVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) executeIn: element ]
		id: #'context-menu--abstract-variable')
			ifNotNil: [ :anAction | anAction priority: aPriority + 0.0001 ].
	(self isAccessorMethodFor: aNode)
		ifFalse: [ (coderAddOns
				addContextMenuItem: (self
						createLabel: 'Create accessors'
						description: aNode variableName)
				group: BrMenuItemGroupConfiguration refactoring
				hover: (self highlightNodeBlock: aNode)
				leave: self removeHighlightBlock
				action: [ :aCoderViewModel :element | 
					(GtCreateClassVariableAccessorsRefactoringController new
						sourceCoderViewModel: aCoderViewModel;
						variableNode: aNode) executeIn: element ]
				id: #'context-menu--create-accessors')
					ifNotNil: [ :anAction | anAction priority: aPriority + 0.0002 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addConvertCascadesToStatementsFor: aNode to: coderAddOns [
	<return: #Boolean>
	self
		deprecated: 'Please use addConvertCascadesToStatementsFor:to:priority: instead.'
		transformWith: '`@receiver addConvertCascadesToStatementsFor: `@statements1 to: `@statements2'
				-> '`@receiver addConvertCascadesToStatementsFor: `@statements1 to: `@statements2 priority: nil'.
	
	^ self
		addConvertCascadesToStatementsFor: aNode
		to: coderAddOns
		priority: nil
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addConvertCascadesToStatementsFor: aNode to: coderAddOns priority: aPriority [
	<return: #Boolean>
	aNode isCascade ifFalse: [ ^ false ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Convert cascade to statements'
				description: (self nodeDescription: aNode))
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtConvertCascadesToStatementsController new
				node: aNode;
				sourceCoderViewModel: aCoderViewModel) executeIn: element ]
		id: #'context-menu--cascades-to-statements'.
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addConvertStatementsToCascadesFor: nodes to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	| sends |
	nodes size > 1 ifFalse: [ ^ nil ].
	sends := nodes first isAssignment
			ifTrue: [ nodes allButFirst ]
			ifFalse: [ nodes ].
	(sends allSatisfy: [ :each | each isMessageSend or: [ each isCascade ] ])
		ifFalse: [ ^ nil ].
	(sends allSatisfy: [ :each | each receiver = sends first receiver ])
		ifFalse: [ ^ nil ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Convert statements to cascade'
				description: (self nodeDescription: nodes first))
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodesBlock: nodes)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtConvertStatementsToCascadesController new
				nodes: nodes;
				sourceCoderViewModel: aCoderViewModel) executeIn: element ]
		id: #'context-menu--statements-to-cascade'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addConvertTemporaryToInstanceVariableFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	aNode isVariable ifFalse: [ ^ nil ].
	(aNode parent isSequence
		and: [ aNode parent variables identityIncludes: aNode ]) ifFalse: [ ^ nil ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Convert to instance variable'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtConvertToInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) executeIn: element ]
		id: #'context-menu--convert-temp-to-inst-var'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractMethodObjectMenuForAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	| theNodes |
	theNodes := self extractableNodesFrom: aCoderViewModel.
	theNodes
		ifNotEmpty: [ (coderAddOns
				addContextMenuItem: 'Extract method object' asRopedText
				group: BrMenuItemGroupConfiguration refactoring
				hover: nil
				leave: nil
				action: [ :model :element | 
					(GtExtractMethodObjectRefactoringController new sourceCoderViewModel: model)
						executeIn: element ]) ifNotNil: [ :anAction | anAction priority: 215 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractMethodTo: coderAddOns from: aCoderViewModel [
	<return: #GtCoderContextMenuAction or: nil>
	| theNodes |
	theNodes := self extractableNodesFrom: aCoderViewModel.
	theNodes
		ifNotEmpty: [ | shortcut |
			(theNodes
				anySatisfy: [ :each | each isMethod or: [ (each nodeOfType: GtPharoMethodPatternNode) notNil ] ])
				ifTrue: [ ^ nil ].
			shortcut := GtSourceCoderExtractMethodShortcut new.
			^ coderAddOns
				addContextMenuItem: shortcut name
				group: BrMenuItemGroupConfiguration refactoring
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: theNodes first startPosition
						to: theNodes last stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel :element | 
					shortcut
						performOnEditor: nil
						element: element
						coderViewModel: aTextualViewModel
						dueTo: nil ]
				id: GtMethodCoderExtractMethodContextMenuItemId
				shortcutKey: shortcut combinationForPlatform gtDisplayString ].
				
	^ nil
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractTempFor: aNode to: coderAddOns [
	<return: #Boolean>
	self
		deprecated: 'Please use addExtractTempFor:to:priority: instead.'
		transformWith: '`@receiver addExtractTempFor: `@statements1 to: `@statements2'
				-> '`@receiver addExtractTempFor: `@statements1 to: `@statements2 priority: nil'.
	^ self
		addExtractTempFor: aNode
		to: coderAddOns
		priority: nil
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractTempFor: aNode to: coderAddOns priority: aPriority [
	<return: #Boolean>
	| nodes sequenceNode |
	(aNode isValueNode
		and: [ aNode isVariable not
				or: [ (aNode isAssignedTo or: [ aNode isDeclaration ]) not
						and: [ aNode whoDefines ifNil: [ true ] ifNotNil: [ :def | def isSequence not ] ] ] ])
		ifFalse: [ ^ false ].
	nodes := OrderedCollection new.
	sequenceNode := aNode statementNode parent.
	sequenceNode
		withAllNodesDo: [ :each | each = aNode ifTrue: [ nodes add: each ] ].
	aNode isVariable
		ifTrue: [ nodes removeAllSuchThat: [ :each | each isDeclaration ] ].
	nodes sort: [ :a :b | a startPosition < b startPosition ].
	[ nodes first statementNode parent ~= sequenceNode ]
		whileTrue: [ nodes removeFirst ].
	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Extract temporary'
				description: (self nodeDescription: aNode))
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodesBlock: nodes)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtExtractTemporaryRefactoringController new
				node: nodes first;
				sourceCoderViewModel: aCoderViewModel) executeIn: element ]
		id: #'context-menu--extract-temp'
		shortcutKey: (self extractToTemporaryShortcut
				ifNotNil: [ :aShortcut | aShortcut combinationForPlatform gtDisplayString ]))
		ifNotNil: [ :anAction | anAction priority: aPriority ].
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractToWrappedMethodObjectMenuForAst: anAst to: coderAddOns from: aCoderViewModel [
	"<gtCoderContextMenuAddOns: 18>"

	| theNodes |
	theNodes := self extractableNodesFrom: aCoderViewModel.
	theNodes
		ifNotEmpty: [ coderAddOns
				addContextMenuItem: 'Extract to paragraph' asRopedText
				hover: nil
				leave: nil
				action: [ :model :element | 
					(GtExtractToWrappedMethodObjectRefactoringController new
						sourceCoderViewModel: model) executeIn: element ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addHierarchyImplementorsMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			(self
				addLinkMenuAddOnsTo: coderAddOns
				group: BrMenuItemGroupConfiguration navigation
				node: node
				selector: #browseHierarchyImplementorsAt:requesterObject:
				label: 'Browse hierarchy implementors'
				requesterObject: aCoderViewModel)
				ifNotNil: [ :anAction | anAction priority: 11 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addHierarchyMessageReferencesMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			(self
				addLinkMenuAddOnsTo: coderAddOns
				group: BrMenuItemGroupConfiguration navigation
				node: node
				selector: #browseHierarchyReferencesAt:requesterObject:
				label: 'Browse hierarchy references'
				requesterObject: aCoderViewModel)
				ifNotNil: [ :anAction | anAction priority: 16 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineAllSelfSendsFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	| method |
	(aNode isMethod
		or: [ aNode isMethodPattern or: [ aNode parent isMethodPattern ] ])
		ifFalse: [ ^ nil ].
	method := aNode topParent.
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline All self Sends'
				description: method selector)
		group: BrMenuItemGroupConfiguration refactoring
		hover: nil
		leave: nil
		action: [ :aSourceCoderViewModel :element | 
			(GtInlineSelfSendsRefactoringController new
				methodNode: method;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--inline-self-sends'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineMessageFor: aNode to: coderAddOns [
	<return: #Boolean>
	self
		deprecated: 'Please use addInlineMessageFor:to:priority: instead.'
		transformWith: '`@receiver addInlineMessageFor: `@statements1 to: `@statements2'
				-> '`@receiver addInlineMessageFor: `@statements1 to: `@statements2 priority: nil'.

	^ self
		addInlineMessageFor: aNode
		to: coderAddOns
		priority: nil
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineMessageFor: aNode to: coderAddOns priority: aPriority [
	<return: #Boolean>
	aNode isMessageSend ifFalse: [ ^ false ].
	(aNode receiver isSelf or: [ aNode receiver isSuper ])
		ifTrue: [ (coderAddOns
				addContextMenuItem: (self
						createLabel: 'Inline message'
						description: aNode message selector)
				group: BrMenuItemGroupConfiguration refactoring
				hover: (self highlightNodeBlock: aNode)
				leave: self removeHighlightBlock
				action: [ :aSourceCoderViewModel :element | 
					(GtMethodInlineMessageSendRefactoringController new
						node: aNode;
						sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
				id: #'context-menu--inline-message')
				ifNotNil: [ :anAction | anAction priority: aPriority ].
			^ true ].
	(GtPharoIndex current implementersOf: aNode selector) ifEmpty: [ ^ false ].

	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline message'
				description: aNode message selector)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel :element | 
			| classes defaultClass |
			classes := GtPharoIndex current implementersOf: aNode selector.
			defaultClass := classes size = 1
					ifTrue: [ classes anyOne methodClass ]
					ifFalse: [ (GtPharoProgramNode
							typeOf: aNode receiver
							in: self behavior
							bindings: aSourceCoderViewModel compositeVariableBindings)
							ifNotNil: [ :cls | cls whichClassIncludesSelector: aNode selector ] ].
			(GtMethodInlineMessageFromComponentRefactoringController new
				implementor: defaultClass;
				node: aNode;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--inline-message')
		ifNotNil: [ :anAction | anAction priority: aPriority ].
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineParameterRefactoringFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	(aNode isVariable and: [ aNode parent isMethodPattern ]) ifFalse: [ ^ nil ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline parameter'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtInlineParameterRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) executeIn: element ]
		id: #'context-menu--inline-parameter'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineTempFor: aNode to: coderAddOns [
	<return: #Boolean>
	self
		deprecated: 'Please use addInlineTempFor:to:priority: instead.'
		transformWith: '`@receiver addInlineTempFor: `@statements1 to: `@statements2'
				-> '`@receiver addInlineTempFor: `@statements1 to: `@statements2 priority: nil'.
	
	^ self
		addInlineTempFor: aNode
		to: coderAddOns
		priority: nil
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineTempFor: aNode to: coderAddOns priority: aPriority [
	<return: #Boolean>
	| variable uses definer |
	aNode isAssignment ifTrue: [ variable := aNode variable ].
	aNode isVariable
		ifTrue: [ (aNode parent isAssignment and: [ aNode parent variable == aNode ])
				ifTrue: [ ^ false ].
			variable := aNode ].
	(variable isNil or: [ (definer := variable whoDefines) isNil ])
		ifTrue: [ ^ false ].
	uses := self allReferencesTo: variable.
	uses size < 2 ifTrue: [ ^ false ].
	uses first isDeclaration ifFalse: [ ^ false ].
	uses second isAssignedTo ifFalse: [ ^ false ].
	3 to: uses size do: [ :i | (uses at: i) isAssignedTo ifTrue: [ ^ false ] ].
	uses size >= 3
		ifTrue: [ uses second stopPosition > uses third startPosition ifTrue: [ ^ false ] ].

	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline assignment'
				description: variable variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodesBlock: {uses second parent} , uses)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel :element | 
			(GtMethodInlineTemporaryVariableRefactoringController new
				node: uses second parent;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--inline-temp')
			ifNotNil: [ :anAction | anAction priority: aPriority ].
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInstanceAccessorRefactoringsFor: aNode to: coderAddOns [
	self
		deprecated: 'Please use addInstanceAccessorRefactoringsFor:to:priority: instead.'
		transformWith: '`@receiver addInstanceAccessorRefactoringsFor: `@statements1 to: `@statements2'
				-> '`@receiver addInstanceAccessorRefactoringsFor: `@statements1 to: `@statements2 priority: nil'.

	self
		addInstanceAccessorRefactoringsFor: aNode
		to: coderAddOns
		priority: nil
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInstanceAccessorRefactoringsFor: aNode to: coderAddOns priority: aPriority [
	aNode isVariable ifFalse: [ ^ nil ].

	(aNode whoDefines: aNode variableName) notNil ifTrue: [ ^ nil ].

	(self behavior allInstVarNames includes: aNode variableName)
		ifFalse: [ ^ nil ].

	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Abstract variable'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtAbstractInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) executeIn: element ]
		id: #'context-menu--abstract-variable')
				ifNotNil: [ :anAction | anAction priority: aPriority + 0.0001 ].
	(self isAccessorMethodFor: aNode)
		ifTrue: [ (coderAddOns
				addContextMenuItem: (self
						createLabel: 'Protect variable'
						description: aNode variableName)
				group: BrMenuItemGroupConfiguration refactoring
				hover: (self highlightNodeBlock: aNode)
				leave: self removeHighlightBlock
				action: [ :aCoderViewModel :element | 
					(GtProtectInstanceVariableRefactoringController new
						sourceCoderViewModel: aCoderViewModel;
						variableNode: aNode) executeIn: element ]
				id: #'context-menu--protect-variable')
					ifNotNil: [ :anAction | anAction priority: aPriority + 0.0002 ] ].
	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Create accessors'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtCreateInstanceVariableAccessorsRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) executeIn: element ]
		id: #'context-menu--create-accessors')
			ifNotNil: [ :anAction | anAction priority: aPriority + 0.0003 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addMoveMethodRefactoringFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	aNode isVariable ifFalse: [ ^ nil ].
	aNode whoDefines ifNotNil: [ :node | node isMethod ifFalse: [ ^ nil ] ].
	aNode topParent
		allNodesOfType: GtPharoAssignmentNode
		do: [ :node | node variable = aNode ifTrue: [ ^ nil ] ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Move method into'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtMoveMethodRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) executeIn: element ]
		id: #'context-menu--move-method'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addMoveTemporaryToOuterScopeFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	aNode isVariable ifFalse: [ ^ nil ].
	(aNode parent isSequence
		and: [ aNode parent variables identityIncludes: aNode ]) ifFalse: [ ^ nil ].
	(aNode parent parentOfType: GtPharoSequenceNode) ifNil: [ ^ nil ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Move to outer scope'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtMoveTemporaryToOuterScopeRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) executeIn: element ]
		id: #'context-menu--move-to-outer-scope'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addPullDownVariableRefactoringsFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	| class |
	aNode isVariable ifFalse: [ ^ nil ].

	aNode whoDefines notNil ifTrue: [ ^ nil ].

	class := self behavior whichClassDefinesInstVar: aNode variableName.
	(class isNil or: [ class = self behavior ]) ifTrue: [ ^ nil ].

	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Pull down variable declaration'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtPushDownInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) executeIn: element ]
		id: #'context-menu--pull-down-variable'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addPushDownMethodRefactoringFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	| method |
	(aNode isMethod
		or: [ aNode isMethodPattern or: [ aNode parent isMethodPattern ] ])
		ifFalse: [ ^ nil ].
	self behavior subclasses isEmpty ifTrue: [ ^ nil ].
	method := aNode topParent.
	(self behavior subclasses
		allSatisfy: [ :each | each includesSelector: method selector ])
		ifTrue: [ ^ nil ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Push down method'
				description: method selector)
		group: BrMenuItemGroupConfiguration refactoring
		hover: nil
		leave: nil
		action: [ :aCoderViewModel :element | 
			(GtPushDownMethodRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				methodNode: method) executeIn: element ]
		id: #'context-menu--push-down-method'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addPushUpMethodRefactoringFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	| method variables |
	(aNode isMethod
		or: [ aNode isMethodPattern or: [ aNode parent isMethodPattern ] ])
		ifFalse: [ ^ nil ].
	self behavior superclass isNil ifTrue: [ ^ nil ].
	variables := Set withAll: self behavior instVarNames.
	variables addAll: self behavior classVarNames.
	method := aNode topParent.
	method
		allNodesOfType: GtPharoVariableNode
		do: [ :each | (variables includes: each variableName) ifTrue: [ ^ nil ] ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Push up method'
				description: aNode selector)
		group: BrMenuItemGroupConfiguration refactoring
		hover: nil
		leave: nil
		action: [ :aCoderViewModel :element | 
			(GtPushUpMethodRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				methodNode: method) executeIn: element ]
		id: #'context-menu--push-up-method'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addPushUpVariableRefactoringsFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	aNode isVariable ifFalse: [ ^ nil ].

	aNode whoDefines notNil ifTrue: [ ^ nil ].

	(self behavior allInstVarNames includes: aNode variableName)
		ifFalse: [ ^ nil ].

	(self behavior whichClassDefinesInstVar: aNode variableName) superclass
		= Object ifTrue: [ ^ nil ].

	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Push up variable declaration'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			(GtPushUpInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) executeIn: element ]
		id: #'context-menu--push-up-variable'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRefactoringContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(self addExtractMethodTo: coderAddOns from: aCoderViewModel)
		ifNotNil: [ :anAction | anAction priority: 220.01 ].

	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :theNodes | 
			| aNode allParents |
			aNode := theNodes first.

			(self addPushUpMethodRefactoringFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.02 ].
			(self addPushDownMethodRefactoringFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.03 ].
			(self addMoveMethodRefactoringFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.04 ].
			(self addAddParameterRefactoringFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.05 ].
			(self addInlineParameterRefactoringFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.06 ].
			(self addInlineAllSelfSendsFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.07 ].
			self
				addInstanceAccessorRefactoringsFor: aNode
				to: coderAddOns
				priority: 220.08.
			(self addPushUpVariableRefactoringsFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.08 ].
			(self addPullDownVariableRefactoringsFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.09 ].
			self
				addClassAccessorRefactoringsFor: aNode
				to: coderAddOns
				priority: 220.10.
			(self addRemoveParameterRefactoringFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.11 ].
			(self addConvertTemporaryToInstanceVariableFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.12 ].
			(self addMoveTemporaryToOuterScopeFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.13 ].
			(self addVariableScopingFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.14 ].
			allParents := aNode withAllParents.
			allParents
				detect: [ :node | 
					self
						addInlineMessageFor: node
						to: coderAddOns
						priority: 220.15 ]
				ifNone: [  ].
			allParents
				detect: [ :node | 
					self
						addInlineTempFor: node
						to: coderAddOns
						priority: 220.16 ]
				ifNone: [  ].
			allParents
				detect: [ :node | 
					self
						addExtractTempFor: node
						to: coderAddOns
						priority: 220.17 ]
				ifNone: [  ].
			allParents
				detect: [ :node | 
					self
						addConvertCascadesToStatementsFor: node
						to: coderAddOns
						priority: 220.18 ]
				ifNone: [  ].
			(self addConvertStatementsToCascadesFor: theNodes to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 220.19 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRemoveParameterRefactoringFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	| disabled action |
	aNode isVariable ifFalse: [ ^ nil ].
	aNode parent isMethodPattern ifFalse: [ ^ nil ].
	disabled := false.
	aNode parent parent body
		allNodesDo: [ :each | each = aNode ifTrue: [ disabled := true ] ].
	action := coderAddOns
			addContextMenuItem: (self
					createLabel: 'Remove parameter'
					description: aNode variableName)
			group: BrMenuItemGroupConfiguration refactoring
			hover: (self highlightNodeBlock: aNode)
			leave: self removeHighlightBlock
			action: [ :aCoderViewModel :element | 
				(GtRemoveParameterRefactoringController new
					sourceCoderViewModel: aCoderViewModel;
					variableNode: aNode) executeIn: element ]
			id: #'context-menu--remove-parameter'.
	disabled ifTrue: [ action disableAction ].
	^ action
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRenameClassRefactoringFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	aNode isVariable ifFalse: [ ^ nil ].
	Smalltalk globals
		at: aNode name value asSymbol
		ifPresent: [ :cls | 
			(cls isKindOf: Class)
				ifTrue: [ ^ coderAddOns
						addContextMenuItem: (self
								createLabel: 'Rename class'
								description: aNode variableName)
						group: BrMenuItemGroupConfiguration refactoring
						hover: (self highlightNodesBlock: (self allReferencesTo: aNode))
						leave: self removeHighlightBlock
						action: [ :aCoderViewModel :element | 
							self
								renameClassIn: aCoderViewModel
								node: aNode
								for: element ]
						shortcutKey: GtSourceCoderInlineRenameShortcut new combinationForPlatform
								gtDisplayString ] ].

	^ nil
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRenameClassVariableRefactoringFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	(aNode isVariable and: [ self isClassVariable: aNode ]) ifFalse: [ ^ nil ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Rename class variable'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodesBlock: (self allReferencesTo: aNode))
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			self
				renameClassVariableIn: aCoderViewModel
				node: aNode
				for: element ]
		id: #'context-menu--rename-class-var'
		shortcutKey: GtSourceCoderInlineRenameShortcut new combinationForPlatform
				gtDisplayString
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRenameInstanceVariableRefactoringFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	(aNode isVariable and: [ self isInstanceVariable: aNode ]) ifFalse: [ ^ nil ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Rename instance variable'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodesBlock: (self allReferencesTo: aNode))
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element | 
			self
				renameInstanceVariableIn: aCoderViewModel
				node: aNode
				for: element ]
		id: #'context-menu--rename-inst-var'
		shortcutKey: GtSourceCoderInlineRenameShortcut new combinationForPlatform
				gtDisplayString
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRenameMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :theNodes | 
			| aNode |
			aNode := theNodes first.

			(self addRenameTemporaryRefactoringFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 200.1 ].
			(self addRenameInstanceVariableRefactoringFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 200.2 ].
			(self addRenameClassVariableRefactoringFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 200.3 ].
			(self addRenameClassRefactoringFor: aNode to: coderAddOns)
				ifNotNil: [ :anAction | anAction priority: 200.4 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRenameTemporaryRefactoringFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	(aNode isVariable and: [ self isLocalVariable: aNode ]) ifFalse: [ ^ nil ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Rename local'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodesBlock: (self allReferencesTo: aNode))
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel | self renameTemporaryIn: aCoderViewModel node: aNode ]
		id: #'context-menu--rename-temp'
		shortcutKey: GtSourceCoderInlineRenameShortcut new combinationForPlatform
				gtDisplayString
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addSplitCascadeContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	| node cursors splitBeforeMessage position |
	cursors := aCoderViewModel cursors allCursors.
	cursors size = 1 ifFalse: [ ^ self ].
	position := cursors first position.
	node := self nodeAt: position.
	node ifNil: [ ^ self ].
	(node isMessage
		and: [ node parent isCascade
				and: [ (node parent messages identityIndexOf: node) > 1 ] ])
		ifTrue: [ splitBeforeMessage := node ].
	node isCascade
		ifTrue: [ node messages
				doWithIndex: [ :each :i | 
					(i > 1
						and: [ each startPosition > position
								and: [ (node messages at: i - 1) stopPosition < position ] ])
						ifTrue: [ splitBeforeMessage := each ] ] ].
	splitBeforeMessage ifNil: [ ^ self ].
	(coderAddOns
		addContextMenuItem: (self
				createLabel: 'Split cascade'
				description: splitBeforeMessage source)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: splitBeforeMessage)
		leave: self removeHighlightBlock
		action: [ :cvm :element | 
			(GtSplitCascadesController new
				node: splitBeforeMessage;
				sourceCoderViewModel: cvm) executeIn: element ]
		id: #'context-menu--split-cascade')
		ifNotNil: [ :anAction | anAction priority: 221 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addVariableScopingFor: aNode to: coderAddOns [
	<return: #GtCoderContextMenuAction or: nil>
	| uses groups |
	aNode isVariable ifFalse: [ ^ nil ].
	(aNode parent isSequence
		and: [ aNode parent variables identityIncludes: aNode ]) ifFalse: [ ^ nil ].
	uses := OrderedCollection new.
	aNode parent statements
		do: [ :each | 
			each
				allNodesOfType: GtPharoVariableNode
				do: [ :var | 
					var = aNode
						ifTrue: [ (var parentOfType: GtPharoBlockNode)
								ifNil: [ ^ nil ]
								ifNotNil: [ :block | block == (aNode parentOfType: GtPharoBlockNode) ifTrue: [ ^ nil ] ].
							uses add: var ] ] ].
	groups := uses
			groupedBy: [ :each | 
				| parents block |
				parents := each allParents.
				1
					to: (parents identityIndexOf: aNode parent) - 1
					do: [ :i | ((parents at: i) isKindOf: GtPharoBlockNode) ifTrue: [ block := parents at: i ] ].
				block ].
	groups do: [ :each | each first isAssignedTo ifFalse: [ ^ nil ] ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: 'Move declaration to inner scope'
				description: aNode variableName)
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel :element | 
			(GtMoveVariableRefactoringController new
				variableNode: aNode;
				sourceCoderViewModel: aSourceCoderViewModel) executeIn: element ]
		id: #'context-menu--move-variable-declaration'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> baselineAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>

	(self behavior inheritsFrom: BaselineOf)
		ifFalse: [ ^ self ].

	coderAddOns addStyler: GtCoderExpandableBaselineStyler new
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> browseFrom: anEditorElement [
	BlSpace new
		withSceneDriller;
		inPager: [ GtMethodCoderTool compiledMethod: self compiledMethod ];
		title: self behavior printString;
		icon: BrGlamorousVectorIcons browse;
		showFrom: anEditorElement
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> buildRemoveMethodLabel: anElement [
	^ GtPharoRemoveMethodPreviewStencil new
		selectorToRemove: self selector;
		isEmptyMethod: self isNewMethod;
		anElement: anElement;
		create
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> copyMethodNameToClipboard [
	self compiledMethod ifNotNil: [ :aCompiledMethod | 
		Clipboard clipboardText: aCompiledMethod printString ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> exampleAstFor: anAST into: coderAddOns viewModel: aGtPharoMethodCoderViewModel [
	<gtAstCoderAddOns: 10>
	| anExample |
	self compiledMethod ifNil: [ ^ self ].

	anAST methodNode ifNil: [ ^ self ].

	"Example failure styler can also highlight code in expanded method coders, 
	using `aGtPharoMethodCoderViewModel parentExample` information. For that reason, 
	the <gtExample> pragma is not required for this styler."
	self exampleFailureStylerFor: anAST into: coderAddOns viewModel: aGtPharoMethodCoderViewModel.
	
	(anAST methodNode pragmas
		anySatisfy: [ :each | each isErrorNode not and: [ each selector = #gtExample ] ])
		ifFalse: [ ^ self ].

	coderAddOns addStyler: GtCoderExampleStatusStyler new.
	coderAddOns addStyler: GtCoderExampleAfterStyler new.

	(self canExecuteExample or: [ anAST methodNode numArgs isZero ])
		ifFalse: [ ^ self ].

	coderAddOns
		addPreview: 'Example'
		stencil: [ GtCoderExampleStateElement new ]
		dataBinder: [ :anElement :aCoderViewModel | 
			| aHandler aCoder |
			anElement userData
				at: #exampleAstFor_into_example_handler
				ifPresent: [ :anOldHandler | 
					anElement userData
						at: #exampleAstFor_into_example_coder
						ifPresent: [ :anOldCoder | anOldCoder unsubscribe: anOldHandler ]
						ifAbsent: [  "ignore" ] ]
				ifAbsent: [  "ignore" ].

			aCoder := aCoderViewModel coderModel.

			aHandler := [ :anAnnouncement | 
				aCoder example
					ifNotNil: [ :aNewExample | 
						anElement
							example: aNewExample;
							visibility: BlVisibility visible ]
					ifNil: [ anElement visibility: BlVisibility hidden ] ].
			anElement userData
				at: #exampleAstFor_into_example_handler put: aHandler;
				at: #exampleAstFor_into_example_coder put: aCoder.

			aCoder weak
				when: GtCoderMethodAdded , GtCoderMethodRemoved , GtCoderMethodModified
						, GtPharoMethodCoderCompiled
				send: #value:
				to: aHandler.

			anElement example: aCoder example ].

	anExample := self example.

	anExample hasAfterInDependencies
		ifTrue: [
			coderAddOns
				addContextDropDownWithPreviewAction: 'Evaluate and inspect example result' translated
				icon: BrGlamorousVectorIcons playinspect
				action: [ 
					self playAndInspectExampleWithRequesterObject: aGtPharoMethodCoderViewModel ]
				stencil: [ :element | 
					BrEditor new 
						aptitude: BrGlamorousRegularEditorAptitude new;
						constraintsDo: [:c | 
							c horizontal exact: 500. 
							c vertical fitContent];
						text: 'This example has an "after:" method that can perform cleanups. The returned object may be in an invalid state.';
						margin: (BlInsets all: 5) ] ]
		ifFalse: [ coderAddOns
				addContextAction: 'Evaluate and inspect example result' translated
				icon: BrGlamorousVectorIcons playinspect
				action: [ :aCoderUIModel :button | 
					self playAndInspectExampleWithRequesterObject: aCoderUIModel ]
				id: GtMethodCoderPlayAndInspectExampleActionId ].
	
	coderAddOns
		addContextAction: 'Evaluate example' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anEvent | self playExample ]
		id: GtMethodCoderPlayExampleActionId.
	
	coderAddOns
		addContextAction: 'Inspect example object' translated
		icon: BrGlamorousVectorIcons eg
		action: [ :aCoderUIModel :button | self notifyObjectSpawn: self example requesterObject: aCoderUIModel ].
	coderAddOns
		addContextAction: 'Debug example' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :aCoderUIModel :anEvent | self debugExample ]
		id: GtMethodCoderDebugExampleActionId.
	coderAddOns
		addContextAction: 'Extract code to playground' translated
		icon: LeIcons lepiterPage
		action: [ :aCoderUIModel :button :event | 
			self
				extractExampleToPlaygroundIn: button
				event: event
				requesterObject: aCoderUIModel ]
		id: GtMethodCoderExtractPlaygroundActionId
		allowPrimaryClick: true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> exampleFailureStylerFor: anAST into: coderAddOns viewModel: aGtPharoMethodCoderViewModel [ 
	coderAddOns addStyler: (GtCoderExampleFailureStyler new
		styleBlock: [ :aText :aColor | aText highlight: aColor ]).
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> executableMessageAddOnFor: anAST into: coderAddOns viewModel: aGtPharoMethodCoderViewModel [
	<gtAstCoderAddOns: 20>
	GtPharoExecutableMethodDetector new
		methodCoder: self;
		methodAst: anAST;
		methodCoderViewModel: aGtPharoMethodCoderViewModel;
		detect;
		ifNotExecutable: [ ^ self ].

	coderAddOns
		addContextAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor playAllAndInspect
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtPharoMethodPlayAndInspectActionId.
	coderAddOns
		addContextAction: 'Evaluate' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor playAll
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtPharoMethodPlayAllActionId.
	coderAddOns
		addContextAction: 'Debug' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :aCoderUIModel :anElement | aCoderUIModel debug ]
		id: GtPharoMethodDebugActionId
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> explanationFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>

	self explanationLink notNil
		ifTrue: [ coderAddOns addStyler: self explanationLink ].
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> extractExampleToPlaygroundIn: button event: anEvent requesterObject: aRequester [
	| page cls varName inlinedSource |
	cls := self behavior.
	varName := cls isClassSide
			ifTrue: [ self behavior instanceSide name ]
			ifFalse: [ self safeVarNameBasedOn: 'example' in: self astSync ].
	inlinedSource := self inlinedPlaygroundSourceForReceiver: varName for: button.
	page := LePage
			unnamedPageWithDefaultTitle: ('{1}>>{2} playground'
					format: {cls name.
							self astSync selector}).
	cls isClassSide
		ifFalse: [ page addSnippet: (LePharoSnippet code: varName , ' := ' , cls name , ' new') ].
	page addSnippet: (LePharoSnippet code: inlinedSource).
	LeDatabasesRegistry uniqueInstance currentLoadedDefaultLogicalDatabase
		playgroundDB addPage: page.
	anEvent modifiers isPrimaryModifier
		ifTrue: [ ((LePageToolElement new pageViewModel: page asContentUIModel) matchParent
				openInPagerFrom: button) maximized ]
		ifFalse: [ self
				notifyToolSpawn: (LePagePhlowTool page: page)
				withDestination: self spawnDestination
				requesterObject: aRequester ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> extractTestToPlaygroundIn: button event: anEvent requesterObject: aRequester [
	| page cls varName inlinedSource |
	cls := self behavior.
	varName := cls isClassSide
			ifTrue: [ self behavior instanceSide name ]
			ifFalse: [ self safeVarNameBasedOn: 'test' in: self astSync ].
	inlinedSource := self inlinedPlaygroundSourceForReceiver: varName for: button.
	page := LePage
			unnamedPageWithDefaultTitle: ('{1}>>{2} playground'
					format: {cls name.
							self astSync selector}).
	page := LePage
			unnamedPageWithDefaultTitle: ('{1}>>{2} playground'
					format: {cls name.
							self astSync selector}).
	page
		addSnippet: (LePharoSnippet
				code: varName , ' := ' , cls name
						, ' new.
' , varName , ' setUp.').
	page addSnippet: (LePharoSnippet code: inlinedSource).
	page addSnippet: (LePharoSnippet code: varName , ' tearDown').
	LeDatabasesRegistry uniqueInstance currentLoadedDefaultLogicalDatabase
		playgroundDB addPage: page.
	anEvent modifiers isPrimaryModifier
		ifTrue: [ ((LePageToolElement new pageViewModel: page asContentUIModel) matchParent
				openInPagerFrom: button) maximized ]
		ifFalse: [ self
				notifyToolSpawn: (LePagePhlowTool page: page)
				withDestination: self spawnDestination
				requesterObject: aRequester ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> extractToTemporaryShortcut [
	^nil
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> gtViewAddOnFor: anAST into: coderAddOns viewModel: aGtPharoMethodCoderViewModel [
	<gtAstCoderAddOns: 6>
	aGtPharoMethodCoderViewModel 
		ifSelfObject: [ "ignore" ] 
		ifNone: [ ^ self ].
	
	(self compiledMethod notNil
		and: [ anAST notNil
				and: [ anAST methodNode
						ifNotNil: [ :node | 
							node pragmas
								anySatisfy: [ :each | each isErrorNode not and: [ each selector = #gtView ] ] ]
						ifNil: [ false ] ] ]) ifFalse: [ ^ self ].
	anAST methodNode numArgs = 1 ifFalse: [ ^ self ].

	coderAddOns
		addContextAction: 'gtView' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :aButton | 
			self isModified
				ifTrue: [ self save ]
				ifFalse: [ 
					aGtPharoMethodCoderViewModel 
						ifSelfObject: [ :aSelfObject | 
							| view |
							view := aSelfObject 
								perform: self selector
								with: GtPhlowEmptyView new.
							aButton phlow spawnObject: view ] 
						ifNone: [ ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> highlighter [
	<return: #GtSourceReferenceHighlighter>

	^ self attributeNamed: #highlighter
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> highlighter: aGtSourceReferenceHighlighter [
	"Set a source reference highlighter thhat should be used tp highlight or mark some parts
	of the source code. If a given highlighter is nil, it means that no highlighter should be used"

	self highlighter == aGtSourceReferenceHighlighter
		ifTrue: [ ^ self ].

	self
		attributeNamed: #highlighter
		put: aGtSourceReferenceHighlighter.

	self requestUpdateAddOns
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> highlighterFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>

	self highlighter
		ifNotNil: [ :aHighlighter | coderAddOns addStyler: aHighlighter ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> highlighterFor: anAST into: coderAddOns viewModel: aGtPharoSourceCoderViewModel [
	<gtAstCoderAddOns: 10>
	
	self highlighter
		ifNotNil: [ :aHighlighter | coderAddOns addStyler: aHighlighter ].

	aGtPharoSourceCoderViewModel highlighter
		ifNotNil: [ :aHighlighter | coderAddOns addStyler: aHighlighter ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> initializeAddOns: addOns viewModel: aGtPharoMethodCoderViewModel [
	super initializeAddOns: addOns viewModel: aGtPharoMethodCoderViewModel.

	addOns addStyler: (GtMethodAdviceStyler new isForWorkspace: false).

	addOns
		addMainAction: (GtCoderCustomAction new
				title: 'Save';
				stencil: [ GtPharoMethodCoderSaveButton new
						pharoMethodCoderViewModel: aGtPharoMethodCoderViewModel ]).
	addOns
		addDropDownWithPreviewAction: 'Remove' translated
		icon: BrGlamorousVectorIcons remove
		action: [ :aButtonElement :aButtonModel :anEvent | self remove ]
		stencil: [ :element | self buildRemoveMethodLabel: element ]
		id: GtMethodCoderRemoveActionId.
	addOns
		addMainAction: 'Inspect method' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anElement | 
			self 
				notifyObjectSpawn: aCoderUIModel methodReference
				requesterObject: aCoderUIModel ]
		id: GtMethodCoderInspectActionId.
	addOns
		addMainAction: 'Copy method name' translated
		icon: BrGlamorousVectorIcons clipboard
		action: [ :aCoderUIModel :anElement | self copyMethodNameToClipboard ]
		id: GtMethodCoderCopyActionId.
		
	self initializeSearchTextAddOns: addOns viewModel: aGtPharoMethodCoderViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderDiscardChangesShortcut new;
		addShortcut: GtSourceCoderPlayShortcut new;
		addShortcut: GtSourceCoderPlayAndInspectShortcut new;
		addShortcut: GtSourceCoderSaveShortcut new;
		addShortcut: GtSourceCoderExtractMethodShortcut new
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> inlinedPlaygroundSourceForReceiver: varName for: anElement [
	| source ast tree coder editable node |
	ast := self astSync.
	source := '^' , varName , ' ' , ast selector.
	tree := GtPharoParser
			parse: source
			startingAt: GtPharoParser startingStateForStatement.
	coder := GtPharoSnippetCoder forSource: source.
	(GtSnippetInlineMessageRefactoringController new
		messageNode: tree value;
		implementorClass: self behavior;
		snippetClass: nil class;
		modelUpdater: [ :model | 
			self isModified
				ifTrue: [ (model classFor: self behavior)
						compile: self currentSourceText asString
						classified: #accessing ] ];
		sourceCoderViewModel: coder asCoderViewModel) executeIn: anElement.
	source := coder currentSourceString.
	editable := SmaCCString on: source.
	tree := GtPharoParser
			parse: source
			startingAt: GtPharoParser startingStateForMethodSequence.
	tree lastIsReturn
		ifTrue: [ node := tree statements last value.
			(node isVariable
				and: [ tree statements size > 1 and: [ node name source = varName ] ])
				ifTrue: [ editable
						deleteFrom: (tree statements at: tree statements size - 1) stopPosition + 1
						to: source size ]
				ifFalse: [ editable
						deleteFrom: node parent upArrow startPosition
						to: node startPosition - 1 ] ].
	^ editable asString
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> isMondrianPaintMethod: aMethodNode [
	| variable |
	aMethodNode arguments size ~= 1
		ifTrue: [ ^ false ].
	('paint*With:' match: aMethodNode selector)
		ifFalse: [ ^ false ].
	variable := aMethodNode arguments first.
	aMethodNode
		nodesDo: [ :each | 
			(each isMessage and: [ each receiver = variable ])
				ifTrue: [ (GtMondrian canUnderstand: each selector)
						ifFalse: [ ^ false ] ] ].
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> methodInheritanceFor: anAST into: coderAddOns viewModel: aMainCoderViewModel [
	<gtAstCoderAddOns: 1>

	coderAddOns addStyler: (GtPharoCoderMethodHeaderStyler new 
		attributeElementStencil: [ 
			GtPharoMethodCoderOverridingOverriddenElement new
				pharoMethodCoderViewModel: aMainCoderViewModel ]).
			 
	coderAddOns
		addPreview: 'Inheritance'
		stencil: [ GtPharoMethodCoderOverridingOverriddenElement new ]
		dataBinder: [ :anElement :aCoderViewModel | 
			anElement pharoMethodCoderViewModel: aCoderViewModel ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> modifiedMessageAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 2>

	self isModified
		ifFalse: [ ^ self ].

	coderAddOns
		addMainAction: 'Discard Changes' translated
		icon: BrGlamorousVectorIcons cancel
		action: [ :aCoderUIModel :anElement | aCoderUIModel discardChanges ]
		id: GtMethodCoderDiscardChangesActionId
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> mondrianPaintAddOnFor: anAST into: coderAddOns [
	"<gtAstCoderAddOns: 7>"
	(self hasObjectAttribute
		and: [ anAST notNil
				and: [ anAST methodNode
						ifNotNil: [ :node | self isMondrianPaintMethod: node ]
						ifNil: [ false ] ] ])
		ifFalse: [ ^ self ].

	coderAddOns
		addContextAction: 'Mondrian' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | self runMondrianPaintFrom: anEvent currentTarget ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> newFilterContext [
	^ super newFilterContext 
		selector: self selector
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> runMondrianPaintFrom: anElement [
	| mondrian |
	
	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ self ] ].
	
	mondrian := GtMondrian new.
	self object perform: self selector with: mondrian.
	anElement phlow spawnObject: mondrian
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> safeVarNameBasedOn: aString in: ast [
	| localVars name index |
	localVars := Set new.
	ast
		allNodesOfType: GtPharoVariableNode
		do: [ :each | localVars add: each name source ].
	localVars addAll: self behavior allInstVarNames.
	name := aString.
	index := 1.
	[ localVars includes: name ]
		whileTrue: [ name := aString , index printString.
			index := index + 1 ].
	^ name
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> slideAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>
	(self compiledMethod notNil
		and: [ anAST notNil
				and: [ anAST methodNode
						ifNotNil: [ :node | 
							node pragmas
								anySatisfy: [ :each | each isErrorNode not and: [ each selector = #gtSlide ] ] ]
						ifNil: [ false ] ] ]) ifFalse: [ ^ self ].
	anAST methodNode numArgs = 1 ifFalse: [ ^ self ].
	coderAddOns
		addContextAction: 'Play and Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | self playAndInspectSlideWithRequesterObject: aCoderUIModel ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> testCase [
	<return: #GtPharoMethodTestCase or: nil>
	^ self
		attributeNamed: #testCase
		ifPresent: [ :aTestCase | aTestCase ]
		ifAbsent: [ | aMethod |
			aMethod := self compiledMethod.
			aMethod
				ifNotNil: [ self attributeNamed: #testCase put: aMethod gtPharoMethodTestCase ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> unitTestAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 9>
	anAST methodNode ifNil: [ ^ self ].

	self testCase ifNil: [ ^ self ].
	self testCase canExecute ifFalse: [ ^ self ].

	coderAddOns addStyler: GtPharoMethodTestCaseStyler new.
	coderAddOns
		addPreview: 'Test Case'
		stencil: [ GtPharoMethodTestCaseStateElement new ]
		dataBinder: [ :anElement :aCoderViewModel | 
			| aHandler aCoder |
			anElement userData
				at: #unitTestAstFor_into_testcase_handler
				ifPresent: [ :anOldHandler | 
					anElement userData
						at: #unitTestAstFor_into_testcase_coder
						ifPresent: [ :anOldCoder | anOldCoder unsubscribe: anOldHandler ]
						ifAbsent: [  "ignore" ] ]
				ifAbsent: [  "ignore" ].

			aCoder := aCoderViewModel coderModel.

			aHandler := [ :anAnnouncement | 
				aCoder testCase
					ifNotNil: [ :aNewTestCase | 
						anElement
							testCase: aNewTestCase;
							visibility: BlVisibility visible ]
					ifNil: [ anElement visibility: BlVisibility hidden ] ].
			anElement userData
				at: #unitTestAstFor_into_testcase_handler put: aHandler;
				at: #unitTestAstFor_into_testcase_coder put: aCoder.

			aCoder weak
				when: GtCoderMethodAdded , GtCoderMethodRemoved , GtCoderMethodModified
						, GtPharoMethodCoderCompiled
				send: #value:
				to: aHandler.

			anElement testCase: self testCase ].

	coderAddOns
		addContextAction: 'Play Unit Test' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anEvent | self testCase play ]
		id: GtMethodCoderPlayExampleActionId.
	coderAddOns
		addContextAction: 'Debug Unit Test' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :aCoderUIModel :anEvent | self testCase debug ]
		id: GtMethodCoderDebugExampleActionId.
	coderAddOns
		addContextAction: 'Extract to playground' translated
		icon: LeIcons lepiterPage
		action: [ :aCoderUIModel :button :event | 
			self
				extractTestToPlaygroundIn: button
				event: event
				requesterObject: aCoderUIModel ]
		id: GtMethodCoderExtractPlaygroundActionId
		allowPrimaryClick: true
]
