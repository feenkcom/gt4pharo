Class {
	#name : #GtMessageSendIterator,
	#superclass : #Object,
	#instVars : [
		'code',
		'conditionalForwardJumps',
		'backwardJumps',
		'referencesBlock',
		'globalsBlock'
	],
	#classVars : [
		'ConditionalSelectors',
		'LoopSelectors'
	],
	#category : #'GToolkit-Pharo-Completer-Completion'
}

{ #category : #examples }
GtMessageSendIterator class >> example [
	<gtExample>
	
	| messages condition values |
	"Some dummy code to affect the results"
	condition := #printString = #printOn:.
	condition
		ifTrue: [ [ condition not ] whileTrue: [ condition := condition not ] ].
	condition ifFalse: [ condition := condition not ].

	messages := GtPrefixTree new.
	self
		messageSendsIn: thisContext method
		doReferences: [ :selector :count | messages add: selector weight: count ]
		andGlobals: nil.
	values := #(#('=' 1) #('ifTrue:' 1) #('not' 3) #('whileTrue:' 1) #('ifFalse:' 1) #('new' 1) #(#messageSendsIn:doReferences: 1) #('method' 1) #(#add:weight: 1) #('do:' 1) #('assert:equals:' 2) #('weightOf:' 1) #('first' 1) #('last' 1) #('size' 2)).
	values
		do: [ :each | self assert: (messages weightOf: each first) equals: each last ].
	self assert: values size equals: messages size.
	^ messages
]

{ #category : #initialization }
GtMessageSendIterator class >> initialize [
	ConditionalSelectors := IdentitySet
		withAll:
			#(ifTrue: ifFalse: and: or: #ifTrue:ifFalse: #ifFalse:ifTrue: ifNil: ifNotNil: #ifNil:ifNotNil: #ifNotNil:ifNil: caseOf: #caseOf:otherwise:).
	LoopSelectors := IdentitySet withAll: #(whileTrue whileTrue: whileFalse whileFalse: #to:do: #to:by:do: repeat)
]

{ #category : #processing }
GtMessageSendIterator class >> messageSendsIn: aCompiledCode doReferences: aBlock andGlobals: globalsBlock [
	self new
		messageSendsIn: aCompiledCode
		doReferences: aBlock
		andGlobals: globalsBlock
]

{ #category : #'instruction decoding' }
GtMessageSendIterator >> conditionalJump: distance [
	distance > 0
		ifTrue: [ conditionalForwardJumps := conditionalForwardJumps + 1 ]
		ifFalse: [ backwardJumps := backwardJumps + 1 ]
]

{ #category : #initialization }
GtMessageSendIterator >> initialize [
	super initialize.
	conditionalForwardJumps := 0.
	backwardJumps := 0
]

{ #category : #'instruction decoding' }
GtMessageSendIterator >> jump: distance [
	distance > 0 ifFalse: [ backwardJumps := backwardJumps + 1 ]
]

{ #category : #processing }
GtMessageSendIterator >> messageSendsIn: aCompiledCode doReferences: aBlock andGlobals: anotherBlock [
	referencesBlock := aBlock.
	globalsBlock := anotherBlock.
	code := aCompiledCode.
	self processNormalSends.
	self processBlocksAndOptimizedSends
]

{ #category : #processing }
GtMessageSendIterator >> processBlocksAndOptimizedSends [
	| loopSelectors count conditionalSelectors |
	conditionalSelectors := OrderedCollection new.
	loopSelectors := OrderedCollection new.
	1
		to: code numLiterals - code literalsToSkip
		do: [ :index | 
			| value |
			value := code literalAt: index.
			value isSymbol
				ifTrue: [ (ConditionalSelectors includes: value)
						ifTrue: [ conditionalSelectors add: value ].
					(LoopSelectors includes: value) ifTrue: [ loopSelectors add: value ] ]
				ifFalse: [ (value isKindOf: CompiledCode)
						ifTrue: [ self class
								messageSendsIn: value
								doReferences: referencesBlock
								andGlobals: globalsBlock ] ] ].	"We don't know which jumps correspond to which sends, so we just estimate them."
	conditionalForwardJumps := conditionalForwardJumps - backwardJumps max: 0.
	conditionalForwardJumps > 0
		ifTrue: [ conditionalSelectors notEmpty
				ifTrue: [ count := (conditionalForwardJumps / conditionalSelectors size) ceiling.
					conditionalSelectors
						do: [ :each | referencesBlock value: each value: count ] ]
				ifFalse: [ backwardJumps := backwardJumps + conditionalForwardJumps ] ].
	(backwardJumps > 0 and: [ loopSelectors notEmpty ])
		ifTrue: [ count := (backwardJumps / loopSelectors size) ceiling.
			loopSelectors do: [ :each | referencesBlock value: each value: count ] ]
]

{ #category : #processing }
GtMessageSendIterator >> processNormalSends [
	| instruction instructionStream endPc |
	instructionStream := InstructionStream on: code.
	endPc := instructionStream method endPC.
	[ instructionStream pc > endPc ]
		whileFalse: [ instruction := instructionStream nextInstruction.
			#send:super:numArgs: = instruction selector
				ifTrue: [ referencesBlock value: instruction arguments first value: 1 ]
				ifFalse: [ #jump: = instruction selector
						ifTrue: [ self jump: instruction arguments first ]
						ifFalse: [ #jump:if: = instruction selector
								ifTrue: [ self conditionalJump: instruction arguments first ]
								ifFalse: [ #pushConstant: = instruction selector
										ifTrue: [ self pushLiteral: instruction arguments first ]
										ifFalse: [ #pushLiteralVariable: = instruction selector
												ifTrue: [ self pushLiteralVariable: instruction arguments first ] ] ] ] ] ]
]

{ #category : #processing }
GtMessageSendIterator >> pushLiteral: aValue [
	aValue isSymbol
		ifTrue: [ aValue numArgs >= 0 ifTrue: [ referencesBlock value: aValue value: 1 ] ]
		ifFalse: [ aValue isArray ifTrue: [ aValue do: [ :each | self pushLiteral: each ] ] ]
]

{ #category : #accessing }
GtMessageSendIterator >> pushLiteralVariable: aVariable [
	(aVariable isKindOf: GlobalVariable) ifTrue: [ globalsBlock cull: aVariable cull: 1 ]
]
