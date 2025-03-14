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
		'sourceIntervals',
		'methodStack'
	],
	#classVars : [
		'isRunning'
	],
	#classInstVars : [
		'StringOnly',
		'StringSymbolOnly'
	],
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Signals'
}

{ #category : #logging }
GtStrictSymbolEqualityArgumentSignal class >> clearLogStringOnly [
	| old |

	old := { StringOnly. StringSymbolOnly. }.
	StringOnly := StringSymbolOnly := false.
	^ old
]

{ #category : #logging }
GtStrictSymbolEqualityArgumentSignal class >> clearLogStringSymbolOnly [
	| old |

	old := { StringOnly. StringSymbolOnly. }.
	StringSymbolOnly := false.
	^ old
]

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
	self logStringOnly ifTrue:
		[ (leftObject isString or: [ leftObject isSymbol ]) ifFalse: [ ^ self ].
		(rightObject isString or: [ rightObject isSymbol ]) ifFalse: [ ^ self ] ].
	(self logStringSymbolOnly and:
		[ (leftObject isSymbol lazyXor: [ rightObject isSymbol ]) not ]) 
			ifTrue: [ ^ self ].

	self new
		left: leftObject;
		right: rightObject;
		emit.
]

{ #category : #testing }
GtStrictSymbolEqualityArgumentSignal class >> logStringOnly [
	"Answer a boolean indicating whether to only emit the signal if both arguments are a kind of String.
	Handle nil value"

	^ StringOnly == true
]

{ #category : #testing }
GtStrictSymbolEqualityArgumentSignal class >> logStringSymbolOnly [
	"Answer a boolean indicating whether to only emit the signal if one argument is a string and the other is a symbol.
	Handle nil value"

	^ StringSymbolOnly == true
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal class >> sameContentSelector [

	^ #sameContentAs:
]

{ #category : #logging }
GtStrictSymbolEqualityArgumentSignal class >> setFrom: anArray [

	StringOnly := anArray first.
	StringSymbolOnly := anArray second.
]

{ #category : #logging }
GtStrictSymbolEqualityArgumentSignal class >> setLogStringOnly [
	| old |

	old := { StringOnly. StringSymbolOnly. }.
	StringOnly := true.
	^ old
]

{ #category : #logging }
GtStrictSymbolEqualityArgumentSignal class >> setLogStringSymbolOnly [
	| old |

	old := { StringOnly. StringSymbolOnly. }.
	StringOnly := StringSymbolOnly := true.
	^ old
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

{ #category : #ui }
GtStrictSymbolEqualityArgumentSignal >> gtMethodStackFor: aView [
	<gtView>

	methodStack ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Method Stack';
		priority: 20;
		items: [ methodStack ];
		send: [ :item | self methodFor: item ]
]

{ #category : #ui }
GtStrictSymbolEqualityArgumentSignal >> gtSourceCodeFor: aView [
	<gtView>

	methodName ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Source Code';
		priority: 20;
		object: [ self method ];
		view: #gtSourceCodeFor:
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
GtStrictSymbolEqualityArgumentSignal >> method [

	^ self class compiler evaluate: methodName.
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> methodFor: aContextPrintString [
	| fields className |

	aContextPrintString class = Context ifTrue: [ ^ aContextPrintString ].
	fields := '>>' split: aContextPrintString.
	className := ('(' split: ('] in ' split: fields first) last) first.
	^ (self class environment classOrTraitNamed: className)
		lookupSelector: fields second asSymbol
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> methodName [
	^ methodName
]

{ #category : #accessing }
GtStrictSymbolEqualityArgumentSignal >> methodNamesStack [
	"Answer a collection of all the method names in the receiver's stack"

	^ methodStack collect: [ :context | String streamContents: [ :stream |
		stream
			<< context homeMethod methodClass name;
			<< '>>';
			print: context homeMethod selector ] ]
]

{ #category : #private }
GtStrictSymbolEqualityArgumentSignal >> methodStackFrom: callingContext [

	^ (callingContext stackOfSize: 20) copy "collect: #printString"
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
	pc := callingContext pc.
	methodStack := self methodStackFrom: callingContext.
	node := callingContext compiledCode sourceNodeForPC: pc.
	sourceIntervals := (node isMessage and: [ node selector == #= ])
		ifTrue: [ node keywordsIntervals ]
		ifFalse: [ (node allChildren select: [ :each | each isMessage and: [ each selector == #= ] ]) flatCollect: #keywordsIntervals ].
	sourceIntervals detect: [ :each | each size > 1 ]
		ifFound: [ :int | self notYetImplemented ]
		ifNone: [].
		 ]
		ensure: [ wasRunning ifTrue: [ self class start ] ].
]

{ #category : #printing }
GtStrictSymbolEqualityArgumentSignal >> printOneLineContentsOn: stream [

	methodName ifNil: [ ^ super printOneLineContentsOn: stream ].
	stream
		<< methodName;
		<< ' ';
		print: leftClassName;
		<< ' = ';
		print: rightClassName.
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
