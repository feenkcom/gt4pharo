Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addClassAccessorRefactoringsFor: aNode to: coderAddOns [
	aNode isVariable
		ifFalse: [ ^ self ].
	(aNode whoDefines: aNode variableName) notNil
		ifTrue: [ ^ self ].
	(self behavior allClassVarNames includes: aNode variableName)
		ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Abstract variable' description: aNode variableName)
		hover: [ self highlightNode: aNode ]
		leave: [ self removeHighlight ]
		action: [ :element | self abstractClassVar: aNode ].
	(self isAccessorMethodFor: aNode)
		ifFalse: [
			coderAddOns
				addContextMenuItem: (self createLabel: 'Create accessors' description: aNode variableName)
				hover: [ self highlightNode: aNode ]
				leave: [ self removeHighlight ]
				action: [ :element | self createAccessorsFor: aNode instanceVariable: false ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractMethodTo: coderAddOns from: aCoderViewModel [
	| theNodes |
	theNodes := self extractableNodesFrom: aCoderViewModel.

	coderAddOns
		addContextMenuItem: 'Extract method'
		hover: [ self highlightFrom: theNodes first startPosition to: theNodes last stopPosition ]
		leave: [ self removeHighlight ]
		action: [ :aTextualViewModel :anEvent :anEditorElement | self extractMethod: anEditorElement ]
		id: GtMethodCoderExtractMethodContextMenuItemId
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addExtractTempFor: aNode to: coderAddOns [
	aNode isMessageSend
		ifFalse: [ ^ self ].

	coderAddOns
		addContextMenuItem:
			(self
				createLabel: 'Extract temporary'
				description: (self nodeDescription: aNode))
		hover: [ self highlightNode: aNode ]
		leave: [ self removeHighlight ]
		action: [ :aCoderViewModel :anEvent :anEditorElement | self extractTemporaryVariable: aNode in: anEditorElement ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineSelfMessageFor: aNode to: coderAddOns [
	aNode isMessage
		ifFalse: [ ^ self ].
	aNode receiver isSelf
		ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Inline Message' description: aNode selector)
		hover: [ self highlightNode: aNode ]
		leave: [ self removeHighlight ]
		action: [ :element | self inlineMessageSendIn: aNode ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addInlineTempFor: aNode to: coderAddOns [
	aNode isAssignment
		ifFalse: [ ^ self ].
	aNode variable gtIsLocal
		ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem:
			(self
				createLabel: 'Inline Assignment'
				description: aNode variable name)
		hover: [ self highlightNode: aNode ]
		leave: [ self removeHighlight ]
		action: [ :element | self inlineTemporaryVariableIn: aNode ]
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
		hover: [ self highlightNode: aNode ]
		leave: [ self removeHighlight ]
		action: [ :element | self abstractInstVar: aNode ].
	(self isAccessorMethodFor: aNode)
		ifTrue: [ coderAddOns
				addContextMenuItem: (self createLabel: 'Protect variable' description: aNode variableName)
				hover: [ self highlightNode: aNode ]
				leave: [ self removeHighlight ]
				action: [ :element | self protectInstVar: aNode ] ]
		ifFalse: [ coderAddOns
				addContextMenuItem: (self createLabel: 'Create accessors' description: aNode variableName)
				hover: [ self highlightNode: aNode ]
				leave: [ self removeHighlight ]
				action: [ :element | self createAccessorsFor: aNode instanceVariable: true ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRefactoringContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 20>
	
	self addExtractMethodTo: coderAddOns from: aCoderViewModel.
	
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :theNodes | 
			| aNode |
			
			aNode := theNodes first.
			
			self addInstanceAccessorRefactoringsFor: aNode to: coderAddOns.
			"self addClassAccessorRefactoringsFor: aNode to: coderAddOns.
			self addRemoveParameterRefactoringFor: aNode to: coderAddOns.
			aNode
				withAllParentsDo: [ :node | self addInlineSelfMessageFor: node to: coderAddOns ].
			aNode
				withAllParentsDo: [ :node | self addInlineTempFor: node to: coderAddOns ].
			aNode
				withAllParentsDo: [ :node | self addExtractTempFor: node to: coderAddOns ]" ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> addRemoveParameterRefactoringFor: aNode to: coderAddOns [
	aNode isVariable
		ifFalse: [ ^ self ].
	aNode parent isMethod
		ifFalse: [ ^ self ].
	aNode parent body
		nodesDo: [ :each | 
			each = aNode
				ifTrue: [ ^ self ] ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Remove parameter' description: aNode variableName)
		hover: [ self highlightNode: aNode ]
		leave: [ self removeHighlight ]
		action: [ :element | self removeParameter: aNode ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> baselineAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>

	(self behavior inheritsFrom: BaselineOf)
		ifFalse: [ ^ self ].

	coderAddOns addStyler: GtCoderExpandableBaselineStyler new
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> copyMethodNameToClipboard [
	self compiledMethod ifNotNil: [ :aCompiledMethod | 
		Clipboard clipboardText: aCompiledMethod printString ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> explanationFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>

	self explanationLink notNil
		ifTrue: [ coderAddOns addStyler: self explanationLink ].
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> extractMethod: editorElement [
	(GtExtractMethodController new
		coder: self;
		sourceElement: editorElement) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> highlighter [
	<return: #GtSourceReferenceHighlighter>

	^ self attributeNamed: #highlighter
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> highlighterFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 10>
	self highlighter notNil
		ifTrue: [ coderAddOns addStyler: self highlighter ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: GtPharoStyler new.
	addOns addStyler: GtPharoDeprecationStyler new.
	addOns addStyler: GtPharoVariableHighlightStyler new.
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
		action: [ :aCoderUIModel :anEvent | self browseFrom: anEvent currentTarget ].
	addOns
		addMainAction: 'Inspect UI Model' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anEvent | self notifyObjectSpawn: aCoderUIModel ].
	addOns
		addMainAction: 'Copy Method Name' translated
		icon: BrGlamorousVectorIcons clipboard
		action: [ :aCoderUIModel :anEvent | self copyMethodNameToClipboard ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
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

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> modifiedMessageAstFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 1>

	self isModified
		ifFalse: [ ^ self ].

	coderAddOns
		addMainAction: 'Discard Changes' translated
		icon: BrGlamorousVectorIcons cancel
		action: [ :aCoderUIModel :anEvent | aCoderUIModel discardChanges ]
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
GtPharoMethodCoder >> renameAt: aTextPosition in: anEditorElement [
	self
		nodeAt: aTextPosition
		ifFound: [ :aNode | 
			(aNode isMessage or: [ aNode isMethod or: [ aNode isMethodPattern ] ])
				ifTrue: [ ^ self renameMethod: anEditorElement node: aNode ].
			aNode isVariable
				ifTrue: [ aNode isLocallyDefined
						ifTrue: [ ^ anEditorElement textualCoderViewModel renameLocalVariableAt: aTextPosition ].
					(self behavior allInstVarNames includes: aNode name value)
						ifTrue: [ ^ self renameInstanceVariableIn: anEditorElement node: aNode ].
					(self behavior classVariables
						anySatisfy: [ :assoc | assoc key asString = aNode name value ])
						ifTrue: [ ^ self renameClassVariableIn: anEditorElement ].
					Smalltalk globals
						at: aNode name value asSymbol
						ifPresent: [ :cls | 
							(cls isKindOf: Class)
								ifTrue: [ ^ self renameClassIn: anEditorElement ] ] ] ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> renameClassIn: editorElement [
	(GtRenameClassController new
		coder: self;
		sourceElement: editorElement) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> renameClassVariableIn: editorElement [
	(GtRenameClassVariableController new
		coder: self;
		sourceElement: editorElement) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> renameInstanceVariableIn: editorElement node: aVariableNode [
	(GtRenameInstanceVariableController new
		coder: self;
		sourceElement: editorElement;
		originalNode: aVariableNode) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> renameMethod: editorElement node: aMessageOrMethodOrMethodPatternNode [
	(GtRenameMethodController new
		coder: self;
		sourceElement: editorElement;
		originalNode: aMessageOrMethodOrMethodPatternNode) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoMethodCoder >> runGtViewFrom: anElement [
	| view |
	
	self isModified
		ifTrue: [
			self save
				ifFalse: [ ^ self ] ].
	
	view := self object perform: self selector with: GtPhlowEmptyView new.
	anElement phlow spawnObject: view
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
