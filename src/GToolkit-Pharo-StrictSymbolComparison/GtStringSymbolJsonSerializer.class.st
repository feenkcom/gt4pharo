Class {
	#name : #GtStringSymbolJsonSerializer,
	#superclass : #Object,
	#instVars : [
		'mutex'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Logging'
}

{ #category : #serializing }
GtStringSymbolJsonSerializer >> serializeSignal: aSignal logger: aLogger [ 

	^ String streamContents: [ :stream |
		self serializeSignal: aSignal on: stream logger: aLogger ].
]

{ #category : #serializing }
GtStringSymbolJsonSerializer >> serializeSignal: aSignal on: aStream logger: aLogger [ 
	"Serialise the supplied GtStringSignalContextStackSignal.
	If no methodName is recorded, ignore the signal.
	To avoid having to load all signals at once into a single collection,
	signals are written as individually serialised objects."
	| jsonDict |

	(aSignal class ~~ GtStrictSymbolEqualityArgumentSignal or:
		[ aSignal methodName isNil ]) ifTrue:
			[ ^ self ].
	jsonDict := Dictionary new.
	jsonDict
		at: #left put: aSignal left asString;
		at: #leftClassName put: aSignal leftClassName asString;
		at: #right put: aSignal right asString;
		at: #rightClassName put: aSignal rightClassName asString;
		at: #methodName put: aSignal methodName asString;
		at: #pc put: aSignal pc.
	STONJSON put: jsonDict onStreamPretty: aStream.
]
