Extension { #name : #GtPharoSourceCoder }

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
