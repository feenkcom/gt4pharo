Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
GtPharoMethodCoder >> addConvertEqualsToSameContentAsFor: aNode to: coderAddOns [

	aNode selector == #= ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: 'Convert #= to #sameContentAs:'
				description: '(self nodeDescription: nodes first)')
		hover: (self highlightNodeBlock: aNode)
		leave: self removeHighlightBlock
		action: [ :aCoderViewModel :element |
			(GtConvertEqualsToSameContentAsController new
				nodes: aNode;
				sourceCoderViewModel: aCoderViewModel) executeIn: element ]
		id: #'context-menu--equals-to-samecontentas'
]

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
GtPharoMethodCoder >> addConvertEqualsToSameContentAsMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns: 320>

	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :theNodes | 
			| aNode |
			aNode := theNodes first.
			self addConvertEqualsToSameContentAsFor: aNode to: coderAddOns ]
]
