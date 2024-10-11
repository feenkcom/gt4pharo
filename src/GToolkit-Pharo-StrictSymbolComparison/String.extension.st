Extension { #name : #String }

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
String >> sameContentAs: aString [
	"Answer whether the receiver sorts equally as aString.
	The collation order is simple ascii (with case differences)."
	" 'abc' = 'def' >>> false"
	" 'abc' = 'abc' >>> true"
	" 'def' = 'abc' >>> false"

	(aString isString and: [self size = aString size]) ifFalse: [^false].
	^ (self compare: self with: aString collated: AsciiOrder) = 2
]

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
String >> strictSymbolComparisonClass [

	^ String
]
