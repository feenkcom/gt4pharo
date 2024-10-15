Class {
	#name : #GtStrictSymbolExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Examples'
}

{ #category : #performance }
GtStrictSymbolExamples class >> contextStackSignalTimes [
	"Measure how long it takes to emit and capture context stack signals"
	| logger sampleSize loopCount times |

	times := OrderedCollection new.
	sampleSize := 10.
	loopCount := 10000.
	sampleSize timesRepeat:
		[ logger := MemoryLogger new startFor: GtJustContextStackSignal.
		2 timesRepeat: [ Smalltalk garbageCollect ].
		times add: [(1 to: loopCount) collect: [ :i |
			GtJustContextStackSignal emit ] ] timeToRun ].
	^ { times average asMilliSeconds asFloat / loopCount. times }.
]

{ #category : #examples }
GtStrictSymbolExamples >> callingContext [
	<gtExample>
	| callingContext |

	callingContext := self getCallingContext.
	self assert: callingContext selector identicalTo: #callingContext.
	self assert: callingContext receiver identicalTo: self.
	^ callingContext
]

{ #category : #examples }
GtStrictSymbolExamples >> callingMethod [
	"Demonstrate getting the calling method from a GtStringSignalContextStackSignal"
	<gtExample>
	<noTest>
	| wasRunning logger signal |

	[ wasRunning := GtStrictSymbolEqualityArgumentSignal isRunning.
	"If you want to debug this, change #valueUnpreemptively to #value"
	[ GtStrictSymbolEqualityArgumentSignal start.
	logger := CircularMemoryLogger new
		runFor: GtStrictSymbolEqualityArgumentSignal
		during: [ self 
						compareEqualStringSymbol;
						compareEqualSymbolString ] ]
			ensure:
				[ wasRunning ifFalse: [ GtStrictSymbolEqualityArgumentSignal stop ] ].
	 ]
			value "Unpreemptively".
	self assert: logger recordings size equals: 2.

	signal := logger recordings first.
	self assert:  signal methodName equals: 'GtStrictSymbolExamples>>#compareEqualStringSymbol'.
	self assert: signal pc identicalTo: 44.
	signal := logger recordings second.
	self assert:  signal methodName equals: 'GtStrictSymbolExamples>>#compareEqualSymbolString'.
	self assert: signal pc identicalTo: 44.

	^ logger
]

{ #category : #private }
GtStrictSymbolExamples >> compareEqualStringSymbol [

	^ 'a' = #a
]

{ #category : #private }
GtStrictSymbolExamples >> compareEqualSymbolString [

	^ #a = 'a'
]

{ #category : #private }
GtStrictSymbolExamples >> compareWithFlag [

	^ GtStrictSymbolEqualityArgumentSignal new
		callingContextOfSelector: #compareWithFlag receiver: self class
]

{ #category : #examples }
GtStrictSymbolExamples >> flaggedComparison [
	"Request the calling context of a method (this method) with a flag pragma set"
	<gtExample>
	<gtSymbolStrictComparison>

	self assert:  self compareWithFlag isNil.
]

{ #category : #private }
GtStrictSymbolExamples >> getCallingContext [

	^ self getCallingContext1
]

{ #category : #private }
GtStrictSymbolExamples >> getCallingContext1 [

	^ self getCallingContext2
]

{ #category : #private }
GtStrictSymbolExamples >> getCallingContext2 [

	^ GtStrictSymbolEqualityArgumentSignal new
		callingContextOfSelector: #getCallingContext receiver: self class
]

{ #category : #examples }
GtStrictSymbolExamples >> jsonSerialization [
	<gtExample>
	<noTest>
	| signals serializer serialized |

	signals := self callingMethod recordings.
	serializer := GtStringSymbolJsonSerializer new.
	serialized := serializer serializeSignal: signals first logger: nil.
	self assert: serialized withUnixLineEndings equals:
'{
	"left" : "a",
	"right" : "a",
	"leftClassName" : "ByteString",
	"pc" : 44,
	"rightClassName" : "ByteSymbol",
	"methodName" : "GtStrictSymbolExamples>>#compareEqualStringSymbol"
}' withUnixLineEndings.
	^ serialized
]
