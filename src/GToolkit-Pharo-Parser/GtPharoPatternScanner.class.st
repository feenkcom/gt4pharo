Class {
	#name : #GtPharoPatternScanner,
	#superclass : #GtPharoScanner,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #accessing }
GtPharoPatternScanner >> scanForToken [
	stream peek = $`
		ifTrue: [ self step.
			self recordMatch: {self rbNamePatternId}.
			self step.
			currentCharacter = ${
				ifTrue: [ ^ self recordAndReportMatch: {self rbPatternBlockId} ].
			[ currentCharacter notNil and: [ '`@;#.' includes: currentCharacter ] ]
				whileTrue: [ self step ].
			[ currentCharacter notNil
				and: [ currentCharacter isLetter or: [ currentCharacter between: $0 and: $9 ] ] ]
				whileTrue: [ self recordMatch: {self rbNamePatternId}.
					self step ].
			currentCharacter = $: ifFalse: [ ^ self reportLastMatch ].
			^ self
				recordAndReportMatch: {scope == #literalArray
							ifTrue: [ self rbLiteralArrayKeywordPatternId ]
							ifFalse: [ self rbKeywordPatternId ]} ].
	^ super scanForToken
]
