Class {
	#name : #GtStrictSymbolComparisonSummaryLogger,
	#superclass : #SignalLogger,
	#instVars : [
		'idDictionary',
		'byMethod'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Loggers'
}

{ #category : #'as yet unclassified' }
GtStrictSymbolComparisonSummaryLogger >> byId [

	^ idDictionary
]

{ #category : #'as yet unclassified' }
GtStrictSymbolComparisonSummaryLogger >> byMethod [

	^ byMethod ifNil: [ byMethod := idDictionary values groupedBy: #methodName ]
]

{ #category : #initialize }
GtStrictSymbolComparisonSummaryLogger >> initialize [

	super initialize.
	idDictionary := GtStringContentDictionary new.
]

{ #category : #'as yet unclassified' }
GtStrictSymbolComparisonSummaryLogger >> nextPut: aSignal [
	| summary |

	aSignal methodName ifNil: [ ^ self ].
	summary := idDictionary
		at: aSignal id
		ifAbsentPut: [ GtStrictSymbolSignalSummary new
			from: aSignal ].
	summary merge: aSignal.
]

{ #category : #registering }
GtStrictSymbolComparisonSummaryLogger >> start [

	self startFor: GtStrictSymbolEqualityArgumentSignal
]

{ #category : #registering }
GtStrictSymbolComparisonSummaryLogger >> stop [
	| fileReference |

	super stop.
	fileReference := ('StrictSymbolComparisonSummary.',
		GtOsSystemInfo current currentProcessId asString,
		'.log') asFileReference.
	fileReference writeStreamDo: [ :stream |
		STON put: idDictionary onStreamPretty: stream ].
]
