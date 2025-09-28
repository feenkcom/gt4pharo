Class {
	#name : #GtStrictSymbolFilteredLog,
	#superclass : #Object,
	#instVars : [
		'signalLogger',
		'mismatchedMethodNames'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Analysis'
}

{ #category : #accessing }
GtStrictSymbolFilteredLog class >> mistmatchedMethodNames [
	"Answer a Set of methods known to generate mismatched equality calls"

	^ Set withAll: #(
		'SourceFileArray>>#timeStampAt:for:'
		)
]

{ #category : #accessing }
GtStrictSymbolFilteredLog >> filteredLogger [
	"Answer a MemoryLogger with the filtered signals"
	
	^ MemoryLogger withRecordings: self filteredSignals
]

{ #category : #accessing }
GtStrictSymbolFilteredLog >> filteredSignals [

	^ self recordings reject: [ :each |
		each methodNamesStack anySatisfy: [ :name |
			self mistmatchedMethodNames includes: name ] ]
]

{ #category : #ui }
GtStrictSymbolFilteredLog >> gtRecordingsFor: aView [
	<gtView>
	| filteredLogger |

	filteredLogger := self filteredLogger.
	^ aView forward
		title: 'Recordings';
		priority: 20;
		object: [ filteredLogger ];
		view: #gtRecordingsFor:;
		actionButtonDo: [ :aButtonAction |
			aButtonAction
				icon: BrGlamorousVectorIcons refresh;
				tooltip: 'Regenerate';
				action: [ :aButton :aTab |
					filteredLogger initializeWithRecordings: self filteredSignals.
					aTab viewContentElement phlow update ] ]
]

{ #category : #ui }
GtStrictSymbolFilteredLog >> gtResetActionFor: anAction [
	<gtAction>

	signalLogger class = CircularMemoryLogger ifFalse:
		[ ^ anAction noAction ].
	^ anAction button
		icon: BrGlamorousVectorIcons bin;
		tooltip: 'Reset Logger';
		priority: 3;
		action: [ :aButton | signalLogger reset ]
]

{ #category : #ui }
GtStrictSymbolFilteredLog >> gtStartActionFor: anAction [
	<gtAction>

	signalLogger class = CircularMemoryLogger ifFalse:
		[ ^ anAction noAction ].
	^ anAction button
		icon: BrGlamorousVectorIcons play;
		tooltip: 'Start Logger';
		priority: 1;
		action: [ :aButton | signalLogger start ]
]

{ #category : #ui }
GtStrictSymbolFilteredLog >> gtStopActionFor: anAction [
	<gtAction>

	signalLogger class = CircularMemoryLogger ifFalse:
		[ ^ anAction noAction ].
	^ anAction button
		icon: BrGlamorousVectorIcons cancel;
		tooltip: 'Stop Logger';
		priority: 2;
		action: [ :aButton | signalLogger stop ]
]

{ #category : #accessing }
GtStrictSymbolFilteredLog >> mistmatchedMethodNames [

	^ mismatchedMethodNames ifNil: [ mismatchedMethodNames := self class mistmatchedMethodNames ]
]

{ #category : #accessing }
GtStrictSymbolFilteredLog >> recordings [

	^ signalLogger recordings
]

{ #category : #accessing }
GtStrictSymbolFilteredLog >> signalLogger [
	^ signalLogger
]

{ #category : #accessing }
GtStrictSymbolFilteredLog >> signalLogger: aSignalLogger [

	signalLogger := aSignalLogger
]
