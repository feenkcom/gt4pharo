Class {
	#name : #GtStrictSymbolScenarios,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Examples'
}

{ #category : #scenarios }
GtStrictSymbolScenarios >> compareParameter: param1 to: param2 [
	"param1 = param2"

	^ param1 = param2
]

{ #category : #scenarios }
GtStrictSymbolScenarios >> compareParameterToString: aString [
	"aString = 'a'"

	^ aString = 'a'
]

{ #category : #scenarios }
GtStrictSymbolScenarios >> compareParameterToSymbol: aSymbol [
	"aSymbol = #a"

	^ aSymbol = #a
]

{ #category : #scenarios }
GtStrictSymbolScenarios >> compareStringToParameter: aString [
	"'a' = aString"

	^ 'a' = aString
]

{ #category : #scenarios }
GtStrictSymbolScenarios >> compareSymbolToParameter: aSymbol [
	"#a = aSymbol"

	^ #a = aSymbol
]
