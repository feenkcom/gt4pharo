Class {
	#name : #GtStringSymbolComparisonJsonLogger,
	#superclass : #GtStringSymbolComparisonLogger,
	#instVars : [
		'logFile'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Logging'
}

{ #category : #accessing }
GtStringSymbolComparisonJsonLogger >> logFile [
	^ logFile ifNil: [ logFile := ('StringSymbolComparison.',
		GtOsSystemInfo current currentProcessId asString,
		'.log') asFileReference ]
]

{ #category : #accessing }
GtStringSymbolComparisonJsonLogger >> logFile: anObject [
	logFile := anObject
]

{ #category : #'start-stop' }
GtStringSymbolComparisonJsonLogger >> start [
	| stream |

	logger ifNotNil: [ self error: 'Already started' ].
	stream := self logFile writeStream.
	logger := CustomStreamLogger new
		serializer: GtStringSymbolJsonSerializer new;
		stream: stream.
	logger startFor: GtStrictSymbolEqualityArgumentSignal.
	GtStrictSymbolEqualityArgumentSignal start.
]
