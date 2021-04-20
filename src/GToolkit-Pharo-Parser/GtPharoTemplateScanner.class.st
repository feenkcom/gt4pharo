Class {
	#name : #GtPharoTemplateScanner,
	#superclass : #SmaCCScanner,
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #'generated-initialization' }
GtPharoTemplateScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(4 'false' 2) #(4 'nil' 3) #(4 'self' 33) #(4 'super' 34) #(4 'thisContext' 35) #(4 'true' 1))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
GtPharoTemplateScanner >> barId [
	^ 6
]

{ #category : #generated }
GtPharoTemplateScanner >> binaryId [
	^ 25
]

{ #category : #generated }
GtPharoTemplateScanner >> emptySymbolTokenId [
	^ 122
]

{ #category : #generated }
GtPharoTemplateScanner >> errorTokenId [
	^ 123
]

{ #category : #generated }
GtPharoTemplateScanner >> keywordId [
	^ 24
]

{ #category : #generated }
GtPharoTemplateScanner >> nameAssignmentId [
	^ 5
]

{ #category : #generated }
GtPharoTemplateScanner >> nameId [
	^ 4
]

{ #category : #generated }
GtPharoTemplateScanner >> negativeNumberId [
	^ 10
]

{ #category : #generated }
GtPharoTemplateScanner >> numberId [
	^ 9
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1 [
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self scan2 ].
	currentCharacter == $#
		ifTrue:
			[ ^ self scan1X6 ].
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
	^ self scan1X13
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X1 [
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
GtPharoTemplateScanner >> scan1X10 [
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X11 [
	[ self recordMatch: #(9).
	self step.
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X12 [
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue:
			[ ^ self scan1X5 ].
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
					[ ^ self scan1X10 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X13 [
	currentCharacter == $:
		ifTrue:
			[ ^ self scan1X9 ].
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
		ifTrue:
			[ ^ self scan1X8 ].
	currentCharacter == $|
		ifTrue:
			[ ^ self scan1X1 ].
	currentCharacter == $}
		ifTrue:
			[ ^ self scan1X7 ].
	currentCharacter isDigit
		ifTrue:
			[ ^ self scan1X11 ].
	^ self scan1X12
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X2 [
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
GtPharoTemplateScanner >> scan1X3 [
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
GtPharoTemplateScanner >> scan1X4 [
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
GtPharoTemplateScanner >> scan1X5 [
	[ self recordMatch: #(31).
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self scan2 ].
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X6 [
	self recordMatch: #(36).
	self step.
	currentCharacter == $#
		ifTrue: [ ^ self recordAndReportMatch: #(36) ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X7 [
	self recordMatch: #(23).
	self step.
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(38) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X8 [
	self recordMatch: #(15).
	self step.
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(37) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan1X9 [
	self recordMatch: #(17).
	self step.
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(27) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan2 [
	[ self step.
	currentCharacter == $"
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter isSeparator
				or: [ currentCharacter == Character null
						or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoTemplateScanner >> scan3 [
	self step.
	^ self recordAndReportMatch: #(8)
]

{ #category : #generated }
GtPharoTemplateScanner >> scan4 [
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
GtPharoTemplateScanner >> scan5 [
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
GtPharoTemplateScanner >> scan6 [
	[ self step.
	currentCharacter == $`
		ifTrue: [ self recordMatch: #(32).
			self step.
			currentCharacter == $`
				ifTrue: [ ^ self scan6 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtPharoTemplateScanner >> scan7 [
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
GtPharoTemplateScanner >> scan7X1 [
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
GtPharoTemplateScanner >> scan7X2 [
	[ self recordMatch: #(30).
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self scan2 ].
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan7X3 [
	self recordMatch: #(11 24).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan8 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan7X4 [
	self step.
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(19) ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan7X5 [
	[ self recordMatch: #(9).
	self step.
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan7X6 [
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue:
			[ ^ self scan7X2 ].
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
					[ ^ self scan7X3 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> scan8 [
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
GtPharoTemplateScanner >> scanForToken [
	scope == #literalArray
		ifTrue: [ ^ self scan7 ].
	scope == #default
		ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtPharoTemplateScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #comment #whitespace nil #patternToken)
]
