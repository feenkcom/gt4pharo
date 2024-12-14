Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
GtPharoMethodCoder >> addConvertEqualsToSameContentAsFor: aNode to: coderAddOns [

	(aNode isMessage and: [ aNode selector == #= ]) ifFalse: [ ^ self ].
	coderAddOns
		addContextMenuItem: (self
				createLabel: ('Convert ' asRopedText, 
					'#=' asRopedText glamorousCodeFontAndSize,
					' to ' asRopedText,
					'#sameContentAs:' asRopedText glamorousCodeFontAndSize)
				description: (self nodeDescription: aNode))
		group: BrMenuItemGroupConfiguration refactoring
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
