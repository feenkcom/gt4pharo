Extension { #name : #GtPharoSourceCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoSourceCoder >> addSelectionSearchMenuAddOnsAst: anAst to: coderAddOns from: aCoderViewModel [
	"Add a Search submenu with search actions for the selected text.
	The actions are defined in GtCoderSelectionSearch"

	<gtCoderContextMenuAddOns>
	aCoderViewModel hasSelection ifFalse: [ ^ self ].
	(GtCoderSelectionSearch coderViewModel: aCoderViewModel) hasSearchableSelection
		ifFalse: [ ^ self ].

	(coderAddOns
		addContextMenu: 'Search'
		icon: BrGlamorousVectorIcons search
		submenu: [ :theCoderViewModel :aTextualCoderEditorElement | 
			GtCoderSelectionSearchTarget
				menuItemsForObject: (GtCoderSelectionSearch coderViewModel: theCoderViewModel)
				hostElement: aTextualCoderEditorElement ])
		ifNotNil: [ :anAction | 
			anAction
				group: BrMenuItemGroupConfiguration navigation;
				priority: 55 ]
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoSourceCoder >> formatWithRequesterObject: aRequester [
	| ast originalSource formatted |
	originalSource := self currentSourceString.
	ast := [RBParser parseExpression: originalSource]
				on: RBParser gtParseErrorClass
				do: [:ex | ^self notifyParseError: ex requesterObject: aRequester].
	formatted := ast formattedCode.
	self currentSourceString: formatted.
	self
		updateSelectionAfterFormatOf: aRequester
		from: ast
		to: (RBParser parseExpression: formatted)
		originalSource: originalSource
		formattedSource: formatted
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoSourceCoder >> updateSelectionAfterFormatOf: aRequester from: originalAst to: formattedAst originalSource: anOriginalString formattedSource: aFormattedString [
	| positionMap event mapped |
	positionMap := self computePositionMappingsFrom: originalAst to: formattedAst.
	event := GtSourceCoderFormattedEvent
			originalSource: anOriginalString
			formattedSource: aFormattedString
			positionMap: positionMap.
	self announce: event.
	(aRequester isNil or: [ aRequester hasSelection not ]) ifTrue: [ ^ self ].
	mapped := positionMap
			mapRange: (aRequester selection from + 1 to: aRequester selection to).
	aRequester selectNone.
	aRequester select: mapped first - 1 to: mapped last
]
