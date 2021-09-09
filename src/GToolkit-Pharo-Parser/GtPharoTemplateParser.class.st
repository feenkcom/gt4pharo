Class {
	#name : 'GtPharoTemplateParser',
	#superclass : 'GtPharoParser',
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : 'private' }
GtPharoTemplateParser >> actionsForCurrentToken [
	| actions char |
	((currentToken ids includes: scanner leftBraceId) and: [ scanner peekCharacter = ${ ])
		ifTrue:
			[ char := self characterAt: currentToken startPosition - 1.
			currentToken := currentToken class
				value: '{{'
				start: currentToken startPosition
				ids:
					((char notNil and: [ char isAlphaNumeric or: [ char = $_ ] ])
						ifTrue: [ {scanner doubleLeftBraceId} ]
						ifFalse: [ {scanner doubleLeftBraceStartId} ]).
			self position: self position + 1 ].
	((currentToken ids includes: scanner rightBraceId)
		and: [ scanner peekCharacter = $} and: [ self hasActionFor: scanner doubleRightBraceId ] ])
		ifTrue:
			[ currentToken := currentToken class
				value: '}}'
				start: currentToken startPosition
				ids: {scanner doubleRightBraceId}.
			self position: self position + 1 ].
	currentToken ids first = scanner nameId
		ifTrue:
			[ char := self characterAt: currentToken startPosition - 1.
			(char notNil and: [ char = $} ])
				ifTrue:
					[ currentToken
						ids:
							{scanner templateNamePartId.
								scanner nameId} ] ].
	currentToken ids first = scanner keywordId
		ifTrue:
			[ char := self characterAt: currentToken startPosition - 1.
			(char notNil and: [ char = $} ])
				ifTrue:
					[ currentToken
						ids:
							{scanner templateKeywordId.
								scanner nameId} ] ].
	actions := super actionsForCurrentToken.
	^ actions
]

{ #category : 'private' }
GtPharoTemplateParser >> characterAt: anInteger [
	anInteger < 1 ifTrue: [ ^ nil ].
	^ scanner stream originalContents at: anInteger
]

{ #category : 'private' }
GtPharoTemplateParser >> hasActionFor: aTokenId [
	^ (self actionsForState: self currentState and: aTokenId) notNil
]
