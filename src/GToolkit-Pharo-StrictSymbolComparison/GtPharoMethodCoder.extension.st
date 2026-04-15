Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
GtPharoMethodCoder >> addConvertEqualsToSameContentAsFor: aNode to: coderAddOns context: aBuildContext [
	<return: #GtCoderContextMenuAction or: nil>
	(aNode isMessage and: [ aNode selector == #= ]) ifFalse: [ ^ nil ].
	^ coderAddOns
		addContextMenuItem: (self
				createLabel: ('Convert ' asRopedText, 
					'#=' asRopedText glamorousCodeFontAndSize,
					' to ' asRopedText,
					'#sameContentAs:' asRopedText glamorousCodeFontAndSize)
				description: (self nodeDescription: aNode))
		group: BrMenuItemGroupConfiguration refactoring
		hover: (self highlightNodeBlock: aNode documentId: aBuildContext documentId)
		leave: self removeHighlightsBlock
		action: [ :aCoderViewModel :element |
			(GtConvertEqualsToSameContentAsController new
				nodes: aNode;
				sourceCoderViewModel: aCoderViewModel) executeIn: element ]
		id: #'context-menu--equals-to-samecontentas'
]

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
GtPharoMethodCoder >> addConvertEqualsToSameContentAsMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	<gtCoderContextMenuAddOns>
	| aDocumentId |
	aDocumentId := aCoderViewModel documentId.
	(self extractableNodesFrom: aCoderViewModel)
		ifNotEmpty: [ :theNodes | 
			| aNode |
			aNode := theNodes first.
			(self
				addConvertEqualsToSameContentAsFor: aNode
				to: coderAddOns
				context: (GtCoderAddOnsBuildContext new documentId: aDocumentId))
				ifNotNil: [ :anAction | anAction priority: 320 ] ]
]
