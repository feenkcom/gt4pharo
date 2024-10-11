Class {
	#name : #GtStrictSymbolEqualityArgumentSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'left',
		'right',
		'leftClassName',
		'rightClassName',
		'methodName',
		'pc',
		'sourceIntervals'
	],
	#classVars : [
		'isRunning'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Signals'
}

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal class >> flagPragmaName [

	^ #gtSymbolStrictComparison
]

{ #category : #'start - stop' }
GtStrictSymbolEqualityArgumentSignal class >> isRunning [
	"Answer a boolean indicating if signals are being emitted.
	Handle isRunning == nil"

	^ isRunning == true
]

{ #category : #logging }
GtStrictSymbolEqualityArgumentSignal class >> left: leftObject right: rightObject [

	self isRunning ifFalse: [ ^ self ].
	"(leftObject isString or: [ leftObject isSymbol ]) ifFalse: [ ^ self ].
	(rightObject isString or: [ rightObject isSymbol ]) ifFalse: [ ^ self ]."

	self new
		left: leftObject;
		right: rightObject;
		emit.
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal class >> sameContentSelector [

	^ #sameContentAs:
]

{ #category : #'start - stop' }
GtStrictSymbolEqualityArgumentSignal class >> start [

	isRunning := true
]

{ #category : #'start - stop' }
GtStrictSymbolEqualityArgumentSignal class >> stop [

	isRunning := false
]

{ #category : #types }
GtStrictSymbolEqualityArgumentSignal class >> typeOf: aString [
	| cls |

	cls := self environment classOrTraitNamed: aString.
	(cls inheritsFrom: Symbol) ifTrue: [ ^ 'Symbol' ].
	(cls inheritsFrom: String) ifTrue: [ ^ 'String' ].
	"(cls inheritsFrom: Collection) ifTrue: [ ^ 'Collection' ]."
	^ aString.
]

{ #category : #initialization }
GtStrictSymbolEqualityArgumentSignal >> callingContext [
	"Answer the context that called #="

	^ self callingContextOfSelector: #= receiver: String
]

{ #category : #initialization }
GtStrictSymbolEqualityArgumentSignal >> callingContextOfSelector: aSymbol receiver: aClass [
	"Answer the context in the stack with selector aSymbol and receiver a kind of aClass.
	Ignore methods that have the gtSymbolStrictComparison pragma."
	| limit context searchLimit |

	context := thisContext sender.
	searchLimit := 30.
	limit := 1.
	[ limit >= searchLimit or:
		[ context isNil or: 
		[ context selector == aSymbol ] ] ] whileFalse:
			[ context := context sender.
			limit := limit + 1 ].
	[ limit < searchLimit and: 
		[ context isNotNil and: 
		[ context selector == aSymbol and:
		[ context receiver isKindOf: aClass ] ] ] ] whileTrue:
			[ context := context sender.
			limit := limit + 1 ].
	"Step past #~=, it isn't interesting"
	"(context isNotNil and: [ context selector == #~= ]) ifTrue:
		[ context := context sender ]."
	(context isNil or: 
		[ limit >= searchLimit or:
		[ context homeMethod hasPragmaNamed: self class flagPragmaName ] ])
			ifTrue: [ ^ nil ].
	^ context
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> id [

	^ sourceIntervals
		ifNil: [ methodName, '@', pc asString ]
		ifNotNil: 
			[ String streamContents: [ :stream |
				stream
					<< methodName;
					<< '@'.
				sourceIntervals do: [ :aSourceInterval |
					stream
						<< aSourceInterval first asString;
						<< '-';
						<< aSourceInterval stop asString ]
					separatedBy: [ stream nextPut: $, ] ] ].
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> left [
	^ left
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> left: anObject [
	left := anObject.
	leftClassName := anObject class name.
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> leftClassName [
	^ leftClassName
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> leftClassName: anObject [
	leftClassName := anObject
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> leftType [

	^ GtStrictSymbolEqualityArgumentSignal typeOf: leftClassName
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> methodName [
	^ methodName
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> pc [
	^ pc
]

{ #category : #initialization }
GtStrictSymbolEqualityArgumentSignal >> prepareForDelivery [
	"Determining the context is relatively expensive, so is only done if there is interest in the receiver.
	However it may still be an uninteresting method, i.e. already has the pragma set - in this case, the methodName is left nil and may be ignored by the serialiser."
	| callingContext node wasRunning |

	wasRunning := self class isRunning.
	self class stop.
	[ callingContext := self callingContext.
	callingContext ifNil: [ ^ self ].
	methodName := callingContext homeMethod printString.
	false ifTrue:
		[ Stdio stdout
			<< '---------------------';
			lf;
			<< methodName;
			lf;
			<< callingContext stackString withUnixLineEndings;
			lf;
			<< '======================';
			lf ].
	pc := callingContext pc.
	node := callingContext compiledCode sourceNodeForPC: pc.
	sourceIntervals := (node isMessage and: [ node selector == #= ])
		ifTrue: [ node keywordsIntervals ]
		ifFalse: [ (node allChildren select: [ :each | each isMessage and: [ each selector == #= ] ]) flatCollect: #keywordsIntervals ].
	sourceIntervals detect: [ :each | each size > 1 ]
		ifFound: [ :int | self halt ]
		ifNone: [].
		 ]
		ensure: [ wasRunning ifTrue: [ self class start ] ].
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> right [
	^ right
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> right: anObject [
	right := anObject.
	rightClassName := anObject class name.
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> rightClassName [
	^ rightClassName
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> rightClassName: anObject [
	rightClassName := anObject
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> rightType [

	^ GtStrictSymbolEqualityArgumentSignal typeOf: rightClassName
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> sourceIntervals [

	^ sourceIntervals
]
