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
	^ 10
]

{ #category : #generated }
GtPharoScanner >> binaryId [
	^ 30
]

{ #category : #generated }
GtPharoScanner >> doubleLeftBraceId [
	^ 127
]

{ #category : #generated }
GtPharoScanner >> doubleLeftBraceStartId [
	^ 128
]

{ #category : #generated }
GtPharoScanner >> doubleRightBraceId [
	^ 129
]

{ #category : #generated }
GtPharoScanner >> emptySymbolTokenId [
	^ 137
]

{ #category : #generated }
GtPharoScanner >> errorTokenId [
	^ 138
]

{ #category : #generated }
GtPharoScanner >> keywordId [
	^ 29
]

{ #category : #generated }
GtPharoScanner >> leftBraceId [
	^ 20
]

{ #category : #generated }
GtPharoScanner >> nameAssignmentId [
	^ 9
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
	^ 15
]

{ #category : #scanning }
GtPharoScanner >> number [
	stream position: stream position - 1.
	^ self scanNumber: self numberId
]

{ #category : #generated }
GtPharoScanner >> numberId [
	^ 14
]

{ #category : #generated }
GtPharoScanner >> rbKeywordPatternId [
	^ 130
]

{ #category : #generated }
GtPharoScanner >> rbLiteralArrayKeywordPatternId [
	^ 131
]

{ #category : #generated }
GtPharoScanner >> rbNamePatternId [
	^ 132
]

{ #category : #generated }
GtPharoScanner >> rbPatternBlockId [
	^ 133
]

{ #category : #generated }
GtPharoScanner >> rightBraceId [
	^ 28
]

{ #category : #generated }
GtPharoScanner >> scan1 [
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan2 ].
	currentCharacter == $# ifTrue: [ ^ self scan3 ].
	currentCharacter == $$ ifTrue: [ ^ self scan8 ].
	currentCharacter == $' ifTrue: [ ^ self scan9 ].
	^ self scan1X5
]

{ #category : #generated }
GtPharoScanner >> scan10 [
	self recordMatch: #(30).
	self step.
	currentCharacter isDigit ifTrue: [ ^ self recordAndReportMatch: #(15) ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(30).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan11 [
	self recordMatch: #(22).
	self step.
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(32) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan12 [
	self recordMatch: #(18 30).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(30).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan13 [
	self recordMatch: #(19 30).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(30).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan14 [
	self recordMatch: #(29).
	self step.
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan15 [
	[ self step.
	currentCharacter == $`
		ifTrue: [ self recordMatch: #(36).
			self step.
			currentCharacter == $` ifTrue: [ ^ self scan15 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan16 [
	self recordMatch: #(10 30).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(30).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan17 [
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan2 ].
	currentCharacter == $# ifTrue: [ ^ self scan3 ].
	currentCharacter == $$ ifTrue: [ ^ self scan8 ].
	currentCharacter == $' ifTrue: [ ^ self scan9 ].
	^ self scan17X5
]

{ #category : #generated }
GtPharoScanner >> scan17X1 [
	[ self recordMatch: #(30).
	self step.
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ] ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan17X2 [
	[ self recordMatch: #(7).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan18 ].
	currentCharacter == $: ifTrue: [ ^ self scan14 ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan17X3 [
	[ self recordMatch: #(35).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan17X4 [
	currentCharacter == ${ ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	currentCharacter == $| ifTrue: [ ^ self scan16 ].
	currentCharacter == $} ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	currentCharacter isDigit ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ]) ifTrue: [ ^ self scan17X3 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17X2 ].
	((currentCharacter between: $! and: $~)
		or: [ ('±·' includes: currentCharacter)
				or: [ currentCharacter between: (Character value: 215) and: (Character value: 247) ] ])
		ifTrue: [ self scan17X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan17X5 [
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(23) ].
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	currentCharacter == $- ifTrue: [ ^ self scan10 ].
	currentCharacter == $. ifTrue: [ ^ self recordAndReportMatch: #(33) ].
	currentCharacter == $: ifTrue: [ ^ self scan11 ].
	currentCharacter == $; ifTrue: [ ^ self recordAndReportMatch: #(31) ].
	currentCharacter == $< ifTrue: [ ^ self scan12 ].
	currentCharacter == $> ifTrue: [ ^ self scan13 ].
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter == $^ ifTrue: [ ^ self recordAndReportMatch: #(17) ].
	currentCharacter == $` ifTrue: [ ^ self scan15 ].
	^ self scan17X4
]

{ #category : #generated }
GtPharoScanner >> scan18 [
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(8).
			self step.
			currentCharacter == $. ifTrue: [ ^ self scan18 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan19 [
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan2 ].
	^ self scan19X5
]

{ #category : #generated }
GtPharoScanner >> scan19X1 [
	[ self recordMatch: #(30).
	self step.
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ] ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan19X2 [
	[ self recordMatch: #(7).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan20 ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan19X3 [
	[ self recordMatch: #(35).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan19X4 [
	currentCharacter == ${ ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	currentCharacter == $} ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	currentCharacter isDigit ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ]) ifTrue: [ ^ self scan19X3 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan19X2 ].
	((currentCharacter between: $! and: $\)
		or: [ (currentCharacter between: $| and: $~)
				or: [ ('±·' includes: currentCharacter)
						or: [ currentCharacter between: (Character value: 215) and: (Character value: 247) ] ] ])
		ifTrue: [ self scan19X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan19X5 [
	currentCharacter == $# ifTrue: [ ^ self scan3 ].
	currentCharacter == $$ ifTrue: [ ^ self scan8 ].
	currentCharacter == $' ifTrue: [ ^ self scan9 ].
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(23) ].
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	currentCharacter == $- ifTrue: [ ^ self scan10 ].
	currentCharacter == $. ifTrue: [ ^ self recordAndReportMatch: #(33) ].
	currentCharacter == $: ifTrue: [ ^ self recordAndReportMatch: #(22) ].
	currentCharacter == $; ifTrue: [ ^ self recordAndReportMatch: #(31) ].
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter == $^ ifTrue: [ ^ self recordAndReportMatch: #(17) ].
	^ self scan19X4
]

{ #category : #generated }
GtPharoScanner >> scan1X1 [
	[ self recordMatch: #(30).
	self step.
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ] ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan1X2 [
	[ self recordMatch: #(7).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan14 ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X3 [
	[ self recordMatch: #(35).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X4 [
	currentCharacter == ${ ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	currentCharacter == $| ifTrue: [ ^ self scan16 ].
	currentCharacter == $} ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	currentCharacter isDigit ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ]) ifTrue: [ ^ self scan1X3 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan1X2 ].
	((currentCharacter between: $! and: $~)
		or: [ ('±·' includes: currentCharacter)
				or: [ currentCharacter between: (Character value: 215) and: (Character value: 247) ] ])
		ifTrue: [ self scan1X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X5 [
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(23) ].
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	currentCharacter == $- ifTrue: [ ^ self scan10 ].
	currentCharacter == $. ifTrue: [ ^ self recordAndReportMatch: #(33) ].
	currentCharacter == $: ifTrue: [ ^ self scan11 ].
	currentCharacter == $; ifTrue: [ ^ self recordAndReportMatch: #(31) ].
	currentCharacter == $< ifTrue: [ ^ self scan12 ].
	currentCharacter == $> ifTrue: [ ^ self scan13 ].
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	currentCharacter == $^ ifTrue: [ ^ self recordAndReportMatch: #(17) ].
	currentCharacter == $` ifTrue: [ ^ self scan15 ].
	^ self scan1X4
]

{ #category : #generated }
GtPharoScanner >> scan2 [
	[ self step.
	currentCharacter == $" ifTrue: [ ^ self recordAndReportMatch: #(34) ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan20 [
	self recordMatch: #(16).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self step.
			currentCharacter == $: ifTrue: [ ^ self scan20 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan3 [
	self step.
	currentCharacter == $# ifTrue: [ ^ self scan3X1 ].
	^ self scan3X3
]

{ #category : #generated }
GtPharoScanner >> scan3X1 [
	self step.
	currentCharacter == $' ifTrue: [ ^ self scan4 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan5 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ ('\|~±·' includes: currentCharacter)
												or: [ currentCharacter between: (Character value: 215) and: (Character value: 247) ] ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(12).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan3X2 [
	[ self recordMatch: #(12).
	self step.
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~±·×÷' includes: currentCharacter ] ] ] ] ] ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan3X3 [
	currentCharacter == $' ifTrue: [ ^ self scan4 ].
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(24) ].
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(25) ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan5 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $\)
										or: [ ('|~±·' includes: currentCharacter)
												or: [ currentCharacter between: (Character value: 215) and: (Character value: 247) ] ] ] ] ] ])
		ifTrue: [ self scan3X2 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan4 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(12).
			self step.
			currentCharacter == $' ifTrue: [ ^ self scan4 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan5 [
	[ self recordMatch: #(12).
	self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(12).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan6 ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan7 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan6 [
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(12).
			self step.
			currentCharacter == $:
				ifTrue: [ self step.
					currentCharacter == $: ifTrue: [ ^ self scan6 ].
					^ self reportLastMatch ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan7 [
	[ self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(12).
			self step.
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan7 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan8 [
	self step.
	^ self recordAndReportMatch: #(13)
]

{ #category : #generated }
GtPharoScanner >> scan9 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(11).
			self step.
			currentCharacter == $' ifTrue: [ ^ self scan9 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scanForToken [
	scope == #default ifTrue: [ ^ self scan1 ].
	scope == #gs ifTrue: [ ^ self scan17 ].
	scope == #literalArray ifTrue: [ ^ self scan19 ].
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
GtPharoScanner >> templateId [
	^ 134
]

{ #category : #generated }
GtPharoScanner >> templateKeywordId [
	^ 135
]

{ #category : #generated }
GtPharoScanner >> templateNamePartId [
	^ 136
]

{ #category : #generated }
GtPharoScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil #number #negativeNumber nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #comment #whitespace #patternToken)
]
