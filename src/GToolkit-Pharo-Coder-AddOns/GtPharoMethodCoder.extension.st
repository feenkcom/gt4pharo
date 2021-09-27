Extension { #name : 'GtPharoMethodCoder' }

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addAddParameterRefactoringFor: aNode to: coderAddOns [
	| method |
	(aNode isMethod or: [ 
		 aNode isMethodPattern or: [ aNode parent isMethodPattern ] ]) 
		ifFalse: [ ^ self ].
	method := aNode topParent.
	method selector isBinary ifTrue: [ ^ self ].
	coderAddOns
		addContextMenuItem:
		(self createLabel: 'Add parameter' description: aNode selector)
		hover: nil
		leave: nil
		action: [ :aCoderViewModel | 
			(GtAddParameterRefactoringController new
				 sourceCoderViewModel: aCoderViewModel;
				 methodNode: method) execute ]
		id: #'context-menu--add-parameter'
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractMethodTo: coderAddOns from: aCoderViewModel [
	| theNodes |
	theNodes := self extractableNodesFrom: aCoderViewModel.
	theNodes
		ifNotEmpty: [
			(theNodes anySatisfy: [ :each | 
				 each isMethod or: [ (each nodeOfType: GtPharoMethodPatternNode) notNil ] ]) 
				ifTrue: [ ^ self ].
			coderAddOns
				addContextMenuItem: 'Extract method'
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: theNodes first startPosition
						to: theNodes last stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel | (GtExtractMethodController new sourceCoderViewModel: aTextualViewModel) execute ]
				id: GtMethodCoderExtractMethodContextMenuItemId ]
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractTempFor: aNode to: coderAddOns [
	(aNode isValueNode and: [ aNode isVariable not ])
		ifFalse: [ ^ self ].

	coderAddOns
		addContextMenuItem:
			(self
				createLabel: 'Extract temporary'
				description: (self nodeDescription: aNode))
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel | self extractTemporaryVariable: aNode in: aCoderViewModel ]
		id: #'context-menu--extract-temp'
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineSelfMessageFor: aNode to: coderAddOns [
	aNode isMessageSend
		ifFalse: [ ^ self ].
	aNode receiver isSelf
		ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Inline Message' description: aNode message selector)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel |
			(GtMethodInlineMessageSendRefactoringController new
				node: aNode;
				sourceCoderViewModel: aSourceCoderViewModel) execute ]
		id: #'context-menu--inline-message'
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineTempFor: aNode to: coderAddOns [
	aNode isAssignment
		ifFalse: [ ^ self ].
	aNode variable whoDefines
		ifNil: [ ^ self ].
	
	coderAddOns
		addContextMenuItem: (self createLabel: 'Inline Assignment' description: aNode variable variableName)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aSourceCoderViewModel |
			(GtMethodInlineTemporaryVariableRefactoringController new
				node: aNode;
				sourceCoderViewModel: aSourceCoderViewModel) execute ]
		id: #'context-menu--inline-temp'
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
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
				 description: aNode selector)
		hover: nil
		leave: nil
		action: [ :aCoderViewModel | 
			(GtPushDownMethodRefactoringController new
				 sourceCoderViewModel: aCoderViewModel;
				 methodNode: method) execute ]
		id: #'context-menu--push-down-method'
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRefactoringContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 20>
	
	self addExtractMethodTo: coderAddOns from: aCoderViewModel.
	
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :theNodes | 
			| aNode |
			
			aNode := theNodes first.
			
			self addPushUpMethodRefactoringFor: aNode to: coderAddOns.
			self addPushDownMethodRefactoringFor: aNode to: coderAddOns.
			self addAddParameterRefactoringFor: aNode to: coderAddOns.
			self addInlineAllSelfSendsFor: aNode to: coderAddOns.
			self addInstanceAccessorRefactoringsFor: aNode to: coderAddOns.
			self addClassAccessorRefactoringsFor: aNode to: coderAddOns.
			self addRemoveParameterRefactoringFor: aNode to: coderAddOns.
			self addConvertTemporaryToInstanceVariableFor: aNode to: coderAddOns. 
			self addVariableScopingFor: aNode to: coderAddOns.
			aNode
				withAllParentsDo: [ :node | self addInlineSelfMessageFor: node to: coderAddOns ].
			aNode
				withAllParentsDo: [ :node | self addInlineTempFor: node to: coderAddOns ].
			aNode
				withAllParentsDo: [ :node | self addExtractTempFor: node to: coderAddOns ] ]
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> baselineAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>

	(self behavior inheritsFrom: BaselineOf)
		ifFalse: [ ^ self ].

	coderAddOns addStyler: GtCoderExpandableBaselineStyler new
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> copyMethodNameToClipboard [
	self compiledMethod ifNotNil: [ :aCompiledMethod | 
		Clipboard clipboardText: aCompiledMethod printString ]
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> exampleAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>
	
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

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> explanationFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>

	self explanationLink notNil
		ifTrue: [ coderAddOns addStyler: self explanationLink ].
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> extractableNodesFrom: aCoderViewModel [
	| allSelections allCursors |

	allSelections := aCoderViewModel selection allSelections.
	allCursors := aCoderViewModel cursors allCursors.

	^ allSelections size = 1
		ifTrue: [ self extractableNodesWithin: allSelections first interval ]
		ifFalse: [ allCursors size = 1
			ifTrue: [ self extractableNodesAt: allCursors first position ]
			ifFalse: [ #() ] ]
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> gtViewAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 6>
	(self hasObjectAttribute
		and: [ anAST notNil
				and: [ anAST methodNode
						ifNotNil: [ :node | 
							node arguments size = 1
								and: [ node pragmas
										anySatisfy:
											[ :each | each isParseError not and: [ each selector = #gtView ] ] ] ]
						ifNil: [ false ] ] ])
		ifFalse: [ ^ self ].

	coderAddOns
		addContextAction: 'gtView' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | self runGtViewFrom: anEvent currentTarget ]
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> highlighter [
	<return: #GtSourceReferenceHighlighter>

	^ self attributeNamed: #highlighter
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> highlighterFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>
	self highlighter notNil
		ifTrue: [ coderAddOns addStyler: self highlighter ]
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: GtPharoStyler new.
	addOns addStyler: GtPharoDeprecationStyler new.
	addOns addStyler: GtPharoDynamicHighlightStyler new.
	addOns addStyler: GtPharoMethodExpanderStyler new.
	addOns addStyler: (GtFixItStyler new isForWorkspace: false).

	"addOns addStyler: GtCoderCommentStyler new."

	addOns
		addMainAction: (GtCoderActivatableAction new
			id: GtMethodCoderSaveActionId;
			title: 'Save' translated;
			icon: BrGlamorousVectorIcons accept;
			action: [ :aCoderUIModel :anEvent | aCoderUIModel save ];
			enabled: [ :aCoderUIModel | aCoderUIModel isSaveEnabled ];
			updateWhen: GtMethodCoderSaveAbilityChanged).
	addOns
		addDropDownWithPreviewAction: 'Remove' translated
		icon: BrGlamorousVectorIcons remove
		action: [ :aButtonElement :aButtonModel :anEvent | self remove ]
		stencil: [ :element | self buildRemoveMethodLabel: element ].
	addOns
		addMainAction: 'Browse' translated
		icon: BrGlamorousVectorIcons browse
		action: [ :aCoderUIModel :anElement | self browseFrom: anElement ].
	addOns
		addMainAction: 'Inspect Method' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anElement | self notifyObjectSpawn: aCoderUIModel compiledMethod ].
	addOns
		addMainAction: 'Copy Method Name' translated
		icon: BrGlamorousVectorIcons clipboard
		action: [ :aCoderUIModel :anElement | self copyMethodNameToClipboard ]
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderPlayShortcut new;
		addShortcut: GtSourceCoderPlayAndInspectShortcut new;
		addShortcut: GtSourceCoderExtractMethodShortcut new;
		addShortcut: GtSourceCoderSaveShortcut new;
		addShortcut: GtSourceCoderFormatShortcut new;
		addShortcut: GtSourceCoderInlineRenameShortcut new
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> runGtViewFrom: anElement [
	| view |
	
	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ self ] ].
	
	view := self object perform: self selector with: GtPhlowEmptyView new.
	anElement phlow spawnObject: view
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
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
