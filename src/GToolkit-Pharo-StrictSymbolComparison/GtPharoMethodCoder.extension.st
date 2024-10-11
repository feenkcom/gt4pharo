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
