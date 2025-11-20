Extension { #name : #GtPharoSourceCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addBaselinePackageMenuItemsFor: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(aCoderViewModel behavior inheritsFrom: BaselineOf) ifFalse: [ ^ self ].
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			node isLiteral ifFalse: [ ^ self ].
			node gtIsBaselinePackageName
				ifTrue: [ (coderAddOns
						addContextMenuItem: (self
								createLabel: 'Rename package'
								description: node literalValue)
						group: BrMenuItemGroupConfiguration refactoring
						hover: (self highlightNodeBlock: node)
						leave: self removeHighlightBlock
						action: [ :aTextualViewModel :element | 
							self
								renamePackage: node
								in: aTextualViewModel
								from: element ]
						shortcutKey: GtRenameInBaselineShortcut new combinationForPlatform
								gtDisplayString) ifNotNil: [ :anAction | anAction priority: 5 ].
					(coderAddOns
						addContextMenuItem: (self
								createLabel: 'Browse package'
								description: node literalValue)
						group: BrMenuItemGroupConfiguration navigation
						hover: (self highlightNodeBlock: node)
						leave: self removeHighlightBlock
						action: [ :model :element | 
							element phlow
								spawnTool: (GtPackageCoderTool
										forPackage: (self packageOrganizer packageNamed: node literalValue)) ])
						ifNotNil: [ :anAction | anAction priority: 5 ] ]
				ifFalse: [ node gtIsBaselineName
						ifTrue: [ (coderAddOns
								addContextMenuItem: (self
										createLabel: 'Rename baseline class'
										description: node literalValue)
								group: BrMenuItemGroupConfiguration refactoring
								hover: (self highlightNodeBlock: node)
								leave: self removeHighlightBlock
								action: [ :aTextualViewModel :element | 
									self
										renameBaseline: node
										in: aTextualViewModel
										for: element ]
								shortcutKey: GtRenameInBaselineShortcut new combinationForPlatform
										gtDisplayString) ifNotNil: [ :anAction | anAction priority: 5 ].
							(coderAddOns
								addContextMenuItem: (self
										createLabel: 'Browse baseline'
										description: node literalValue)
								group: BrMenuItemGroupConfiguration navigation
								hover: (self highlightNodeBlock: node)
								leave: self removeHighlightBlock
								action: [ :model :element | 
									self class environment
										at: ('BaselineOf' , node literalValue) asSymbol
										ifPresent: [ :cls | element phlow spawnTool: (GtClassCoderTool observedClass: cls) ] ])
								ifNotNil: [ :anAction | anAction priority: 5 ] ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addClassMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :nodes | 
			(self
				addClassNodeLinkMenuAddOnsTo: coderAddOns
				group: BrMenuItemGroupConfiguration navigation
				node: nodes first
				selector: #browseBehaviorAt:requesterObject:
				shortcut: GtSourceCoderBrowseBehaviorShortcut new
				requesterObject: aCoderViewModel)
				ifNotNil: [ :anAction | anAction priority: 13.01 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addClassNodeLinkMenuAddOnsTo: coderAddOns group: menuGroup node: node selector: sel shortcut: aShortcut requesterObject: aRequester [
	<return: #GtCoderContextMenuAction or: nil>
	| foundClass |


	node isVariable ifFalse: [ ^ nil ].
	self
		variableNodeToBehavior: node
		ifFound: [ :aClass | foundClass := aClass ]
		ifNone: [ ^ nil ].

	^ coderAddOns
		addContextMenuItem: (self
			createLabel: aShortcut name 
			description: foundClass name)
		group: menuGroup
		hover: (self highlightNodeBlock: node)
		leave: self removeHighlightBlock
			action: [ :aTextualViewModel | 
				self
					perform: sel
					with: node startPosition
					with: aRequester  ]
		shortcutKey: aShortcut  combinationForPlatform gtDisplayString 
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addClassNodeLinkMenuAddOnsTo: coderAddOns node: node selector: sel shortcut: aShortcut requesterObject: aRequester [
	<return: #GtCoderContextMenuAction or: nil>
	| foundClass |

	node isVariable ifFalse: [ ^ nil ].
	self
		variableNodeToBehavior: node
		ifFound: [ :aClass | foundClass := aClass ]
		ifNone: [ ^ self ].

	^ coderAddOns
		addContextMenuItem: (self
			createLabel: aShortcut name 
			description: foundClass name)
		hover: (self highlightNodeBlock: node)
		leave: self removeHighlightBlock
			action: [ :aTextualViewModel | 
				self
					perform: sel
					with: node startPosition
					with: aRequester  ]
		shortcutKey: aShortcut  combinationForPlatform gtDisplayString 
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addClassPhlowMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	| nodes node foundClass |
	nodes := self extractableNodesFrom: aCoderViewModel.
	nodes ifEmpty: [ ^ self ].
	node := nodes first.

	node isVariable ifFalse: [ ^ nil ].
	self
		variableNodeToBehavior: node
		ifFound: [ :aClass | foundClass := aClass ]
		ifNone: [ ^ self ].

	(coderAddOns
		addContextMenu: (self
				createLabel: ('{1} actions'
						format: {foundClass isTrait ifTrue: [ 'Trait' ] ifFalse: [ 'Class' ]})
				description: foundClass name)
		icon: BrGlamorousVectorIcons empty
		submenu: [ :theCoderViewModel :aTextualCoderEditorElement | 
			GtCoderClassTarget 
				menuItemsForObject: foundClass 
				hostElement: aTextualCoderEditorElement ])
		ifNotNil: [ :anAction | anAction priority: 50 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addClassReferencesMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :nodes | 
			(self
				addClassNodeLinkMenuAddOnsTo: coderAddOns
				group: BrMenuItemGroupConfiguration navigation
				node: nodes first
				selector: #browseReferencesAt:requesterObject:
				shortcut: GtSourceCoderBrowseReferencesShortcut new
				requesterObject: aCoderViewModel)
				ifNotNil: [ :anAction | anAction priority: 13.02 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addEvaluateAddonsTo: anAst to: coderAddOns [
	<gtCoderContextMenuAddOns>
	(self
		addContextMenuItemFrom: GtSourceCoderDoItAndInspectShortcut new
		group: BrMenuItemGroupConfiguration evaluation
		withId: GtSourceCoderDoItAndGoActionId
		to: coderAddOns) ifNotNil: [ :anAction | anAction priority: 800 ].
	(self
		addContextMenuItemFrom: GtSourceCoderDoItShortcut new
		group: BrMenuItemGroupConfiguration evaluation
		withId: nil
		to: coderAddOns) ifNotNil: [ :anAction | anAction priority: 800 ].
	(self
		addContextMenuItemFrom: GtSourceCoderPrintItShortcut new
		group: BrMenuItemGroupConfiguration evaluation
		withId: nil
		to: coderAddOns) ifNotNil: [ :anAction | anAction priority: 800 ].
	(self
		addContextMenuItemFrom: GtSourceCoderDebugShortcut new
		group: BrMenuItemGroupConfiguration evaluation
		withId: nil
		to: coderAddOns) ifNotNil: [ :anAction | anAction priority: 800 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addFormatMethodAst: anAst to: coderAddOns [
	<gtCoderContextMenuAddOns>
	(self
		addContextMenuItemFrom: GtSourceCoderFormatShortcut new
		group: BrMenuItemGroupConfiguration refactoring
		withId: nil
		to: coderAddOns) ifNotNil: [ :anAction | anAction priority: 250 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addImplementorsMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			(self
				addLinkMenuAddOnsTo: coderAddOns
				group: BrMenuItemGroupConfiguration navigation
				node: node
				selector: #browseImplementorsAt:requesterObject:
				shortcut: GtSourceCoderBrowseImplementorsShortcut new
				requesterObject: aCoderViewModel)
				ifNotNil: [ :anAction | anAction priority: 10 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addInstanceVariableFilterAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	"<gtCoderContextMenuAddOns: 11>"
	<return: #GtCoderContextMenuAction or: nil>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			(node isVariable and: [ self isInstanceVariable: node ]) ifFalse: [ ^ self ].
			^ coderAddOns
				addContextMenuItem: (self
						createLabel: 'Filter methods by references to'
						description: node name value)
				hover: (self highlightNodeBlock: node)
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel | 
					self 
						announce: (GtClassCoderSlotNavigationAnnouncement new
								source: self;
								slot: node name value) ]
				id: nil ].
				
	^ nil
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addInstanceVariableReferencesMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			(node isVariable and: [ self isInstanceVariable: node ]) ifFalse: [ ^ self ].
			(aCoderViewModel behavior whichClassDefinesInstVar: node name value)
				ifNotNil: [ :definer | 
					(coderAddOns
						addContextMenuItem: (self
								createLabel: 'Browse defining class'
								description: definer name)
						group: BrMenuItemGroupConfiguration navigation
						hover: (self highlightNodeBlock: node)
						leave: self removeHighlightBlock
						action: [ :aTextualViewModel | 
							self
								notifyToolSpawn: (GtClassCoderTool observedClass: definer)
								withDestination: self spawnDestination
								requesterObject: aCoderViewModel ]
						id: nil) ifNotNil: [ :anAction | anAction priority: 12 ] ].
			(coderAddOns
				addContextMenuItem: (self
						createLabel: 'Browse references'
						description: node name value)
				group: BrMenuItemGroupConfiguration navigation
				hover: (self highlightNodeBlock: node)
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel | self browseReferencesAt: node startPosition requesterObject: aTextualViewModel ]
				id: nil
				shortcutKey: GtSourceCoderBrowseReferencesShortcut new
						combinationForPlatform gtDisplayString)
				ifNotNil: [ :anAction | anAction priority: 12 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addMessageReferencesMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			(self
				addLinkMenuAddOnsTo: coderAddOns
				group: BrMenuItemGroupConfiguration navigation
				node: node
				selector: #browseReferencesAt:requesterObject:
				shortcut: GtSourceCoderBrowseReferencesShortcut new
				requesterObject: aCoderViewModel)
				ifNotNil: [ :anAction | anAction priority: 15 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addPackageRenameShortcutFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 3>
	(self behavior inheritsFrom: BaselineOf) ifFalse: [ ^ self ].
	coderAddOns addShortcut: GtRenameInBaselineShortcut new
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addRenameMethodAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			| highlightNode |
			(node isMessage or: [ node isMessageSend or: [ node isMethodPattern ] ])
				ifFalse: [ ^ self ].
			highlightNode := node isMessageSend
					ifTrue: [ node message ]
					ifFalse: [ node ].
			(coderAddOns
				addContextMenuItem: (self
						createLabel: 'Rename message'
						description: node selector)
				group: BrMenuItemGroupConfiguration refactoring
				hover: (self highlightNodeBlock: highlightNode)
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel :element | 
					self
						renameNode: node
						in: aTextualViewModel
						for: element ]
				shortcutKey: GtSourceCoderInlineRenameShortcut new combinationForPlatform
						gtDisplayString) ifNotNil: [ :anAction | anAction priority: 205 ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> allReferencesTo: aVariableNode [
	| nodes |
	nodes := OrderedCollection new.
	(aVariableNode whoDefines ifNil: [ aVariableNode topParent ])
		withAllNodesDo: [ :each | each = aVariableNode ifTrue: [ nodes add: each ] ].
	^ nodes sort: [ :a :b | a startPosition < b startPosition ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseBehaviorAt: aTextPosition requesterObject: aRequester [
	"Try to find a behavior reference at a given source text position and request to browse it"

	self
		detectBehaviorAt: aTextPosition
		ifFound: [ :aBehavior | 
			self
				notifyToolSpawn: (GtClassCoderTool observedClass: aBehavior)
				withDestination: self spawnDestination
				requesterObject: aRequester ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseBehaviorIn: aSourceString requesterObject: aRequestor [
	"Try to find a behavior reference within a given source code and request to browse it"

	self
		detectBehaviorIn: aSourceString
		ifFound: [ :aBehavior | 
			self
				notifyToolSpawn: (GtClassCoderTool observedClass: aBehavior)
				withDestination: self spawnDestination
				requesterObject: aRequestor ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseImplementorsAt: aTextPosition requesterObject: aRequester [
	"Try to find a message selector at a given source text position and request to browse it"

	self
		detectSelectorAt: aTextPosition
		ifFound: [ :aSelector :anAstNode | 
			self
				notifyObjectSpawn: (GtSearchImplementorsFilter new
						selector: aSelector;
						requesterContext: (self newFilterContext
							nodeInPosition: anAstNode;
							selectorInPosition: aSelector))
				requesterObject: aRequester ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseImplementorsIn: aSourceString requesterObject: aRequester [
	"Try to find a message selector within a given source string and request to browse it"

	self
		detectSelectorIn: aSourceString
		ifFound: [ :aSelector :anAstNode | 
			self
				notifyObjectSpawn: (GtSearchImplementorsFilter new
						selector: aSelector;
						requesterContext: (self newFilterContext
							nodeInPosition: anAstNode;
							selectorInPosition: aSelector))
				requesterObject: aRequester ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseReferencesAt: aTextPosition requesterObject: aRequester [
	"Try to create a references filter for an entity at the given text position and request to browse it"

	self
		notifyObjectSpawn: (self
				detectReferencesFilterAt: aTextPosition
				ifFound: [ :aReferencesFilter :anAstNode | aReferencesFilter 
					requesterContext: (self newFilterContext
							nodeInPosition: anAstNode) ]
				ifNone: [ GtSearchNullFilter new ])
		requesterObject: aRequester
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseReferencesIn: aSourceString requesterObject: aRequester [
	"Try to create a references filter for an entity within a given source string and request to browse it"

	self
		notifyObjectSpawn: (self
				detectReferencesFilterIn: aSourceString
				ifFound: [ :aReferencesFilter :anAstNode | aReferencesFilter 
					requesterContext: (self newFilterContext
							nodeInPosition: anAstNode) ]
				ifNone: [ GtSearchNullFilter new ])
		requesterObject: aRequester
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> cascadeMessageToSplitAfter: aCoderViewModel [
	| node cursors splitBeforeMessage position |
	cursors := aCoderViewModel cursors allCursors.
	cursors size = 1 ifFalse: [ ^ nil ].
	position := cursors first position.
	node := self nodeAt: position.
	node ifNil: [ ^ nil ].
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
	^ splitBeforeMessage
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> colorAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoColorStyler new.
	coderAddOns addStyler: GtPharoGlamorousColorStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> glamorousIconsAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoGlamorousIconStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> highlightNodesBlock: aCollection [
	^ [ :textualCoderViewModel | 
	aCollection
		do: [ :each | (self highlightNodeBlock: each) value: textualCoderViewModel ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> initializeAddOns: addOns [
	| stylers |
	super initializeAddOns: addOns.
	stylers := {
		GtPharoStyler.
		GtPharoDynamicHighlightStyler.
		GtPharoDeprecationStyler.
		GtPharoMethodExpanderStyler.
		GtPharoClassExpanderStyler.
		GtPharoHidingStyler} collect: #new.
	addOns addStylers: stylers
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> initializeShortcuts: addOns [
	| shortcuts |
	super initializeShortcuts: addOns.

	shortcuts := {
			GtSourceCoderBrowseImplementorsShortcut.
			GtSourceCoderBrowseReferencesShortcut.
			GtSourceCoderBrowseBehaviorShortcut.
			GtSourceCoderFormatShortcut.
			GtSourceCoderDebugShortcut.
			GtSourceCoderInlineRenameShortcut.
			GtSourceCoderMoveStatementUpShortcut.
			GtSourceCoderMoveStatementDownShortcut.
			GtSourceCoderSelectStatementUpShortcut.
			GtSourceCoderSelectStatementDownShortcut.
			GtSourceCoderFixItShortcut.
			GtSourceCoderPrintItShortcut.
			GtSourceCoderFoldNoiseShortcut} collect: #new.

	addOns addShortcuts: shortcuts
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> isClassVariable: aNode [
	^ self behavior classVariables
		anySatisfy: [ :assoc | assoc key asString = aNode name value ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> isInstanceVariable: aNode [
	^ self behavior allInstVarNames includes: aNode name value
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> isLocalVariable: aNode [
	^ aNode isLocallyDefined
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> newFilterContext [
	^ super newFilterContext 
		behavior: self behavior
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> nodeAfter: aStatementNodeCollection [
	| siblings index nextNode |
	siblings := aStatementNodeCollection any parent statements.
	index := siblings indexOf: aStatementNodeCollection last.
	index = siblings size ifFalse: [ nextNode := siblings at: index + 1 ].
	^ nextNode
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> nonBreakableSpaceAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoNonBreakableSpaceStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> passwordHiddingAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoMethodPasswordStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> removeRefactoringAttribute [
	self sourceText
		clearAttributes: [ :each | each class = GtRefactoringChangesAttribute ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameAt: aTextPosition in: aSourceCoderViewModel for: anElement [
	self
		nodeAt: aTextPosition
		ifFound: [ :aNode | 
			self
				renameNode: aNode
				in: aSourceCoderViewModel
				for: anElement ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameBaseline: node in: aTextualViewModel for: anElement [
	(GtRenameBaselineInMethodController new
		sourceCoderViewModel: aTextualViewModel;
		originalNode: node) executeIn: anElement
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameBaselineAt: anIndex in: aCoderViewModel for: anElement [
	(aCoderViewModel behavior inheritsFrom: BaselineOf) ifFalse: [ ^ false ].
	(self nodeAt: anIndex)
		ifNotNil: [ :node | 
			(node isLiteral and: [ node gtIsBaselineName ]) ifFalse: [ ^ false ].
			self
				renameBaseline: node
				in: aCoderViewModel
				for: anElement.
			^ true ].
	^ false
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameClassIn: aSourceCoderViewModel node: aVariableNode for: anElement [
	(GtRenameClassController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode) executeIn: anElement
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameClassVariableIn: aSourceCoderViewModel node: aVariableNode for: anElement [
	(GtRenameClassVariableController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode) executeIn: anElement
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameInstanceVariableControllerIn: aSourceCoderViewModel for: aVariableNode [
	(Pragma allNamed: #gtRenameInstanceVariableController)
		do: [ :each | 
			each method methodClass isClassSide
				ifTrue: [ (each method methodClass instanceSide
						perform: each method selector
						withArguments: {aSourceCoderViewModel.
								aVariableNode}) ifNotNil: [ :controller | ^ controller ] ] ].
	^ GtRenameInstanceVariableController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameInstanceVariableIn: aSourceCoderViewModel node: aVariableNode for: anElement [
	(self
		renameInstanceVariableControllerIn: aSourceCoderViewModel
		for: aVariableNode) executeIn: anElement
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameMethod: aSourceCoderViewModel node: aMessageOrMethodOrMethodPatternNode for: anElement [
	(self
		renameMethodControllerIn: aSourceCoderViewModel
		for: aMessageOrMethodOrMethodPatternNode) executeIn: anElement
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameMethodControllerIn: aSourceCoderViewModel for: aMessageOrMethodOrMethodPatternNode [
	(Pragma allNamed: #gtRenameMethodController)
		do: [ :each | 
			each method methodClass isClassSide
				ifTrue: [ (each method methodClass instanceSide
						perform: each method selector
						withArguments: {aSourceCoderViewModel.
								aMessageOrMethodOrMethodPatternNode})
						ifNotNil: [ :controller | ^ controller ] ] ].
	^ GtRenameMethodController2 new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aMessageOrMethodOrMethodPatternNode
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameNode: aNode in: aSourceCoderViewModel for: anElement [
	(aNode isMessage or: [ aNode isMethod or: [ aNode isMethodPattern ] ])
		ifTrue: [ ^ self
				renameMethod: aSourceCoderViewModel
				node: aNode
				for: anElement ].
	aNode isVariable
		ifTrue: [ (self isLocalVariable: aNode)
				ifTrue: [ ^ self renameTemporaryIn: aSourceCoderViewModel node: aNode ].
			(self isInstanceVariable: aNode)
				ifTrue: [ ^ self
						renameInstanceVariableIn: aSourceCoderViewModel
						node: aNode
						for: anElement ].
			(self isClassVariable: aNode)
				ifTrue: [ ^ self
						renameClassVariableIn: aSourceCoderViewModel
						node: aNode
						for: anElement ].
			Smalltalk globals
				at: aNode name value asSymbol
				ifPresent: [ :cls | 
					(cls isKindOf: Class)
						ifTrue: [ ^ self
								renameClassIn: aSourceCoderViewModel
								node: aNode
								for: anElement ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renamePackage: node in: aTextualViewModel from: anElement [
	(GtRenamePackageInBaselineController new
		sourceCoderViewModel: aTextualViewModel;
		originalNode: node) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renamePackageAt: anIndex in: aCoderViewModel from: anElement [
	(aCoderViewModel behavior inheritsFrom: BaselineOf) ifFalse: [ ^ false ].
	(self nodeAt: anIndex)
		ifNotNil: [ :node | 
			(node isLiteral and: [ node gtIsBaselinePackageName ]) ifFalse: [ ^ false ].
			self
				renamePackage: node
				in: aCoderViewModel
				from: anElement.
			^ true ].
	^ false
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameTemporaryIn: aSourceCoderViewModel node: aVariableNode [
	| action locations announcement definer otherCoders renameAttributes originalSource |
	originalSource := (aSourceCoderViewModel styledText
			ifNil: [ aSourceCoderViewModel sourceText ])
			from: aVariableNode startPosition
			to: aVariableNode stopPosition.
	locations := OrderedCollection new.
	definer := aVariableNode whoDefines.
	announcement := GtCoderRenameTemporaryRequestedAnnouncement new.
	definer isNil
		ifTrue: [ announcement variableName: aVariableNode name source.
			self announce: announcement ].
	otherCoders := announcement interestedCoders reject: [ :each | each == self ].
	(definer ifNil: [ aVariableNode topParent ])
		withAllNodesDo: [ :each | each = aVariableNode ifTrue: [ locations add: each name sourceInterval ] ].
	action := GtCoderViewModelRenameAction
			locations: locations
			textualCoderViewModel: aSourceCoderViewModel.
	action selectAll: true.
	action forVariableOrUnaryMessage.
	renameAttributes := OrderedCollection new.
	otherCoders
		do: [ :each | 
			each
				implicitVariableReferencesTo: aVariableNode variableName
				do: [ :node | 
					| attribute |
					attribute := GtRenamePreviewAttribute new text: originalSource.
					(each currentSourceText from: node startPosition to: node stopPosition)
						attributes: {attribute}.
					renameAttributes add: attribute ].
			each sourceChangedTo: each currentSourceText ].
	action
		when: GtRenameActionAnnouncement
		do: [ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ renameAttributes
						do: [ :each | each updateText: ann renameAction newName asRopedText ] ].
			ann eventType = #uninstall
				ifTrue: [ otherCoders
						do: [ :each | 
							each currentSourceText
								clearAttributes: [ :attr | attr isKindOf: GtRenamePreviewAttribute ].
							each sourceChangedTo: each currentSourceText ] ].
			ann eventType = #accept
				ifTrue: [ otherCoders
						do: [ :each | each renameImplicitTemporary: aVariableNode variableName to: action newName ] ] ]
		for: self.
	action install.
	^ action
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> whenSendToAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoWhenSendToExpanderStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> zincFormSecretsHiddingAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoZincApplicationFormUrlEncodedEntityStyler new.
]
