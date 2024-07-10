Class {
	#name : #GtCoderExampleFailureStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'styleBlock'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Example status'
}

{ #category : #accessing }
GtCoderExampleFailureStyler >> extraStyle: aText ast: theAst [
	| currentExample exampleStackFrame pcRangeInterval highlightColor subText |
	super extraStyle: aText ast: theAst.

	self coderViewModel ifNil: [ ^ self ].
	
	"It is preferable not to highlight example errors if code is modified,
	since the text range does not corresponds to the PC range interval."
	self coderViewModel isModified ifTrue: [ ^ self ].

	currentExample := self coderViewModel coderModel example.
	currentExample ifNil: [ ^ self ].

	(self hasFailureOrErrorResultInExample: currentExample) ifFalse: [ ^ self ].

	exampleStackFrame := self locateFailureStackFrameForExample: currentExample.
	(exampleStackFrame isNil or: [ exampleStackFrame isDead ]) ifTrue: [ ^ self ].

	pcRangeInterval := exampleStackFrame pcRangeContextIsActive: false.
	highlightColor :=  (currentExample returnValue isKindOf: AssertionFailure)
		ifTrue: [ BrGlamorousColors debuggerTextHighlightColor ]
		ifFalse: [ BrGlamorousColors errorBackgroundColor ].
		
	subText := aText 
		from: (pcRangeInterval first min: aText text size)
		to: (pcRangeInterval last min: aText text size).
		
	self styleBlock cull: subText cull: highlightColor.
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
			self flag: 'We may want to re-use {{gtMethod:GtPharoEvaluatedCode>>#isRelevantContextInStack:}} (TGtSourceCoderEvaluatedCode objects).'.
			aContext isBlockContext
				ifTrue: [ aContext compiledCode method = targetMethod ]
				ifFalse: [ aContext compiledCode = targetMethod ] ]
		ifNone: [ nil ]
]

{ #category : #accessing }
GtCoderExampleFailureStyler >> styleBlock [
	^ styleBlock ifNil: [ styleBlock := [ :aText :aColor | aText highlight: aColor ] ]
]

{ #category : #accessing }
GtCoderExampleFailureStyler >> styleBlock: aBlock [
	"Block receives text that should be highlighted using a given color: [ :aBlText :aColor | ... ]"

	styleBlock := aBlock
]
