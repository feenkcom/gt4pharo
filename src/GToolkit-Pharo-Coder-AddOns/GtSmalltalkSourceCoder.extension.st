Extension { #name : #GtSmalltalkSourceCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> addLinkMenuAddOnsTo: coderAddOns group: menuGroup node: node selector: sel label: aLabel requesterObject: aRequester [
	self 
		addLinkMenuAddOnsTo: coderAddOns 
		group: menuGroup
		node: node 
		selector: sel 
		label: aLabel
		shortcut: nil 
		requesterObject: aRequester
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> addLinkMenuAddOnsTo: coderAddOns group: menuGroup node: node selector: sel label: aLabel shortcut: aShortcut requesterObject: aRequester [
	| highlightNode nodeDescription |
	
	(node isMessage or: [ 
		node isMessageSend or: [ 
			node isMethodPattern or: [ 
				node isSymbol ] ] ])
		ifFalse: [ ^ self ].
	
	highlightNode := node isMessageSend 
		ifTrue: [ node message ] ifFalse: [ node ].
	nodeDescription := node isSymbol
		ifTrue: [ node literalValue ] ifFalse: [ node selector ].
	
	coderAddOns
		addContextMenuItem: (self 
			createLabel: aLabel
			description: nodeDescription)
		group: menuGroup
		hover: (self highlightNodeBlock: highlightNode)
		leave: self removeHighlightBlock
		action: [ :aTextualViewModel | 
			self
				perform: sel
				with: highlightNode startPosition
				with: aRequester ]
		shortcutKey: (aShortcut ifNotNil: [
			aShortcut combinationForPlatform gtDisplayString ])
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> addLinkMenuAddOnsTo: coderAddOns group: menuGroup node: node selector: sel shortcut: aShortcut requesterObject: aRequester [
	self 
		addLinkMenuAddOnsTo: coderAddOns 
		group: menuGroup
		node: node 
		selector: sel 
		label: aShortcut name 
		shortcut: aShortcut 
		requesterObject: aRequester
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> addLinkMenuAddOnsTo: coderAddOns node: node selector: sel label: aLabel requesterObject: aRequester [
	self 
		addLinkMenuAddOnsTo: coderAddOns 
		node: node 
		selector: sel 
		label: aLabel
		shortcut: nil 
		requesterObject: aRequester
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> addLinkMenuAddOnsTo: coderAddOns node: node selector: sel label: aLabel shortcut: aShortcut requesterObject: aRequester [
	| highlightNode nodeDescription |
	
	(node isMessage or: [ 
		node isMessageSend or: [ 
			node isMethodPattern or: [ 
				node isSymbol ] ] ])
		ifFalse: [ ^ self ].
	
	highlightNode := node isMessageSend 
		ifTrue: [ node message ] ifFalse: [ node ].
	nodeDescription := node isSymbol
		ifTrue: [ node literalValue ] ifFalse: [ node selector ].
	
	coderAddOns
		addContextMenuItem: (self 
			createLabel: aLabel
			description: nodeDescription)
		hover: (self highlightNodeBlock: highlightNode)
		leave: self removeHighlightBlock
		action: [ :aTextualViewModel | 
			self
				perform: sel
				with: highlightNode startPosition
				with: aRequester ]
		shortcutKey: (aShortcut ifNotNil: [
			aShortcut combinationForPlatform gtDisplayString ])
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> addLinkMenuAddOnsTo: coderAddOns node: node selector: sel shortcut: aShortcut requesterObject: aRequester [
	self 
		addLinkMenuAddOnsTo: coderAddOns 
		node: node 
		selector: sel 
		label: aShortcut name 
		shortcut: aShortcut 
		requesterObject: aRequester
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> expandCascadeSelection: aSelectionInterval at: position directionOffset: offset in: aSourceCoderViewModel [
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
GtSmalltalkSourceCoder >> expandSelection: aSelectionInterval toCompleteStatementsIn: aSourceCoderViewModel [
	| nodes |
	nodes := self extractableNodesWithin: aSelectionInterval.
	aSourceCoderViewModel
		select: nodes first statementNode startPosition - 1
		to: nodes last statementNode stopPosition
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> expandStatementSelection: aSelectionInterval at: position directionOffset: offset in: aSourceCoderViewModel [
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
GtSmalltalkSourceCoder >> expandStatementSelection: aSelectionInterval downIn: aSourceCoderViewModel [
	self
		expandStatementSelection: aSelectionInterval
		at: aSelectionInterval last
		directionOffset: 1
		in: aSourceCoderViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> expandStatementSelection: aSelectionInterval upIn: aSourceCoderViewModel [
	self
		expandStatementSelection: aSelectionInterval
		at: aSelectionInterval first
		directionOffset: -1
		in: aSourceCoderViewModel
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> highlightNodeBlock: aNode [
	^ [ :textualCoderViewModel | 
	  textualCoderViewModel
		  addTextAttribute: self class nodeHighlight
		  from: aNode startPosition
		  to: aNode stopPosition ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> isIntervalCompleteCascades: aSelectionInterval [
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
GtSmalltalkSourceCoder >> isIntervalCompleteStatements: aSelectionInterval [
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
GtSmalltalkSourceCoder >> messageNodeAfter: aMessageNodeCollection [
	| siblings index |
	siblings := aMessageNodeCollection any parent messages.
	index := siblings indexOf: aMessageNodeCollection last.
	^ index = siblings size ifTrue: [ nil ] ifFalse: [ siblings at: index + 1 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> messageNodeBefore: aMessageNodeCollection [
	| siblings index |
	siblings := aMessageNodeCollection any parent messages.
	index := siblings indexOf: aMessageNodeCollection first.
	^ index = 1 ifTrue: [ nil ] ifFalse: [ siblings at: index - 1 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> moveCascadeNodes: messages downIn: aSourceCoderViewModel [
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
GtSmalltalkSourceCoder >> moveCascadeNodes: messages upIn: aSourceCoderViewModel [
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
GtSmalltalkSourceCoder >> moveStatementNodes: statements downIn: aSourceCoderViewModel [
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
GtSmalltalkSourceCoder >> moveStatementNodes: statements upIn: aSourceCoderViewModel [
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
GtSmalltalkSourceCoder >> moveStatementOrCascadeDownAt: aTextPosition in: aSourceCoderViewModel [
	self
		nodeAt: aTextPosition
		ifFound: [ :aNode | 
			aNode cascadeNode
				ifNotNil: [ self moveCascadeNodes: {aNode messageNode} downIn: aSourceCoderViewModel ]
				ifNil: [ self moveStatementNodes: {aNode statementNode} downIn: aSourceCoderViewModel ] ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> moveStatementOrCascadeUpAt: aTextPosition in: aSourceCoderViewModel [
	self
		nodeAt: aTextPosition
		ifFound: [ :aNode | 
			aNode cascadeNode
				ifNotNil: [ self moveCascadeNodes: {aNode messageNode} upIn: aSourceCoderViewModel ]
				ifNil: [ self moveStatementNodes: {aNode statementNode} upIn: aSourceCoderViewModel ] ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> moveStatementsOrCascadesDownWithin: aSelectionInterval in: aSourceCoderViewModel [
	| cascades |
	cascades := self cascadedMessagesWithin: aSelectionInterval.
	cascades isEmpty
		ifTrue: [ self
				moveStatementNodes: (self extractableNodesWithin: aSelectionInterval)
				downIn: aSourceCoderViewModel ]
		ifFalse: [ self moveCascadeNodes: cascades downIn: aSourceCoderViewModel ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> moveStatementsOrCascadesUpWithin: aSelectionInterval in: aSourceCoderViewModel [
	| cascades |
	cascades := self cascadedMessagesWithin: aSelectionInterval.
	cascades isEmpty
		ifTrue: [ self
				moveStatementNodes: (self extractableNodesWithin: aSelectionInterval)
				upIn: aSourceCoderViewModel ]
		ifFalse: [ self moveCascadeNodes: cascades upIn: aSourceCoderViewModel ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> newFilterContext [
	^ GtSearchMethodCoderFilterContext new 
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder class >> nodeHighlight [
	^ NodeHighlight
		ifNil: [ NodeHighlight := BlTextHighlightAttribute new
				paint: BrGlamorousColors textHighlightColor ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> removeHighlightBlock [
	^ [ :textualCoderViewModel | 
	  textualCoderViewModel removeAttribute: self class nodeHighlight ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> selectStatementOrCascadeAt: anIndex in: aSourceCoderViewModel [
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
GtSmalltalkSourceCoder >> statementNodeAfter: aStatementNodeCollection [
	| siblings index |
	siblings := aStatementNodeCollection any parent statements.
	index := siblings indexOf: aStatementNodeCollection last.
	^ index = siblings size ifTrue: [ nil ] ifFalse: [ siblings at: index + 1 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> statementNodeBefore: aStatementNodeCollection [
	| siblings index |
	siblings := aStatementNodeCollection any parent statements.
	index := siblings indexOf: aStatementNodeCollection first.
	^ index = 1 ifTrue: [ nil ] ifFalse: [ siblings at: index - 1 ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtSmalltalkSourceCoder >> updateSourceAndSelectMovedStatements: statements from: editString in: aSourceCoderViewModel [
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
