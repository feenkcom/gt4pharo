Class {
	#name : #GtPharoScanner,
	#superclass : #SmaCCScanner,
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #'generated-initialization' }
GtPharoScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(4 'false' 2) #(4 'nil' 3) #(4 'self' 32) #(4 'super' 33) #(4 'thisContext' 34) #(4 'true' 1))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
GtPharoScanner >> barId [
	^ 6
]

{ #category : #generated }
GtPharoScanner >> binaryId [
	^ 25
]

{ #category : #generated }
GtPharoScanner >> emptySymbolTokenId [
	^ 108
]

{ #category : #generated }
GtPharoScanner >> errorTokenId [
	^ 109
]

{ #category : #generated }
GtPharoScanner >> keywordId [
	^ 24
]

{ #category : #generated }
GtPharoScanner >> nameAssignmentId [
	^ 5
]

{ #category : #generated }
GtPharoScanner >> nameId [
	^ 4
]

{ #category : #scanning }
GtPharoScanner >> negativeNumber [
	stream position: stream position - 2.
	^ self scanNumber: self negativeNumberId
]

{ #category : #generated }
GtPharoScanner >> negativeNumberId [
	^ 10
]

{ #category : #scanning }
GtPharoScanner >> number [
	stream position: stream position - 1.
	^ self scanNumber: self numberId
]

{ #category : #generated }
GtPharoScanner >> numberId [
	^ 9
]

{ #category : #generated }
GtPharoScanner >> scan1 [
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self scan2 ].
	currentCharacter == $#
		ifTrue:
			[ ^ self scan1X5 ].
	currentCharacter == $$
		ifTrue: [ ^ self scan3 ].
	currentCharacter == $'
		ifTrue: [ ^ self scan4 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(18) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $-
		ifTrue: [ ^ self scan5 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	^ self scan1X11
]

{ #category : #generated }
GtPharoScanner >> scan1X1 [
	self recordMatch: #(6 25).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(25).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or:
													[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X10 [
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue:
			[ ^ self scan1X6 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ ('/=' includes: currentCharacter)
								or: [ (currentCharacter between: $? and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue:
			[ ^ self scan1X4 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			currentCharacter == $:
				ifTrue:
					[ ^ self scan1X8 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X11 [
	currentCharacter == $:
		ifTrue:
			[ ^ self scan1X7 ].
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	currentCharacter == $<
		ifTrue:
			[ ^ self scan1X3 ].
	currentCharacter == $>
		ifTrue:
			[ ^ self scan1X2 ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(22) ].
	currentCharacter == $^
		ifTrue: [ ^ self recordAndReportMatch: #(12) ].
	currentCharacter == $`
		ifTrue: [ ^ self scan6 ].
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(15) ].
	currentCharacter == $|
		ifTrue:
			[ ^ self scan1X1 ].
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(23) ].
	currentCharacter isDigit
		ifTrue:
			[ ^ self scan1X9 ].
	^ self scan1X10
]

{ #category : #generated }
GtPharoScanner >> scan1X2 [
	self recordMatch: #(14 25).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(25).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or:
													[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X3 [
	self recordMatch: #(13 25).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(25).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or:
													[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X4 [
	[ self recordMatch: #(25).
	self step.
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X5 [
	self recordMatch: #(35).
	self step.
	currentCharacter == $#
		ifTrue: [ ^ self recordAndReportMatch: #(35) ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X6 [
	[ self recordMatch: #(30).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X7 [
	self recordMatch: #(17).
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X8 [
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan1X9 [
	[ self recordMatch: #(9).
	self step.
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan2 [
	[ self step.
	currentCharacter == $"
		ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan3 [
	self step.
	^ self recordAndReportMatch: #(8)
]

{ #category : #generated }
GtPharoScanner >> scan4 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(7).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan4 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan5 [
	self recordMatch: #(25).
	self step.
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(10).
			self step.
			currentCharacter isDigit ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(25).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or:
													[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan6 [
	[ self step.
	currentCharacter == $`
		ifTrue: [ self recordMatch: #(31).
			self step.
			currentCharacter == $`
				ifTrue: [ ^ self scan6 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoScanner >> scan7 [
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self scan2 ].
	currentCharacter == $#
		ifTrue:
			[ ^ self scan7X4 ].
	currentCharacter == $$
		ifTrue: [ ^ self scan3 ].
	currentCharacter == $'
		ifTrue: [ ^ self scan4 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(18) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $-
		ifTrue: [ ^ self scan5 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(28) ].
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(26) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(22) ].
	currentCharacter isDigit
		ifTrue:
			[ ^ self scan7X5 ].
	^ self scan7X6
]

{ #category : #generated }
GtPharoScanner >> scan7X1 [
	[ self recordMatch: #(25).
	self step.
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan7X2 [
	self recordMatch: #(11 24).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan8 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan7X3 [
	[ self recordMatch: #(30).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan7X4 [
	self step.
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan7X5 [
	[ self recordMatch: #(9).
	self step.
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan7X6 [
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue:
			[ ^ self scan7X3 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or:
											[ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue:
			[ ^ self scan7X1 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			currentCharacter == $:
				ifTrue:
					[ ^ self scan7X2 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scan8 [
	[ self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(11).
			self step.
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan8 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoScanner >> scanForToken [
	scope == #literalArray
		ifTrue: [ ^ self scan7 ].
	scope == #default
		ifTrue: [ ^ self scan1 ].
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
GtPharoScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil #number #negativeNumber nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #comment #whitespace #patternToken)
]
