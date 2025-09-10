Class {
	#name : #GtPharoBlockClosureCoder,
	#superclass : #GtPharoSourceCoder,
	#instVars : [
		'class',
		'parameters',
		'bindingStrategy'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #'initialize-release' }
GtPharoBlockClosureCoder >> addParameter: aString ofType: aBehavior [
	parameters at: aString put: aBehavior.
	bindingStrategy bindings at: aString asSymbol put: nil
]

{ #category : #accessing }
GtPharoBlockClosureCoder >> block [
	self validateSyntax ifFalse: [ ^ nil ].

	^ (class ifNil: [ Object ]) compiler
		source: self blockSource;
		logged: false;
		failBlock: (self
				forPharo12AndNewer: [ [ :notice | 
					notice signalError.
					^ nil ] ]
				forPharo11: [ [ ^ nil ] ]);
		evaluate
]

{ #category : #private }
GtPharoBlockClosureCoder >> blockSource [
	^ self blockSourceFromText: self currentSourceText
]

{ #category : #private }
GtPharoBlockClosureCoder >> blockSource: aString [
	| ast startIndex endIndex |
	ast := GtPharoParser parse: aString startingAt: GtPharoParser startingStateForStatement.
	(ast isKindOf: GtPharoBlockNode)
		ifFalse: [ self error: 'Code is not a block' ].
	parameters := OrderedDictionary new.
	ast variables do: [ :each | self addParameter: each source ofType: nil ].
	startIndex := (ast bar notNil
		ifTrue: [ ast bar ]
		ifFalse: [ ast leftBracket ]) stopPosition + 1.
	endIndex := ast rightBracket startPosition - 1.
	[ startIndex < endIndex and: [ (aString at: startIndex) isSeparator ] ] whileTrue: [ startIndex := startIndex + 1 ].
	[ endIndex > startIndex and: [ (aString at: endIndex) isSeparator ] ] whileTrue: [ endIndex := endIndex - 1 ].

	self forSource: (aString copyFrom: startIndex to: endIndex)
]

{ #category : #private }
GtPharoBlockClosureCoder >> blockSourceFromText: aSourceTextOrString [
	^ String
		streamContents: [ :stream | 
			stream nextPut: $[.
			parameters
				keysDo: [ :each | 
					stream
						nextPut: $:;
						nextPutAll: each;
						nextPut: $  ].
			parameters notEmpty
				ifTrue: [ stream nextPutAll: '| ' ].
			stream
				nextPutAll: aSourceTextOrString;
				nextPut: $] ]
]

{ #category : #'api - ast' }
GtPharoBlockClosureCoder >> computeAst: theSourceString [
	| anAst anOffset |
	
	anAst := GtPharoParser
		parseWithErrors: (self blockSourceFromText: theSourceString)
		startingAt: GtPharoParser startingStateForMethodSequence.
	
	anAst := anAst statements first body.
	anAst parent: nil.
	anAst completeSource: theSourceString.

	anOffset := 1 - anAst startPosition.
	anAst withAllNodesDo: [ :eachNode |
		eachNode removeAttributeNamed: #startPosition.
		eachNode removeAttributeNamed: #stopPosition ]
	andTokensDo: [ :eachToken |
		eachToken
			value: eachToken value
			start: eachToken startPosition + anOffset
			ids: eachToken ids ]
	includesErrors: true.
	
	^ anAst
]

{ #category : #'api - actions' }
GtPharoBlockClosureCoder >> doItAndGoInContext: aGtSourceCoderEvaluationContext [
	^ self
		evaluate: [ :thisCoder | thisCoder blockSource ]
		inContext: aGtSourceCoderEvaluationContext
		thenDo: [ :anEvaluationResult | 
			self notifyEvaluatedWithResult: anEvaluationResult.
			self
				notifyObjectSpawnFromEvaluationResult: anEvaluationResult
				requesterObject: aGtSourceCoderEvaluationContext requesterObject ]
]

{ #category : #'api - actions' }
GtPharoBlockClosureCoder >> doItInContext: aGtSourceCoderEvaluationContext thenDo: aBlock [
	^ self
		evaluate: [ :thisCoder | thisCoder blockSource ]
		inContext: aGtSourceCoderEvaluationContext
		thenDo: aBlock
]

{ #category : #'initialize-release' }
GtPharoBlockClosureCoder >> forSource: aString [
	self sourceCode: (GtCoderExplicitStringSource new source: aString)
]

{ #category : #private }
GtPharoBlockClosureCoder >> highlightBindingsStrategy [
	self flag: #TODO.

	^ self context 
		ifNil:  [ bindingStrategy ]
		ifNotNil: [ bindingStrategy ] 
]

{ #category : #'initialize-release' }
GtPharoBlockClosureCoder >> initialize [
	parameters := OrderedDictionary new.
	bindingStrategy := GtLocalVariablesBindings new.

	super initialize
]

{ #category : #updating }
GtPharoBlockClosureCoder >> newRbAST: aString [
	| ast |
	ast := self
		parseExpression: (self blockSourceFromText: aString)
		requestor: GtLocalVariablesBindings new.
	ast doSemanticAnalysis.
	ast gtMoveAllBy: 1 - ast body start.
	^ ast body
]
