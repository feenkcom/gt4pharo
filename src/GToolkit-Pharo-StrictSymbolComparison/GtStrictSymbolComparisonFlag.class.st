Class {
	#name : #GtStrictSymbolComparisonFlag,
	#superclass : #Object,
	#classInstVars : [
		'UseStrictComparison'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-cli'
}

{ #category : #initialization }
GtStrictSymbolComparisonFlag class >> clearStrictComparison [

	^ UseStrictComparison := false
]

{ #category : #initialization }
GtStrictSymbolComparisonFlag class >> initialize [

	SessionManager default
		registerSystemClassNamed: self name
]

{ #category : #initialization }
GtStrictSymbolComparisonFlag class >> setStrictComparison [

	^ UseStrictComparison := true
]

{ #category : #initialization }
GtStrictSymbolComparisonFlag class >> startUp: resuming [
	"Set the strict comparison flag"

	"Any string comparisons made while processing the command line should not force strict comparison"
	UseStrictComparison := false.
	UseStrictComparison := Smalltalk commandLine argumentsInclude: '--strictSymbolComparison'.
]

{ #category : #testing }
GtStrictSymbolComparisonFlag class >> useStrictComparison [

	^ UseStrictComparison ifNil: [ false]
]
