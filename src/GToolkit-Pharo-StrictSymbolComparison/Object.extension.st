Extension { #name : #Object }

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
Object >> assertIsStringWhenStrict: aString [

	Symbol strictComparison ifFalse: [ ^ self ].
	self assert: aString isStrictString
		description: 'Only Strings allowed'.
]

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
Object >> assertIsSymbolWhenStrict: aSymbol [

	Symbol strictComparison ifFalse: [ ^ self ].
	self assert: aSymbol isSymbol
		description: 'Only Symbols allowed'.
]

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
Object >> assertSameTypeWhenStrict: leftValue and: rightValue [

	Symbol strictComparison ifFalse: [ ^ self ].
	self assert: leftValue strictSymbolComparisonClass == rightValue strictSymbolComparisonClass
		description: 'Both objects must be of the same type'.
]

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
Object >> assertStringOrSymbolWhenStrict: leftValue and: rightValue [

	Symbol strictComparison ifFalse: [ ^ self ].
	self assert: (leftValue strictSymbolComparisonClass == rightValue strictSymbolComparisonClass
		and: [ leftValue isKindOf: String ])
			description: 'Both objects must be of the same type and either Strings or Symbols'.
]

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
Object >> sameContentAs: anObject [

	^ self = anObject
]

{ #category : #'*GToolkit-Pharo-StrictSymbolComparison' }
Object >> strictSymbolComparisonClass [

	^ self class
]
