Class {
	#name : #GtPharoScanner,
	#superclass : #SmaCCScanner,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #'generated-initialization' }
GtPharoScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(7 'false' 5) #(7 'nil' 6) #(7 'self' 1) #(7 'super' 2) #(7 'thisContext' 3) #(7 'true' 4))
		do: [ :each | (keywordMap at: each first ifAbsentPut: [ Dictionary new ]) at: (each at: 2) put: each last ].
	^ keywordMap
]

{ #category : #generated }
GtPharoScanner >> barId [
	^ 9
]

{ #category : #generated }
GtPharoScanner >> binaryId [
	^ 29
]

{ #category : #generated }
GtPharoScanner >> doubleLeftBraceId [
	^ 123
]

{ #category : #generated }
GtPharoScanner >> doubleLeftBraceStartId [
	^ 124
]

{ #category : #generated }
GtPharoScanner >> doubleRightBraceId [
	^ 125
]

{ #category : #generated }
GtPharoScanner >> emptySymbolTokenId [
	^ 132
]

{ #category : #generated }
GtPharoScanner >> errorTokenId [
	^ 133
]

{ #category : #generated }
GtPharoScanner >> keywordId [
	^ 28
]

{ #category : #generated }
GtPharoScanner >> leftBraceId [
	^ 19
]

{ #category : #generated }
GtPharoScanner >> nameAssignmentId [
	^ 8
]

{ #category : #generated }
GtPharoScanner >> nameId [
	^ 7
]

{ #category : #scanning }
GtPharoScanner >> negativeNumber [
	stream position: stream position - 2.
	^ self scanNumber: self negativeNumberId
]

{ #category : #generated }
GtPharoScanner >> negativeNumberId [
	^ 14
]

{ #category : #scanning }
GtPharoScanner >> number [
	stream position: stream position - 1.
	^ self scanNumber: self numberId
]

{ #category : #generated }
GtPharoScanner >> numberId [
	^ 13
]

{ #category : #generated }
GtPharoScanner >> rbKeywordPatternId [
	^ 126
]

{ #category : #generated }
GtPharoScanner >> rbLiteralArrayKeywordPatternId [
	^ 127
]

{ #category : #generated }
GtPharoScanner >> rbNamePatternId [
	^ 128
]

{ #category : #generated }
GtPharoScanner >> rbPatternBlockId [
	^ 129
]

{ #category : #generated }
GtPharoScanner >> rightBraceId [
	^ 27
]

{ #category : #generated }
GtPharoScanner >> scan1 [
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan2 ].
	currentCharacter == $# ifTrue: [ ^ self scan3 ].
	currentCharacter == $$ ifTrue: [ ^ self scan8 ].
	currentCharacter == $' ifTrue: [ ^ self scan9 ].
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(22) ].
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(25) ].
	^ self scan1X9
]

{ #category : #generated }
GtPharoScanner >> scan10 [
	self recordMatch: #(29).
	self step.
	currentCharacter isDigit ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue:
			[ [ self recordMatch: #(29).
			self step.
			currentCharacter == $!
				or:
					[ (currentCharacter between: $% and: $&)
						or:
							[ (currentCharacter between: $* and: $-)
								or:
									[ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan11 [
	[ self step.
	currentCharacter == $`
		ifTrue:
			[ self recordMatch: #(35).
			self step.
			currentCharacter == $` ifTrue: [ ^ self scan11 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan12 [
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan2 ].
	currentCharacter == $# ifTrue: [ ^ self scan3 ].
	^ self scan12X4
]

{ #category : #generated }
GtPharoScanner >> scan12X1 [
	[ self recordMatch: #(29).
	self step.
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan12X2 [
	[ self recordMatch: #(34).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan12X3 [
	currentCharacter == $} ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter isDigit ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ]) ifTrue: [ ^ self scan12X2 ].
	((currentCharacter between: $! and: $@)
		or: [ currentCharacter == $\ or: [ currentCharacter between: $| and: $~ ] ])
		ifTrue: [ ^ self scan12X1 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(7).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan13 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan12X4 [
	currentCharacter == $$ ifTrue: [ ^ self scan8 ].
	currentCharacter == $' ifTrue: [ ^ self scan9 ].
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(22) ].
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(25) ].
	currentCharacter == $- ifTrue: [ ^ self scan10 ].
	currentCharacter == $. ifTrue: [ ^ self recordAndReportMatch: #(32) ].
	currentCharacter == $: ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $; ifTrue: [ ^ self recordAndReportMatch: #(30) ].
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	currentCharacter == $^ ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	currentCharacter == ${ ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	^ self scan12X3
]

{ #category : #generated }
GtPharoScanner >> scan13 [
	self recordMatch: #(15).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self step.
			currentCharacter == $: ifTrue: [ ^ self scan13 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X1 [
	self recordMatch: #(9 29).
	self step.
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue:
			[ [ self recordMatch: #(29).
			self step.
			currentCharacter == $!
				or:
					[ (currentCharacter between: $% and: $&)
						or:
							[ (currentCharacter between: $* and: $-)
								or:
									[ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X2 [
	self recordMatch: #(18 29).
	self step.
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue:
			[ [ self recordMatch: #(29).
			self step.
			currentCharacter == $!
				or:
					[ (currentCharacter between: $% and: $&)
						or:
							[ (currentCharacter between: $* and: $-)
								or:
									[ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X3 [
	self recordMatch: #(17 29).
	self step.
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue:
			[ [ self recordMatch: #(29).
			self step.
			currentCharacter == $!
				or:
					[ (currentCharacter between: $% and: $&)
						or:
							[ (currentCharacter between: $* and: $-)
								or:
									[ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X4 [
	[ self recordMatch: #(29).
	self step.
	currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X5 [
	[ self recordMatch: #(34).
	self step.
	currentCharacter isSeparator or: [ currentCharacter == Character null or: [ currentCharacter == Character pageUp ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X6 [
	self recordMatch: #(28).
	self step.
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X7 [
	self recordMatch: #(21).
	self step.
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(31) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X8 [
	currentCharacter == $} ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter isDigit ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ]) ifTrue: [ ^ self scan1X5 ].
	((currentCharacter between: $! and: $@) or: [ '\~' includes: currentCharacter ])
		ifTrue: [ ^ self scan1X4 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(7).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan1X6 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X9 [
	currentCharacter == $- ifTrue: [ ^ self scan10 ].
	currentCharacter == $. ifTrue: [ ^ self recordAndReportMatch: #(32) ].
	currentCharacter == $: ifTrue: [ ^ self scan1X7 ].
	currentCharacter == $; ifTrue: [ ^ self recordAndReportMatch: #(30) ].
	currentCharacter == $< ifTrue: [ ^ self scan1X3 ].
	currentCharacter == $> ifTrue: [ ^ self scan1X2 ].
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	currentCharacter == $^ ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	currentCharacter == $` ifTrue: [ ^ self scan11 ].
	currentCharacter == ${ ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	currentCharacter == $| ifTrue: [ ^ self scan1X1 ].
	^ self scan1X8
]

{ #category : #generated }
GtPharoScanner >> scan2 [
	[ self step.
	currentCharacter == $" ifTrue: [ ^ self recordAndReportMatch: #(33) ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan3 [
	self step.
	currentCharacter == $#
		ifTrue:
			[ self step.
			currentCharacter == $' ifTrue: [ ^ self scan4 ].
			(currentCharacter == $!
				or:
					[ (currentCharacter between: $% and: $&)
						or:
							[ (currentCharacter between: $* and: $-)
								or:
									[ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ])
				ifTrue:
					[ [ self recordMatch: #(11).
					self step.
					currentCharacter == $!
						or:
							[ (currentCharacter between: $% and: $&)
								or:
									[ (currentCharacter between: $* and: $-)
										or:
											[ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ] ]
						whileTrue.
					^ self reportLastMatch ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan5 ].
			^ self reportLastMatch ].
	currentCharacter == $' ifTrue: [ ^ self scan4 ].
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(23) ].
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(24) ].
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue:
			[ [ self recordMatch: #(11).
			self step.
			currentCharacter == $!
				or:
					[ (currentCharacter between: $% and: $&)
						or:
							[ (currentCharacter between: $* and: $-)
								or:
									[ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan4 [
	[ self step.
	currentCharacter == $'
		ifTrue:
			[ self recordMatch: #(11).
			self step.
			currentCharacter == $' ifTrue: [ ^ self scan4 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan5 [
	[ self recordMatch: #(11).
	self step.
	currentCharacter == $:
		ifTrue:
			[ self recordMatch: #(11).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan6 ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan7 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan6 [
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue:
			[ [ self recordMatch: #(11).
			self step.
			currentCharacter == $:
				ifTrue:
					[ self step.
					currentCharacter == $: ifTrue: [ ^ self scan6 ].
					^ self reportLastMatch ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan7 [
	[ self step.
	currentCharacter == $:
		ifTrue:
			[ self recordMatch: #(11).
			self step.
			(currentCharacter isLetter or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan7 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan8 [
	self step.
	^ self recordAndReportMatch: #(12)
]

{ #category : #generated }
GtPharoScanner >> scan9 [
	[ self step.
	currentCharacter == $'
		ifTrue:
			[ self recordMatch: #(10).
			self step.
			currentCharacter == $' ifTrue: [ ^ self scan9 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scanForToken [
	scope == #literalArray ifTrue: [ ^ self scan12 ].
	scope == #default ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]

{ #category : #scanning }
GtPharoScanner >> scanNumber: anInteger [
	| end |
	matchActions := Array with: anInteger.
	[ Number readFrom: stream ]
		on: Error
		do: [ :ex | matchActions := #(0) ].
	outputStream reset.
	end := stream position.
	stream position: start.
	^ self createTokenFor: (stream next: end - start)
]

{ #category : #generated }
GtPharoScanner >> templateKeywordId [
	^ 130
]

{ #category : #generated }
GtPharoScanner >> templateNamePartId [
	^ 131
]

{ #category : #generated }
GtPharoScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil #number #negativeNumber nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #comment #whitespace #patternToken)
]
