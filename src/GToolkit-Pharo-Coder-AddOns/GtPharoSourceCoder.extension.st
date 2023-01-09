Extension { #name : #GtPharoSourceCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addBaselinePackageMenuItemsFor: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 5>
	(aCoderViewModel behavior inheritsFrom: BaselineOf) ifFalse: [ ^ self ].
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			node isLiteral ifFalse: [ ^ self ].
			node gtIsBaselinePackageName
				ifTrue: [ coderAddOns
						addContextMenuItem: (self
									createLabel: 'Rename package'
									description: node literalValue)
							hover: [ :textualCoderViewModel | 
								textualCoderViewModel
									addTextAttribute: self class nodeHighlight
									from: node startPosition
									to: node stopPosition ]
							leave: self removeHighlightBlock
							action: [ :aTextualViewModel | self renamePackage: node in: aTextualViewModel ]
							shortcutKey: GtRenameInBaselineShortcut new combinationForPlatform
									gtDisplayString;
						addContextMenuItem: (self
									createLabel: 'Browse package'
									description: node literalValue)
							hover: [ :textualCoderViewModel | 
								textualCoderViewModel
									addTextAttribute: self class nodeHighlight
									from: node startPosition
									to: node stopPosition ]
							leave: self removeHighlightBlock
							action: [ :model :element | 
								element phlow
									spawnTool: (GtPackageCoderTool
											package: (RPackageOrganizer default packageNamed: node literalValue)) ] ]
				ifFalse: [ node gtIsBaselineName
						ifTrue: [ coderAddOns
								addContextMenuItem: (self
											createLabel: 'Rename baseline class'
											description: node literalValue)
									hover: [ :textualCoderViewModel | 
										textualCoderViewModel
											addTextAttribute: self class nodeHighlight
											from: node startPosition
											to: node stopPosition ]
									leave: self removeHighlightBlock
									action: [ :aTextualViewModel | self renameBaseline: node in: aTextualViewModel ]
									shortcutKey: GtRenameInBaselineShortcut new
											combinationForPlatform gtDisplayString;
								addContextMenuItem: (self
											createLabel: 'Browse baseline'
											description: node literalValue)
									hover: [ :textualCoderViewModel | 
										textualCoderViewModel
											addTextAttribute: self class nodeHighlight
											from: node startPosition
											to: node stopPosition ]
									leave: self removeHighlightBlock
									action: [ :model :element | 
										self class environment
											at: ('BaselineOf' , node literalValue) asSymbol
											ifPresent: [ :cls | element phlow spawnTool: (GtClassCoderTool observedClass: cls) ] ] ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addClassMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [

	<gtCoderContextMenuAddOns: 11>
	| foundClass |
	(self extractableNodesFrom: aCoderViewModel) ifNotEmpty: [ :nodes | 
		| node |
		node := nodes first.
		node isVariable ifFalse: [ ^ self ].
		self
			variableNodeToBehavior: node
			ifFound: [ :aClass | foundClass := aClass ]
			ifNone: [ ^ self ].
		coderAddOns
			addContextMenuItem:
			(self createLabel: 'Browse class' description: foundClass name)
			hover: [ :textualCoderViewModel | 
				textualCoderViewModel
					addTextAttribute: self class nodeHighlight
					from: node startPosition
					to: node stopPosition ]
			leave: self removeHighlightBlock
			action: [ :aTextualViewModel | self browseBehaviorAt: node startPosition ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addEvaluateAddonsTo: anAst to: coderAddOns [
	<gtCoderContextMenuAddOns: 800>
	self
		addContextMenuItemFrom: GtSourceCoderDoItShortcut new
			withId: nil
			to: coderAddOns;
		addContextMenuItemFrom: GtSourceCoderDoItAndInspectShortcut new
			withId: nil
			to: coderAddOns;
		addContextMenuItemFrom: GtSourceCoderPrintItShortcut new
			withId: nil
			to: coderAddOns;
		addContextMenuItemFrom: GtSourceCoderDebugShortcut new
			withId: nil
			to: coderAddOns
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addFormatMethodAst: anAst to: coderAddOns [
	<gtCoderContextMenuAddOns: 30>
	self
		addContextMenuItemFrom: GtSourceCoderFormatShortcut new
		withId: nil
		to: coderAddOns
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addImplementorsMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 10>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			self
				addLinkMenuAddOnsTo: coderAddOns
				node: node
				selector: #browseImplementorsAt:
				shortcut: GtSourceCoderBrowseImplementorsShortcut new ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addInstanceVariableReferencesMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 11>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			(node isVariable and: [ self isInstanceVariable: node ]) ifFalse: [ ^ self ].
			coderAddOns
				addContextMenuItem: (self createLabel: 'Browse references' description: node name value)
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: node startPosition
						to: node stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel | self browseReferencesAt: node startPosition ]
				id: nil
				shortcutKey: GtSourceCoderBrowseReferencesShortcut new
						combinationForPlatform gtDisplayString ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addLinkMenuAddOnsTo: coderAddOns node: node selector: sel shortcut: aShortcut [
	| highlightNode |
	(node isMessage or: [ node isMessageSend  or: [ node isMethodPattern ] ])
		ifFalse: [ ^ self ].
	highlightNode := node isMessageSend ifTrue: [ node message ] ifFalse: [ node ].
	coderAddOns
		addContextMenuItem: (self createLabel: aShortcut name description: node selector)
		hover: [ :textualCoderViewModel | 
			textualCoderViewModel
				addTextAttribute: self class nodeHighlight
				from: highlightNode startPosition
				to: highlightNode stopPosition ]
		leave: self removeHighlightBlock
		action: [ :aTextualViewModel | self perform: sel with: highlightNode startPosition ]
		shortcutKey: aShortcut combinationForPlatform gtDisplayString
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addMessageReferencesMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 15>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			self
				addLinkMenuAddOnsTo: coderAddOns
				node: node
				selector: #browseReferencesAt:
				shortcut: GtSourceCoderBrowseReferencesShortcut new ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addPackageRenameShortcutFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 1>
	(self behavior inheritsFrom: BaselineOf) ifFalse: [ ^ self ].
	coderAddOns addShortcut: GtRenameInBaselineShortcut new
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> addRenameMethodAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 200>
	(self nodeFrom: aCoderViewModel)
		ifNotNil: [ :node | 
			| highlightNode |
			(node isMessage or: [ node isMessageSend or: [ node isMethodPattern ] ])
				ifFalse: [ ^ self ].
			highlightNode := node isMessageSend
					ifTrue: [ node message ]
					ifFalse: [ node ].
			coderAddOns
				addContextMenuItem: (self
						createLabel: 'Rename message'
						description: node selector)
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: highlightNode startPosition
						to: highlightNode stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel | self renameNode: node in: aTextualViewModel ]
				shortcutKey: GtSourceCoderInlineRenameShortcut new combinationForPlatform
						gtDisplayString ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseBehaviorAt: aTextPosition [
	"Try to find a behavior reference at a given source text position and request to browse it"

	self
		detectBehaviorAt: aTextPosition
		ifFound: [ :aBehavior |
			self
				notifyToolSpawn: (GtClassCoderTool observedClass: aBehavior)
				withDestination: self spawnDestination  ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseBehaviorIn: aSourceString [
	"Try to find a behavior reference within a given source code and request to browse it"

	self
		detectBehaviorIn: aSourceString
		ifFound: [ :aBehavior |
			self
				notifyToolSpawn: (GtClassCoderTool observedClass: aBehavior)
				withDestination: self spawnDestination  ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseImplementorsAt: aTextPosition [
	"Try to find a message selector at a given source text position and request to browse it"

	self
		detectSelectorAt: aTextPosition
		ifFound: [ :aSelector | self notifyObjectSpawn: (GtSearchImplementorsFilter selector: aSelector)  ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseImplementorsIn: aSourceString [
	"Try to find a message selector within a given source string and request to browse it"

	self
		detectSelectorIn: aSourceString
		ifFound: [ :aSelector | self notifyObjectSpawn: (GtSearchImplementorsFilter selector: aSelector) ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseReferencesAt: aTextPosition [
	"Try to create a references filter for an entity at the given text position and request to browse it"

	self notifyObjectSpawn: (self
		detectReferencesFilterAt: aTextPosition
		ifFound: [ :aReferencesFilter | aReferencesFilter ]
		ifNone: [ GtSearchNullFilter new ])
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseReferencesIn: aSourceString [
	"Try to create a references filter for an entity within a given source string and request to browse it"

	self notifyObjectSpawn: (self
		detectReferencesFilterIn: aSourceString
		ifFound: [ :aReferencesFilter | aReferencesFilter ]
		ifNone: [ GtSearchNullFilter new ])
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> colorAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoColorStyler new.
	coderAddOns addStyler: GtPharoGlamorousColorStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> createLabel: aString description: description [
	^ aString asRopedText glamorousRegularFont
		, ((' ' , description) asRopedText
				glamorousCodeFont;
				foreground: Color gray;
				glamorousCodeTinySize)
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> expandCascadeSelection: aSelectionInterval at: position directionOffset: offset in: aSourceCoderViewModel [
	| cascade siblings messageNode index |
	messageNode := (self nodeAt: position) messageNode.
	cascade := messageNode cascadeNode.
	siblings := cascade messages.
	index := (siblings indexOf: messageNode) + offset.
	(index between: 1 and: siblings size)
		ifFalse: [ ^ self
				selectStatementOrCascadeAt: cascade startPosition
				in: aSourceCoderViewModel ].
	self
		selectStatementOrCascadeAt: (siblings at: index) startPosition
		in: aSourceCoderViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> expandSelection: aSelectionInterval toCompleteStatementsIn: aSourceCoderViewModel [
	| nodes |
	nodes := self extractableNodesWithin: aSelectionInterval.
	aSourceCoderViewModel
		select: nodes first statementNode startPosition - 1
		to: nodes last statementNode stopPosition
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> expandStatementSelection: aSelectionInterval at: position directionOffset: offset in: aSourceCoderViewModel [
	| statement siblings index |
	(self isIntervalCompleteStatements: aSelectionInterval)
		ifFalse: [ ^ (self isIntervalCompleteCascades: aSelectionInterval)
				ifTrue: [ self
						expandCascadeSelection: aSelectionInterval
						at: position
						directionOffset: offset
						in: aSourceCoderViewModel ]
				ifFalse: [ self
						expandSelection: aSelectionInterval
						toCompleteStatementsIn: aSourceCoderViewModel ] ].
	statement := (self nodeAt: position) statementNode.
	siblings := statement parent
			ifNil: [ ^ self ]
			ifNotNil: [ :node | node statements ].
	index := (siblings indexOf: statement) + offset.
	(index between: 1 and: siblings size)
		ifFalse: [ ^ self
				selectStatementOrCascadeAt: statement parent statementNode startPosition
				in: aSourceCoderViewModel ].
	self
		selectStatementOrCascadeAt: (siblings at: index) startPosition
		in: aSourceCoderViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> expandStatementSelection: aSelectionInterval downIn: aSourceCoderViewModel [
	self
		expandStatementSelection: aSelectionInterval
		at: aSelectionInterval last
		directionOffset: 1
		in: aSourceCoderViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> expandStatementSelection: aSelectionInterval upIn: aSourceCoderViewModel [
	self
		expandStatementSelection: aSelectionInterval
		at: aSelectionInterval first
		directionOffset: -1
		in: aSourceCoderViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> extractableNodesFrom: aCoderViewModel [
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
GtPharoSourceCoder >> glamorousIconsAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoGlamorousIconStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> highlightNodeBlock: aNode [
	^ [ :textualCoderViewModel | 
	  textualCoderViewModel
		  addTextAttribute: self class nodeHighlight
		  from: aNode startPosition
		  to: aNode stopPosition ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> highlightNodesBlock: aCollection [
	^ [ :textualCoderViewModel | 
	aCollection
		do: [ :each | 
			textualCoderViewModel
				addTextAttribute: self class nodeHighlight
				from: each startPosition
				to: each stopPosition ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> initializeAddOns: addOns [
	| stylers |
	super initializeAddOns: addOns.
	stylers := {GtPharoStyler.
			GtPharoDynamicHighlightStyler.
			GtPharoDeprecationStyler.
			GtPharoMethodExpanderStyler.
			GtPharoClassExpanderStyler} collect: #new.

	addOns addStylers: stylers
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> initializeShortcuts: addOns [
	| shortcuts |
	super initializeShortcuts: addOns.

	shortcuts := {GtSourceCoderBrowseImplementorsShortcut.
			GtSourceCoderBrowseReferencesShortcut.
			GtSourceCoderBrowseBehaviorShortcut.
			GtSourceCoderDiscardChangesShortcut.
			GtSourceCoderFormatShortcut.
			GtSourceCoderDebugShortcut.
			GtSourceCoderInlineRenameShortcut.
			GtSourceCoderMoveStatementUpShortcut.
			GtSourceCoderMoveStatementDownShortcut.
			GtSourceCoderSelectStatementUpShortcut.
			GtSourceCoderSelectStatementDownShortcut.
			GtSourceCoderFixItShortcut.
			GtSourceCoderPrintItShortcut} collect: #new.

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
GtPharoSourceCoder >> isIntervalCompleteCascades: aSelectionInterval [
	"Test to see if the current selection boundaries end exactly on cascaded message nodes"

	| cascade |
	self
		nodeAt: aSelectionInterval first
		ifFound: [ :first | 
			(cascade := first cascadeNode) ifNil: [ ^ false ].
			(cascade messages includes: first) ifFalse: [ ^ false ].
			first startPosition = aSelectionInterval first ifFalse: [ ^ false ] ]
		ifNone: [ ^ false ].
	self
		nodeAt: aSelectionInterval last
		ifFound: [ :last | 
			| message |
			last cascadeNode = cascade ifFalse: [ ^ false ].
			message := last messageNode.
			message stopPosition = aSelectionInterval last ifFalse: [ ^ false ] ]
		ifNone: [ ^ false ].
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> isIntervalCompleteStatements: aSelectionInterval [
	"Test to see if the current selection boundaries end exactly on statement nodes"

	self
		nodeAt: aSelectionInterval first
		ifFound: [ :first | 
			first statementNode startPosition = aSelectionInterval first
				ifFalse: [ ^ false ] ]
		ifNone: [ ^ false ].
	self
		nodeAt: aSelectionInterval last
		ifFound: [ :last | last statementNode stopPosition = aSelectionInterval last ifFalse: [ ^ false ] ]
		ifNone: [ ^ false ].
	^ true
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> isLocalVariable: aNode [
	^ aNode isLocallyDefined
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> messageNodeAfter: aMessageNodeCollection [
	| siblings index |
	siblings := aMessageNodeCollection any parent messages.
	index := siblings indexOf: aMessageNodeCollection last.
	^ index = siblings size ifTrue: [ nil ] ifFalse: [ siblings at: index + 1 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> messageNodeBefore: aMessageNodeCollection [
	| siblings index |
	siblings := aMessageNodeCollection any parent messages.
	index := siblings indexOf: aMessageNodeCollection first.
	^ index = 1 ifTrue: [ nil ] ifFalse: [ siblings at: index - 1 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> moveCascadeNodes: messages downIn: aSourceCoderViewModel [
	"Expects a collection of sibling statement nodes"

	| editString nextNode |
	nextNode := (self messageNodeAfter: messages) ifNil: [ ^ self ].
	editString := SmaCCString on: self currentSourceText.
	editString
		swapFrom: messages first startPosition
		to: messages last stopPosition
		with: nextNode startPosition
		to: nextNode stopPosition.
	self
		updateSourceAndSelectMovedStatements: messages
		from: editString
		in: aSourceCoderViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> moveCascadeNodes: messages upIn: aSourceCoderViewModel [
	"Expects a collection of sibling message nodes"

	| editString prevNode |
	prevNode := (self messageNodeBefore: messages) ifNil: [ ^ self ].
	editString := SmaCCString on: self currentSourceText.
	editString
		swapFrom: prevNode startPosition
		to: prevNode stopPosition
		with: messages first startPosition
		to: messages last stopPosition.
	self
		updateSourceAndSelectMovedStatements: messages
		from: editString
		in: aSourceCoderViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> moveStatementNodes: statements downIn: aSourceCoderViewModel [
	"Expects a collection of sibling statement nodes"

	| editString nextNode |
	nextNode := (self statementNodeAfter: statements) ifNil: [ ^ self ].
	editString := SmaCCString on: self currentSourceText.
	editString
		swapFrom: statements first startPosition
		to: statements last stopPosition
		with: nextNode startPosition
		to: nextNode stopPosition.
	self
		updateSourceAndSelectMovedStatements: statements
		from: editString
		in: aSourceCoderViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> moveStatementNodes: statements upIn: aSourceCoderViewModel [
	"Expects a collection of sibling statement nodes"

	| editString prevNode |
	prevNode := (self statementNodeBefore: statements) ifNil: [ ^ self ].
	editString := SmaCCString on: self currentSourceText.
	editString
		swapFrom: prevNode startPosition
		to: prevNode stopPosition
		with: statements first startPosition
		to: statements last stopPosition.
	self
		updateSourceAndSelectMovedStatements: statements
		from: editString
		in: aSourceCoderViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> moveStatementOrCascadeDownAt: aTextPosition in: aSourceCoderViewModel [
	self
		nodeAt: aTextPosition
		ifFound: [ :aNode | 
			aNode cascadeNode
				ifNotNil: [ self moveCascadeNodes: {aNode messageNode} downIn: aSourceCoderViewModel ]
				ifNil: [ self moveStatementNodes: {aNode statementNode} downIn: aSourceCoderViewModel ] ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> moveStatementOrCascadeUpAt: aTextPosition in: aSourceCoderViewModel [
	self
		nodeAt: aTextPosition
		ifFound: [ :aNode | 
			aNode cascadeNode
				ifNotNil: [ self moveCascadeNodes: {aNode messageNode} upIn: aSourceCoderViewModel ]
				ifNil: [ self moveStatementNodes: {aNode statementNode} upIn: aSourceCoderViewModel ] ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> moveStatementsOrCascadesDownWithin: aSelectionInterval in: aSourceCoderViewModel [
	| cascades |
	cascades := self cascadedMessagesWithin: aSelectionInterval.
	cascades isEmpty
		ifTrue: [ self
				moveStatementNodes: (self extractableNodesWithin: aSelectionInterval)
				downIn: aSourceCoderViewModel ]
		ifFalse: [ self moveCascadeNodes: cascades downIn: aSourceCoderViewModel ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> moveStatementsOrCascadesUpWithin: aSelectionInterval in: aSourceCoderViewModel [
	| cascades |
	cascades := self cascadedMessagesWithin: aSelectionInterval.
	cascades isEmpty
		ifTrue: [ self
				moveStatementNodes: (self extractableNodesWithin: aSelectionInterval)
				upIn: aSourceCoderViewModel ]
		ifFalse: [ self moveCascadeNodes: cascades upIn: aSourceCoderViewModel ]
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
GtPharoSourceCoder class >> nodeHighlight [
	^ NodeHighlight
		ifNil: [ NodeHighlight := BlTextHighlightAttribute new
				paint: BrGlamorousColors textHighlightColor ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> nonBreakableSpaceAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoNonBreakableSpaceStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> passwordAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoMethodPasswordStyler new.
	coderAddOns addStyler: GtPharoZincApplicationFormUrlEncodedEntityStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> removeHighlightBlock [
	^ [ :textualCoderViewModel | 
	  textualCoderViewModel removeAttribute: self class nodeHighlight ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> removeRefactoringAttribute [
	self sourceText
		clearAttributes: [ :each | each class = GtRefactoringChangesAttribute ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameAt: aTextPosition in: aSourceCoderViewModel [
	self
		nodeAt: aTextPosition
		ifFound: [ :aNode | self renameNode: aNode in: aSourceCoderViewModel ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameBaseline: node in: aTextualViewModel [
	(GtRenameBaselineInMethodController new
		sourceCoderViewModel: aTextualViewModel;
		originalNode: node) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameBaselineAt: anIndex in: aCoderViewModel [
	(aCoderViewModel behavior inheritsFrom: BaselineOf) ifFalse: [ ^ false ].
	(self nodeAt: anIndex)
		ifNotNil: [ :node | 
			(node isLiteral and: [ node gtIsBaselineName ]) ifFalse: [ ^ false ].
			self renameBaseline: node in: aCoderViewModel.
			^ true ].
	^ false
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameClassIn: aSourceCoderViewModel node: aVariableNode [
	(GtRenameClassController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameClassVariableIn: aSourceCoderViewModel node: aVariableNode [
	(GtRenameClassVariableController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameInstanceVariableIn: aSourceCoderViewModel node: aVariableNode [
	(GtRenameInstanceVariableController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameMethod: aSourceCoderViewModel node: aMessageOrMethodOrMethodPatternNode [
	(GtRenameMethodController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aMessageOrMethodOrMethodPatternNode) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameNode: aNode in: aSourceCoderViewModel [
	(aNode isMessage or: [ aNode isMethod or: [ aNode isMethodPattern ] ])
		ifTrue: [ ^ self renameMethod: aSourceCoderViewModel node: aNode ].
	aNode isVariable
		ifTrue: [ (self isLocalVariable: aNode)
				ifTrue: [ ^ self renameTemporaryIn: aSourceCoderViewModel node: aNode ].
			(self isInstanceVariable: aNode)
				ifTrue: [ ^ self renameInstanceVariableIn: aSourceCoderViewModel node: aNode ].
			(self isClassVariable: aNode)
				ifTrue: [ ^ self renameClassVariableIn: aSourceCoderViewModel node: aNode ].
			Smalltalk globals
				at: aNode name value asSymbol
				ifPresent: [ :cls | 
					(cls isKindOf: Class)
						ifTrue: [ ^ self renameClassIn: aSourceCoderViewModel node: aNode ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renamePackage: node in: aTextualViewModel [
	(GtRenamePackageInBaselineController new
		sourceCoderViewModel: aTextualViewModel;
		originalNode: node) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renamePackageAt: anIndex in: aCoderViewModel [
	(aCoderViewModel behavior inheritsFrom: BaselineOf) ifFalse: [ ^ false ].
	(self nodeAt: anIndex)
		ifNotNil: [ :node | 
			(node isLiteral and: [ node gtIsBaselinePackageName ]) ifFalse: [ ^ false ].
			self renamePackage: node in: aCoderViewModel.
			^ true ].
	^ false
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameTemporaryIn: aSourceCoderViewModel node: aVariableNode [
	| action locations announcement definer otherCoders renameAttributes originalSource |
	originalSource := (aSourceCoderViewModel styledText ifNil: [ aSourceCoderViewModel sourceText ])
		from: aVariableNode startPosition
		to: aVariableNode stopPosition.
	locations := OrderedCollection new.
	definer := aVariableNode whoDefines.
	announcement := GtCoderRenameTemporaryRequestedAnnouncement new.
	definer isNil
		ifTrue:
			[ announcement variableName: aVariableNode name source.
			self announce: announcement ].
	otherCoders := announcement interestedCoders reject: [ :each | each == self ].
	(definer ifNil: [ aVariableNode topParent ])
		withAllNodesDo: [ :each | each = aVariableNode ifTrue: [ locations add: each sourceInterval ] ].
	action := GtCoderViewModelRenameAction locations: locations textualCoderViewModel: aSourceCoderViewModel.
	action selectAll: true.
	action forVariableOrUnaryMessage.
	renameAttributes := OrderedCollection new.
	otherCoders
		do:
			[ :each | 
			each
				implicitVariableReferencesTo: aVariableNode variableName
				do:
					[ :node | 
					| attribute |
					attribute := GtRenamePreviewAttribute new text: originalSource.
					(each currentSourceText from: node startPosition to: node stopPosition) attributes: {attribute}.
					renameAttributes add: attribute ].
			each sourceChangedTo: each currentSourceText ].
	action
		when: GtRenameActionAnnouncement
		do:
			[ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ renameAttributes do: [ :each | each updateText: ann renameAction newName asRopedText ] ].
			ann eventType = #uninstall
				ifTrue:
					[ otherCoders
						do:
							[ :each | 
							each currentSourceText clearAttributes: [ :attr | attr isKindOf: GtRenamePreviewAttribute ].
							each sourceChangedTo: each currentSourceText ] ].
			ann eventType = #accept
				ifTrue: [ otherCoders do: [ :each | each renameImplicitTemporary: aVariableNode variableName to: action newName ] ] ].
	action install.
	^ action
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> selectStatementOrCascadeAt: anIndex in: aSourceCoderViewModel [
	| node selectNode |
	self
		nodeAt: anIndex
		ifFound: [ :aNode | node := aNode ]
		ifNone: [ ^ self ].
	node isErrorNode ifTrue: [ ^ self ].
	node cascadeNode ifNotNil: [ selectNode := node messageNode ].
	selectNode ifNil: [ selectNode := node statementNode ].
	aSourceCoderViewModel
		select: selectNode startPosition - 1
		to: selectNode stopPosition
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> statementNodeAfter: aStatementNodeCollection [
	| siblings index |
	siblings := aStatementNodeCollection any parent statements.
	index := siblings indexOf: aStatementNodeCollection last.
	^ index = siblings size ifTrue: [ nil ] ifFalse: [ siblings at: index + 1 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> statementNodeBefore: aStatementNodeCollection [
	| siblings index |
	siblings := aStatementNodeCollection any parent statements.
	index := siblings indexOf: aStatementNodeCollection first.
	^ index = 1 ifTrue: [ nil ] ifFalse: [ siblings at: index - 1 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> updateSourceAndSelectMovedStatements: statements from: editString in: aSourceCoderViewModel [
	aSourceCoderViewModel
		selectNone;
		sourceText: editString asString asRopedText
			from: self
			synchronously: true;
		cursors: (BrTextEditorCursor
				at: (editString newPositionFor: aSourceCoderViewModel cursors first position));
		select: (editString newPositionFor: statements first startPosition) - 1
			to: (editString newPositionFor: statements last stopPosition)
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> whenSendToAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoWhenSendToExpanderStyler new.
]
