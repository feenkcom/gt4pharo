Class {
	#name : #GtStringSymbolComparisonMemoryLogger,
	#superclass : #GtStringSymbolComparisonLogger,
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Logging'
}

{ #category : #'start-stop' }
GtStringSymbolComparisonMemoryLogger >> start [

	logger ifNotNil:
		[ self error: 'Already started' ].
	logger := CircularMemoryLogger startFor: GtStrictSymbolEqualityArgumentSignal.
	GtStrictSymbolEqualityArgumentSignal start.
]
