Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addAddParameterRefactoringFor: aNode to: coderAddOns [
	| method valueNode |
	(aNode isMethod or: [ aNode isMethodPattern or: [ aNode parent isMethodPattern ] ])
		ifFalse:
			[ aNode isMessage ifTrue: [ valueNode := aNode parent ] ifFalse: [ aNode isValueNode ifTrue: [ valueNode := aNode ] ].
			[ valueNode notNil and: [ valueNode parent isKindOf: GtPharoLiteralNode ] ] whileTrue: [ valueNode := valueNode parent ].
			(valueNode isNil or: [ valueNode isVariableDefinition ]) ifTrue: [ ^ self ] ].
	method := aNode topParent.
	method selector isBinary ifTrue: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Extract as parameter' description: method selector)
		hover: (valueNode ifNotNil: [ self highlightNodeBlock: valueNode ])
		leave: self removeHighlightBlock
		action:
			[ :aCoderViewModel | 
			((GtAddParameterRefactoringController new)
				sourceCoderViewModel: aCoderViewModel;
				parameterNode: valueNode;
				methodNode: method) execute ]
		id: #'context-menu--add-parameter'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addClassAccessorRefactoringsFor: aNode to: coderAddOns [
	aNode isVariable
		ifFalse: [ ^ self ].
	(aNode whoDefines) notNil
		ifTrue: [ ^ self ].
	(self behavior allClassVarNames includes: aNode variableName)
		ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Abstract variable' description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtAbstractClassVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--abstract-variable'.
	(self isAccessorMethodFor: aNode)
		ifFalse: [
			coderAddOns
				addContextMenuItem: (self createLabel: 'Create accessors' description: aNode variableName)
				hover: (self highlightNodeBlock: aNode)
				leave: self removeHighlightBlock
				action: [ :aCoderViewModel |
					(GtCreateClassVariableAccessorsRefactoringController new
						sourceCoderViewModel: aCoderViewModel;
						variableNode: aNode) execute ]
				id: #'context-menu--create-accessors' ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addConvertCascadesToStatementsFor: aNode to: coderAddOns [
	aNode isCascade ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Convert cascade to statements'
				description: (self nodeDescription: aNode))
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel | 
			(GtConvertCascadesToStatementsController new
				node: aNode;
				sourceCoderViewModel: aCoderViewModel) execute ]
		id: #'context-menu--cascades-to-statements'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addConvertStatementsToCascadesFor: nodes to: coderAddOns [
	nodes size > 1 ifFalse: [ ^ self ].
	(nodes allSatisfy: [ :each | each isMessageSend ]) ifFalse: [ ^ self ].
	(nodes allSatisfy: [ :each | each receiver = nodes first receiver ])
		ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Convert statements to cascade'
				description: (self nodeDescription: nodes first))
		hover: (self highlightNodesBlock: nodes)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel | 
			(GtConvertStatementsToCascadesController new
				nodes: nodes;
				sourceCoderViewModel: aCoderViewModel) execute ]
		id: #'context-menu--statements-to-cascade'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addConvertTemporaryToInstanceVariableFor: aNode to: coderAddOns [
	aNode isVariable ifFalse: [ ^ self ].
	(aNode parent isSequence and: [ 
		 aNode parent variables identityIncludes: aNode ]) ifFalse: [ 
		^ self ].
	coderAddOns
		addContextMenuItem: (self
				 createLabel: 'Convert to instance variable'
				 description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtConvertToInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--convert-temp-to-inst-var'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractMethodObjectMenuForAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 215>
	| theNodes |
	theNodes := self extractableNodesFrom: aCoderViewModel.
	theNodes
		ifNotEmpty: [ coderAddOns
				addContextMenuItem: 'Extract method object' asRopedText
				hover: nil
				leave: nil
				action: [ :model | (GtExtractMethodObjectRefactoringController new sourceCoderViewModel: model) execute ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractMethodTo: coderAddOns from: aCoderViewModel [
	| theNodes |
	theNodes := self extractableNodesFrom: aCoderViewModel.
	theNodes
		ifNotEmpty: [ | shortcut |
			(theNodes
				anySatisfy: [ :each | each isMethod or: [ (each nodeOfType: GtPharoMethodPatternNode) notNil ] ])
				ifTrue: [ ^ self ].
			shortcut := GtSourceCoderExtractMethodShortcut new.
			coderAddOns
				addContextMenuItem: shortcut name
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: theNodes first startPosition
						to: theNodes last stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel | 
					shortcut
						performOnEditor: nil
						element: nil
						coderViewModel: aTextualViewModel
						dueTo: nil ]
				id: GtMethodCoderExtractMethodContextMenuItemId
				shortcutKey: shortcut combinationForPlatform gtDisplayString ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractTempFor: aNode to: coderAddOns [
	| nodes sequenceNode |
	(aNode isValueNode
		and: [ aNode isVariable not
				or: [ (aNode isAssignedTo or: [ aNode isDeclaration ]) not
						and: [ aNode whoDefines ifNil: [ true ] ifNotNil: [ :def | def isSequence not ] ] ] ])
		ifFalse: [ ^ self ].
	nodes := OrderedCollection new.
	sequenceNode := aNode statementNode parent.
	sequenceNode
		withAllNodesDo: [ :each | each = aNode ifTrue: [ nodes add: each ] ].
	aNode isVariable
		ifTrue: [ nodes removeAllSuchThat: [ :each | each isDeclaration ] ].
	nodes sort: [ :a :b | a startPosition < b startPosition ].
	[ nodes first statementNode parent ~= sequenceNode ]
		whileTrue: [ nodes removeFirst ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Extract temporary'
				description: (self nodeDescription: aNode))
		hover: (self highlightNodesBlock: nodes)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel | 
			(GtExtractTemporaryRefactoringController new
				node: nodes first;
				sourceCoderViewModel: aCoderViewModel) execute ]
		id: #'context-menu--extract-temp'
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
				action: [ :model | 
					(GtExtractToWrappedMethodObjectRefactoringController new sourceCoderViewModel: model)
						execute ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addHierarchyImplementorsMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 11>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			| highlightNode |
			(node isMessage or: [ node isMessageSend or: [ node isMethodPattern ] ])
				ifTrue: [ highlightNode := node isMessageSend ifTrue: [ node message ] ifFalse: [ node ].
					coderAddOns
						addContextMenuItem: (self
								createLabel: 'Browse hierarchy implementors'
								description: node selector)
						hover: (self highlightNodeBlock: highlightNode)
						leave: self removeHighlightBlock
						action: [ :aTextualViewModel | self perform: #browseHierarchyImplementorsAt: with: highlightNode startPosition ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addHierarchyMessageReferencesMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 16>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			| highlightNode |
			(node isMessage or: [ node isMessageSend or: [ node isMethodPattern ] ])
				ifTrue: [ highlightNode := node isMessageSend ifTrue: [ node message ] ifFalse: [ node ].
					coderAddOns
						addContextMenuItem: (self
								createLabel: 'Browse hierarchy references'
								description: node selector)
						hover: (self highlightNodeBlock: highlightNode)
						leave: self removeHighlightBlock
						action: [ :aTextualViewModel | self perform: #browseHierarchyReferencesAt: with: highlightNode startPosition ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineAllSelfSendsFor: aNode to: coderAddOns [
	| method |
	(aNode isMethod or: [ 
		 aNode isMethodPattern or: [ aNode parent isMethodPattern ] ]) 
		ifFalse: [ ^ self ].
	method := aNode topParent.
	coderAddOns
		addContextMenuItem: (self
				 createLabel: 'Inline All self Sends'
				 description: method selector)
		hover: nil
		leave: nil
		action: [ :aSourceCoderViewModel | 
			(GtInlineSelfSendsRefactoringController new
				 methodNode: method;
				 sourceCoderViewModel: aSourceCoderViewModel) execute ]
		id: #'context-menu--inline-self-sends'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineMessageFor: aNode to: coderAddOns [
	aNode isMessageSend ifFalse: [ ^ self ].
	(aNode receiver isSelf or: [ aNode receiver isSuper ])
		ifTrue: [ coderAddOns
				addContextMenuItem: (self
						createLabel: 'Inline message'
						description: aNode message selector)
				hover: (self highlightNodeBlock: aNode)
				leave: self removeHighlightBlock
				action: [ :aSourceCoderViewModel | 
					(GtMethodInlineMessageSendRefactoringController new
						node: aNode;
						sourceCoderViewModel: aSourceCoderViewModel) execute ]
				id: #'context-menu--inline-message' ]
		ifFalse: [ (GtPharoIndex current implementersOf: aNode selector)
				ifNotEmpty: [ :classes | 
					| defaultClass |
					defaultClass := classes size = 1
							ifTrue: [ classes anyOne methodClass ]
							ifFalse: [ (GtPharoProgramNode
									typeOf: aNode receiver
									in: self behavior
									bindings: nil)
									ifNotNil: [ :cls | cls whichClassIncludesSelector: aNode selector ] ].
					coderAddOns
						addContextMenuItem: (self
								createLabel: 'Inline message'
								description: aNode message selector)
						hover: (self highlightNodeBlock: aNode)
						leave: self removeHighlightBlock
						action: [ :aSourceCoderViewModel | 
							(GtMethodInlineMessageFromComponentRefactoringController new
								implementor: defaultClass;
								node: aNode;
								sourceCoderViewModel: aSourceCoderViewModel) execute ]
						id: #'context-menu--inline-message' ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineParameterRefactoringFor: aNode to: coderAddOns [
	(aNode isVariable and: [ aNode parent isMethodPattern ]) 
		ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem:
		(self
			 createLabel: 'Inline parameter'
			 description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel | 
			(GtInlineParameterRefactoringController new
				 sourceCoderViewModel: aCoderViewModel;
				 variableNode: aNode) execute ]
		id: #'context-menu--inline-parameter'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineTempFor: aNode to: coderAddOns [
	| variable uses definer |
	aNode isAssignment ifTrue: [ variable := aNode variable ].
	aNode isVariable
		ifTrue: [ (aNode parent isAssignment and: [ aNode parent variable == aNode ])
				ifTrue: [ ^ self ].
			variable := aNode ].
	(variable isNil or: [ (definer := variable whoDefines) isNil ])
		ifTrue: [ ^ self ].
	uses := self allReferencesTo: variable.
	uses size < 2 ifTrue: [ ^ self ].
	uses first isDeclaration ifFalse: [ ^ self ].
	uses second isAssignedTo ifFalse: [ ^ self ].
	3 to: uses size do: [ :i | (uses at: i) isAssignedTo ifTrue: [ ^ self ] ].
	uses size >= 3
		ifTrue: [ uses second stopPosition > uses third startPosition ifTrue: [ ^ self ] ].

	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Inline assignment'
				description: variable variableName)
		hover: (self highlightNodesBlock: {uses second parent} , uses)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel | 
			(GtMethodInlineTemporaryVariableRefactoringController new
				node: uses second parent;
				sourceCoderViewModel: aSourceCoderViewModel) execute ]
		id: #'context-menu--inline-temp'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInstanceAccessorRefactoringsFor: aNode to: coderAddOns [
	aNode isVariable
		ifFalse: [ ^ self ].

	(aNode whoDefines: aNode variableName) notNil
		ifTrue: [ ^ self ].

	(self behavior allInstVarNames includes: aNode variableName)
		ifFalse: [ ^ self ].

	coderAddOns
		addContextMenuItem: (self createLabel: 'Abstract variable' description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtAbstractInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--abstract-variable'.
	(self isAccessorMethodFor: aNode)
		ifTrue: [ coderAddOns
				addContextMenuItem: (self createLabel: 'Protect variable' description: aNode variableName)
				hover: (self highlightNodeBlock: aNode)
				leave: self removeHighlightBlock
				action: [ :aCoderViewModel |
					(GtProtectInstanceVariableRefactoringController new
						sourceCoderViewModel: aCoderViewModel;
						variableNode: aNode) execute ]
				id: #'context-menu--protect-variable' ]
		ifFalse: [ coderAddOns
				addContextMenuItem: (self createLabel: 'Create accessors' description: aNode variableName)
				hover: (self highlightNodeBlock: aNode)
				leave: self removeHighlightBlock
				action: [ :aCoderViewModel |
					(GtCreateInstanceVariableAccessorsRefactoringController new
						sourceCoderViewModel: aCoderViewModel;
						variableNode: aNode) execute ]
				id: #'context-menu--create-accessors' ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addMoveMethodRefactoringFor: aNode to: coderAddOns [
	aNode isVariable ifFalse: [ ^ self ].
	aNode whoDefines ifNotNil: [ :node | node isMethod ifFalse: [ ^ self ] ].
	aNode topParent allNodesOfType: GtPharoAssignmentNode do: [ :node | node variable = aNode ifTrue: [ ^ self ] ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Move method into' description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action:
			[ :aCoderViewModel | 
			((GtMoveMethodRefactoringController new)
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--move-method'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addPullDownVariableRefactoringsFor: aNode to: coderAddOns [
	| class |
	aNode isVariable
		ifFalse: [ ^ self ].

	aNode whoDefines notNil
		ifTrue: [ ^ self ].
	
	class := self behavior whichClassDefinesInstVar: aNode variableName.
	(class isNil or: [ class = self behavior ])
		ifTrue: [ ^ self ].

	coderAddOns
		addContextMenuItem: (self createLabel: 'Pull down variable declaration' description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtPushDownInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--pull-down-variable'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addPushDownMethodRefactoringFor: aNode to: coderAddOns [
	| method |
	(aNode isMethod or: [ aNode isMethodPattern or: [ aNode parent isMethodPattern ] ]) 
		ifFalse: [ ^ self ].
	self behavior subclasses isEmpty ifTrue: [ ^ self ].
	method := aNode topParent.
	(self behavior subclasses allSatisfy: [ :each | each includesSelector: method selector ])
		ifTrue: [ ^ self ].
	coderAddOns
		addContextMenuItem:
			(self
				 createLabel: 'Push down method'
				 description: method selector)
		hover: nil
		leave: nil
		action: [ :aCoderViewModel | 
			(GtPushDownMethodRefactoringController new
				 sourceCoderViewModel: aCoderViewModel;
				 methodNode: method) execute ]
		id: #'context-menu--push-down-method'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addPushUpMethodRefactoringFor: aNode to: coderAddOns [
	| method variables |
	(aNode isMethod or: [ aNode isMethodPattern or: [ aNode parent isMethodPattern ] ]) 
		ifFalse: [ ^ self ].
	self behavior superclass isNil ifTrue: [ ^ self ].
	variables := Set withAll: self behavior instVarNames.
	variables addAll: self behavior classVarNames.
	method := aNode topParent.
	method
		allNodesOfType: GtPharoVariableNode
		do: [ :each | (variables includes: each variableName) ifTrue: [ ^ self ] ].
	coderAddOns
		addContextMenuItem:
			(self
				 createLabel: 'Push up method'
				 description: aNode selector)
		hover: nil
		leave: nil
		action: [ :aCoderViewModel | 
			(GtPushUpMethodRefactoringController new
				 sourceCoderViewModel: aCoderViewModel;
				 methodNode: method) execute ]
		id: #'context-menu--push-up-method'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addPushUpVariableRefactoringsFor: aNode to: coderAddOns [
	aNode isVariable
		ifFalse: [ ^ self ].

	aNode whoDefines notNil
		ifTrue: [ ^ self ].

	(self behavior allInstVarNames includes: aNode variableName)
		ifFalse: [ ^ self ].
	
	(self behavior whichClassDefinesInstVar: aNode variableName) superclass = Object 
		ifTrue: [ ^self ].

	coderAddOns
		addContextMenuItem: (self createLabel: 'Push up variable declaration' description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtPushUpInstanceVariableRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--push-up-variable'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRefactoringContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 220>
	self addExtractMethodTo: coderAddOns from: aCoderViewModel.

	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :theNodes | 
			| aNode |
			aNode := theNodes first.

			self addPushUpMethodRefactoringFor: aNode to: coderAddOns.
			self addPushDownMethodRefactoringFor: aNode to: coderAddOns.
			self addMoveMethodRefactoringFor: aNode to: coderAddOns.
			self addAddParameterRefactoringFor: aNode to: coderAddOns.
			self addInlineParameterRefactoringFor: aNode to: coderAddOns.
			self addInlineAllSelfSendsFor: aNode to: coderAddOns.
			self addInstanceAccessorRefactoringsFor: aNode to: coderAddOns.
			self addPushUpVariableRefactoringsFor: aNode to: coderAddOns.
			self addPullDownVariableRefactoringsFor: aNode to: coderAddOns.
			self addClassAccessorRefactoringsFor: aNode to: coderAddOns.
			self addRemoveParameterRefactoringFor: aNode to: coderAddOns.
			self addConvertTemporaryToInstanceVariableFor: aNode to: coderAddOns.
			self addVariableScopingFor: aNode to: coderAddOns.
			aNode
				withAllParentsDo: [ :node | self addInlineMessageFor: node to: coderAddOns ].
			aNode
				withAllParentsDo: [ :node | self addInlineTempFor: node to: coderAddOns ].
			aNode
				withAllParentsDo: [ :node | self addExtractTempFor: node to: coderAddOns ].
			aNode
				withAllParentsDo: [ :node | self addConvertCascadesToStatementsFor: node to: coderAddOns ].
			self addConvertStatementsToCascadesFor: theNodes to: coderAddOns ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRemoveParameterRefactoringFor: aNode to: coderAddOns [
	aNode isVariable
		ifFalse: [ ^ self ].
	aNode parent isMethodPattern
		ifFalse: [ ^ self ].
	aNode parent parent body
		allNodesDo: [ :each | 
			each = aNode
				ifTrue: [ ^ self ] ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Remove parameter' description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel |
			(GtRemoveParameterRefactoringController new
				sourceCoderViewModel: aCoderViewModel;
				variableNode: aNode) execute ]
		id: #'context-menu--remove-parameter'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRenameClassRefactoringFor: aNode to: coderAddOns [
	aNode isVariable ifFalse: [ ^ self ].
	Smalltalk globals
		at: aNode name value asSymbol
		ifPresent: [ :cls | 
			(cls isKindOf: Class)
				ifTrue: [ coderAddOns
						addContextMenuItem: (self
									createLabel: 'Rename class'
									description: aNode variableName)
							hover: (self highlightNodesBlock: (self allReferencesTo: aNode))
							leave: self removeHighlightBlock
							action: [ :aCoderViewModel | self renameClassIn: aCoderViewModel node: aNode ];
						shortcutKey: GtSourceCoderInlineRenameShortcut new combinationForPlatform gtDisplayString ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRenameClassVariableRefactoringFor: aNode to: coderAddOns [
	(aNode isVariable and: [ self isClassVariable: aNode ]) ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Rename class variable'
				description: aNode variableName)
		hover: (self highlightNodesBlock: (self allReferencesTo: aNode))
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel | self renameClassVariableIn: aCoderViewModel node: aNode ]
		id: #'context-menu--rename-class-var'
		shortcutKey: GtSourceCoderInlineRenameShortcut new combinationForPlatform
				gtDisplayString
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRenameInstanceVariableRefactoringFor: aNode to: coderAddOns [
	(aNode isVariable and: [ self isInstanceVariable: aNode ]) ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Rename instance variable'
				description: aNode variableName)
		hover: (self highlightNodesBlock: (self allReferencesTo: aNode))
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel | self renameInstanceVariableIn: aCoderViewModel node: aNode ]
		id: #'context-menu--rename-inst-var'
		shortcutKey: GtSourceCoderInlineRenameShortcut new combinationForPlatform
				gtDisplayString
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRenameMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 200>

	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :theNodes | 
			| aNode |
			aNode := theNodes first.

			self addRenameTemporaryRefactoringFor: aNode to: coderAddOns.
			self addRenameInstanceVariableRefactoringFor: aNode to: coderAddOns.
			self addRenameClassVariableRefactoringFor: aNode to: coderAddOns.
			self addRenameClassRefactoringFor: aNode to: coderAddOns. ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRenameTemporaryRefactoringFor: aNode to: coderAddOns [
	(aNode isVariable and: [ self isLocalVariable: aNode ]) ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Rename local'
				description: aNode variableName)
		hover: (self highlightNodesBlock: (self allReferencesTo: aNode))
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel | self renameTemporaryIn: aCoderViewModel node: aNode ]
		id: #'context-menu--rename-temp'
		shortcutKey: GtSourceCoderInlineRenameShortcut new combinationForPlatform
				gtDisplayString
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addVariableScopingFor: aNode to: coderAddOns [
	| uses groups |
	aNode isVariable ifFalse: [ ^ self ].
	(aNode parent isSequence and: [ 
		 aNode parent variables identityIncludes: aNode ]) ifFalse: [ 
		^ self ].
	uses := OrderedCollection new.
	aNode parent statements do: [ :each | 
		each allNodesOfType: GtPharoVariableNode do: [ :var | 
			var = aNode ifTrue: [ 
				(var parentOfType: GtPharoBlockNode)
					ifNil: [ ^ self ]
					ifNotNil: [ :block | 
						block == (aNode parentOfType: GtPharoBlockNode) ifTrue: [ 
							^ self ] ].
				uses add: var ] ] ].
	groups := uses groupedBy: [ :each | 
		          | parents block |
		          parents := each allParents.
		          1 to: (parents identityIndexOf: aNode parent) - 1 do: [ :i | 
			          ((parents at: i) isKindOf: GtPharoBlockNode) ifTrue: [ 
				          block := parents at: i ] ].
		          block ].
	groups do: [ :each | each first isAssignedTo ifFalse: [ ^ self ] ].
	coderAddOns
		addContextMenuItem: (self
				 createLabel: 'Move declaration to inner scope'
				 description: aNode variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel | 
			(GtMoveVariableRefactoringController new
				 variableNode: aNode;
				 sourceCoderViewModel: aSourceCoderViewModel) execute ]
		id: #'context-menu--move-variable-declaration'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> allReferencesTo: aVariableNode [
	| nodes |
	nodes := OrderedCollection new.
	(aVariableNode whoDefines ifNil: [ aVariableNode topParent ])
		withAllNodesDo: [ :each | each = aVariableNode ifTrue: [ nodes add: each ] ].
	^ nodes sort: [ :a :b | a startPosition < b startPosition ]
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
	((GtCoder forMethod: self compiledMethod)
		openInPagerFrom: anEditorElement)
			maximized
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> buildRemoveMethodLabel: anElement [
	| noReferencesLabel container waitingLabel selectorLabel referencesButton references |

	noReferencesLabel := BrLabel new
		margin: (BlInsets all: 10);
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
		text: 'Remove method?' asRopedText.

	(self isNewMethod or: [ selector isNil ])
		ifTrue: [ ^ noReferencesLabel ].

	references := self selector gtReferences. 
	
	noReferencesLabel text: (selector asRopedText bold, ' is not referenced' asRopedText).

	waitingLabel := BrLabel new
		aptitude: BrGlamorousLabelAptitude new italic;
		margin: (BlInsets all: 10);
		text: 'Searching references...'.

	selectorLabel := BrLabel new
		margin: (BlInsets top: 10 left: 10 bottom: 10 right: 0);
		aptitude: BrGlamorousLabelAptitude new;
		text: (selector asRopedText bold, ' is still referenced in ' asRopedText).

	referencesButton := BrButton new
		aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new glamorousCodeSmallSize;
		beSmallSize;
		margin: (BlInsets top: 10 left: 2 bottom: 10 right: 10);
		label: '0 methods';
		action: [ anElement phlow spawnObject: references ].
		
	container := BrHorizontalPane new
		fitContent;
		withAsyncSinkDo: [ :anElementSink |
			anElementSink
				sink: AsyncCounterSink new;
				whenPending: [ :aContainer :aSink |
					aSink count > 0
						ifTrue: [
							waitingLabel visibility: BlVisibility gone.
							selectorLabel visibility: BlVisibility visible.
							referencesButton visibility: BlVisibility visible ].
					
					referencesButton label: (String streamContents: [ :aStream |
						aStream
							print: aSink count;
							space;
							nextPutAll: ('method' asPluralBasedOn: aSink count);
							nextPutAll: '...' ]) ];
				whenSuccess: [ :aContainer :aSink | 
					waitingLabel visibility: BlVisibility gone.

					aSink count > 0
						ifTrue: [
							selectorLabel visibility: BlVisibility visible.
							referencesButton visibility: BlVisibility visible ]
						ifFalse: [
							selectorLabel visibility: BlVisibility gone.
							referencesButton visibility: BlVisibility gone.
							noReferencesLabel visibility: BlVisibility visible ].

					referencesButton label: (String streamContents: [ :aStream |
						aStream
							print: aSink count;
							space;
							nextPutAll: ('method' asPluralBasedOn: aSink count) ]) ] ].

	container asyncSink forwardStream: references asAsyncStream.

	container addChildren: {
		waitingLabel.
		selectorLabel visibility: BlVisibility gone.
		referencesButton visibility: BlVisibility gone.
		noReferencesLabel visibility: BlVisibility gone
	}.

	^ container
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> copyMethodNameToClipboard [
	self compiledMethod ifNotNil: [ :aCompiledMethod | 
		Clipboard clipboardText: aCompiledMethod printString ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> exampleAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>
	| anExample |
	
	self compiledMethod
		ifNil: [ ^ self ].
	
	anAST methodNode
		ifNil: [ ^ self ].
		
	(anAST methodNode pragmas anySatisfy: [ :each | each isErrorNode not and: [ each selector = #gtExample ] ])
		ifFalse: [ ^ self ].

	coderAddOns addStyler: GtCoderExampleStatusStyler new.

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
						ifAbsent: [ "ignore" ] ]
				ifAbsent: [ "ignore" ].
			
			aCoder := aCoderViewModel coderModel.

			aHandler := [ :anAnnouncement | aCoder example 
				ifNotNil: [ :aNewExample | 
					anElement example: aNewExample; visibility: BlVisibility visible ]
				ifNil: [ 
					anElement visibility: BlVisibility hidden ] ].
			anElement userData 
				at: #exampleAstFor_into_example_handler put: aHandler;
				at: #exampleAstFor_into_example_coder put: aCoder.
			
			(aCoder weak
				when: GtCoderMethodAdded, GtCoderMethodRemoved, GtCoderMethodModified, GtPharoMethodCoderCompiled
				send: #value:
				to: aHandler).
			 
			anElement example: aCoder example ].

	anExample := self example.

	coderAddOns
		addContextAction: 'Play Example' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anEvent | self playExample ]
		id: GtMethodCoderPlayExampleActionId.
	coderAddOns
		addContextAction: 'Play and Inspect Example Result' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | self playAndInspectExample ]
		id: GtMethodCoderPlayAndInspectExampleActionId.
	coderAddOns
		addContextAction: 'Inspect Example Object' translated
		icon: BrGlamorousVectorIcons eg
		action: [ :aCoderUIModel :anEvent | self notifyObjectSpawn: self example ].
	coderAddOns
		addContextAction: 'Debug Example' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :aCoderUIModel :anEvent | self debugExample ]
		id: GtMethodCoderDebugExampleActionId
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> explanationFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>

	self explanationLink notNil
		ifTrue: [ coderAddOns addStyler: self explanationLink ].
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> gtViewAddOnFor: anAST into: coderAddOns viewModel: aGtPharoMethodCoderViewModel [
	<gtAstCoderAddOns: 6>
	| view |
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
				ifFalse: [ view := aGtPharoMethodCoderViewModel selfObject
									perform: self selector
									with: GtPhlowEmptyView new.
							aButton phlow spawnObject: view ] ]
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

	super
		initializeAddOns: addOns
		viewModel: aGtPharoMethodCoderViewModel.

	addOns addStyler: (GtMethodAdviceStyler new isForWorkspace: false).

	addOns addMainAction: (GtCoderCustomAction new stencil: [ 
			 GtPharoMethodCoderSaveButton new pharoMethodCoderViewModel:
				 aGtPharoMethodCoderViewModel ]).
	addOns
		addDropDownWithPreviewAction: 'Remove' translated
		icon: BrGlamorousVectorIcons remove
		action: [ :aButtonElement :aButtonModel :anEvent | self remove ]
		stencil: [ :element | self buildRemoveMethodLabel: element ].
	addOns
		addMainAction: 'Inspect Method' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anElement | 
			self notifyObjectSpawn: aCoderUIModel compiledMethod ].
	addOns
		addMainAction: 'Copy Method Name' translated
		icon: BrGlamorousVectorIcons clipboard
		action: [ :aCoderUIModel :anElement | 
		self copyMethodNameToClipboard ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderPlayShortcut new;
		addShortcut: GtSourceCoderPlayAndInspectShortcut new;
		addShortcut: GtSourceCoderSaveShortcut new;
		addShortcut: GtSourceCoderExtractMethodShortcut new
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
GtPharoMethodCoder >> methodInheritanceFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 1>

	coderAddOns
		addPreview: 'Inheritance'
		stencil: [ GtPharoMethodCoderOverridingOverriddenElement new ]
		dataBinder: [ :anElement :aCoderViewModel | anElement pharoMethodCoderViewModel: aCoderViewModel ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> modifiedMessageAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 1>

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
GtPharoMethodCoder >> slideAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>
	(self compiledMethod notNil
		and: [ anAST notNil
				and: [ 
					anAST methodNode
						ifNotNil: [ :node | 
							node pragmas
								anySatisfy: [ :each | each isErrorNode not and: [ each selector = #gtSlide ] ] ]
						ifNil: [ false ] ] ])
		ifFalse: [ ^ self ].
	(anAST methodNode numArgs = 1) ifFalse: [ ^ self ].
	coderAddOns
		addContextAction: 'Play and Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | self playAndInspectSlide ].
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
GtPharoMethodCoder >> unaryMessageAddOnFor: anAST into: coderAddOns viewModel: aGtPharoMethodCoderViewModel [
	<gtAstCoderAddOns: 20>
	| isUnaryInstanceSideMethod isUnaryClassSideMethod |
	
	self compiledMethod ifNil: [ ^ self ].
	
	isUnaryInstanceSideMethod := aGtPharoMethodCoderViewModel selfObject notNil and: [ 
		anAST methodNode selector isNotNil and: [ anAST methodNode selector isUnary ] ].
	isUnaryClassSideMethod := (anAST notNil
		and: [ anAST methodNode
			ifNotNil: [ :node | node variables isEmpty and: [ self compiledMethod methodClass isClassSide ] ]
			ifNil: [ false ] ] ).
	(isUnaryInstanceSideMethod or: [ isUnaryClassSideMethod ])		
		ifFalse: [ ^ self ].
	coderAddOns
		addContextAction: 'Play' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor playAll
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ].
	coderAddOns
		addContextAction: 'Play and Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor playAllAndInspect
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ].
	coderAddOns
		addContextAction: 'Debug' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :aCoderUIModel :anElement | aCoderUIModel debug ]
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
						ifAbsent: [ "ignore" ] ]
				ifAbsent: [ "ignore" ].
			
			aCoder := aCoderViewModel coderModel.

			aHandler := [ :anAnnouncement | aCoder testCase 
				ifNotNil: [ :aNewTestCase | 
					anElement testCase: aNewTestCase; visibility: BlVisibility visible ]
				ifNil: [ 
					anElement visibility: BlVisibility hidden ] ].
			anElement userData 
				at: #unitTestAstFor_into_testcase_handler put: aHandler;
				at: #unitTestAstFor_into_testcase_coder put: aCoder.
			
			(aCoder weak
				when: GtCoderMethodAdded, GtCoderMethodRemoved, GtCoderMethodModified, GtPharoMethodCoderCompiled
				send: #value:
				to: aHandler).
		
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
		id: GtMethodCoderDebugExampleActionId
]
