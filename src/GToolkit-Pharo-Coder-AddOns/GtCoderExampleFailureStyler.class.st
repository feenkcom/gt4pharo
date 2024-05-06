Class {
	#name : #GtCoderExampleFailureStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'programCounterAttribute'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Example status'
}

{ #category : #accessing }
GtCoderExampleFailureStyler >> extraStyle: aText ast: theAst [
	| currentExample exampleStackFrame pcRangeInterval |
	
	programCounterAttribute ifNotNil: [ :theAttribute | 
		aText removeAttribute: theAttribute ].
	
	super extraStyle: aText ast: theAst.
	
	self coderViewModel ifNil: [ ^ self ].
	
	currentExample := self coderViewModel coderModel example.
	currentExample ifNil: [ ^ self ].
	
	(self hasFailureOrErrorResultInExample: currentExample) ifFalse: [ ^ self ].
	
	exampleStackFrame := self locateFailureStackFrameForExample: currentExample.
	(exampleStackFrame isNil or: [ 
		exampleStackFrame isDead ]) ifTrue: [ ^ self ].
	
	pcRangeInterval := exampleStackFrame pcRangeContextIsActive: false.
	programCounterAttribute := (BlTextHighlightAttribute 
		paint: BrGlamorousColors debuggerTextHighlightColor)
			beNotOverwritableByStyler.
	aText
		attribute: programCounterAttribute
		from: (pcRangeInterval first min: aText text size)
		to: (pcRangeInterval last min: aText text size)
]

{ #category : #accessing }
GtCoderExampleFailureStyler >> hasFailureOrErrorResultInExample: anExample [
	^ anExample hasResult and: [
		anExample result isError or: [ 
			anExample result isFailure  ]]
]

{ #category : #accessing }
GtCoderExampleFailureStyler >> locateFailureStackFrameForExample: anExample [
	| targetMethod |
	targetMethod := anExample method.
			
	^ anExample returnValue signalerContext stack
		detect: [ :aContext | 
			aContext compiledCode = targetMethod ]
		ifNone: [ nil ]
]
