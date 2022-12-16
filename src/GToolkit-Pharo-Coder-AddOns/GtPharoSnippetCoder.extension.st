Extension { #name : #GtPharoSnippetCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addExtractVariableFor: aNode to: coderAddOns [
	(aNode isValueNode and: [ aNode isVariable not ]) ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Extract variable' description: (self nodeDescription: aNode))
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action:
			[ :aCoderViewModel | 
			((GtSnippetExtractTemporaryRefactoringController new)
				node: aNode;
				sourceCoderViewModel: aCoderViewModel) execute ]
		id: #'context-menu--extract-variable'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addInlineMethodFor: aNode to: coderAddOns from: aCoderViewModel [
	| class selector |
	aNode isMessageSend ifFalse: [ ^ false ].
	selector := aNode selector.
	class := GtPharoProgramNode
		typeOf: aNode receiver
		in: self behavior
		bindings: aCoderViewModel compositeVariableBindings.
	class isNil
		ifTrue:
			[ Smalltalk globals
				allBehaviorsDo:
					[ :each | 
					(each includesSelector: selector)
						ifTrue:
							[ class notNil ifTrue: [ ^ self ].
							class := each ] ] ].
	class isNil ifTrue: [ ^ self ].
	class := class whichClassIncludesSelector: selector.
	class isNil ifTrue: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self createLabel: 'Inline send' description: aNode selector)
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action:
			[ :each | 
			((GtSnippetInlineMessageRefactoringController new)
				messageNode: aNode;
				implementorClass: class;
				sourceCoderViewModel: each) execute ]
		id: #'context-menu--inline-send'
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> addRefactoringContextMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 20>
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :nodes | 
			| node |
			coderAddOns
				addContextMenuItem: 'Extract method'
				hover: [ :textualCoderViewModel | 
					textualCoderViewModel
						addTextAttribute: self class nodeHighlight
						from: nodes first startPosition
						to: nodes last stopPosition ]
				leave: self removeHighlightBlock
				action: [ :aTextualViewModel | 
					(GtExtractMethodFromSnippetController new
						sourceCoderViewModel: aTextualViewModel) execute ]
				id: GtMethodCoderExtractMethodContextMenuItemId.

			node := nodes first.
			node
				withAllParentsDo: [ :aNode | self addExtractVariableFor: aNode to: coderAddOns ].
			self
				addInlineMethodFor: node
				to: coderAddOns
				from: aCoderViewModel ]
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
			id: GtSourceCoderProfileActionId.

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
		addShortcut: GtSourceCoderBrowseImplementorsShortcut new;
		addShortcut: GtSourceCoderBrowseReferencesShortcut new;
		addShortcut: GtSourceCoderBrowseBehaviorShortcut new;
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
