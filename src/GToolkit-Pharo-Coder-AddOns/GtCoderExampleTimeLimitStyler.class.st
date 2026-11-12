"
I decorate the millisecond argument of the {{gtMethod:GtExample>>#timeLimit:}} example pragma with a human readable duration, e.g., `<timeLimit: 120000>` reads as `<timeLimit: 120000 ms (2 minutes)>`.
The decoration is a non-editable {{gtClass:BrTextAdornmentTextAttribute}} appended after the number literal, so the method source code stays unchanged.
I am added to example method coders by {{gtMethod:GtPharoMethodCoder>>#exampleAstFor:into:viewModel:}}.
See {{gtClass:GtCoderExampleTimeLimitStylerExamples}} for examples, e.g., {{gtExample:GtCoderExampleTimeLimitStylerExamples>>#timeLimitOfTwoMinutes}}.
"
Class {
	#name : #GtCoderExampleTimeLimitStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #accessing }
GtCoderExampleTimeLimitStyler >> timeLimitDecorationFor: aNumberOfMilliseconds [
	"Return a human readable decoration of a time limit in milliseconds, e.g., ' ms (2 minutes)', or nil for invalid values"

	| aDuration |
	(aNumberOfMilliseconds isNumber and: [ aNumberOfMilliseconds >= 0 ])
		ifFalse: [ ^ nil ].

	aDuration := aNumberOfMilliseconds milliSeconds.
	aDuration < 1 second ifTrue: [ ^ ' ms' ].

	^ ' ms (' , aDuration humanReadablePrintString , ')'
]

{ #category : #accessing }
GtCoderExampleTimeLimitStyler >> timeLimitDecorationTextFor: aNumberOfMilliseconds [
	^ (self timeLimitDecorationFor: aNumberOfMilliseconds)
		ifNotNil: [ :aString | 
			aString asRopedText
				glamorousCodeFontAndSize;
				foreground: BrGlamorousColors disabledButtonTextColor;
				yourself ]
]

{ #category : #visiting }
GtCoderExampleTimeLimitStyler >> visitPragma: aPragmaNode [
	| aValueNode aDecorationText |
	super visitPragma: aPragmaNode.

	aPragmaNode selector = #timeLimit: ifFalse: [ ^ self ].

	aValueNode := aPragmaNode values first.
	(aValueNode isKindOf: GtPharoNumberLiteralNode) ifFalse: [ ^ self ].

	aDecorationText := self timeLimitDecorationTextFor: aValueNode literalValue.
	aDecorationText ifNil: [ ^ self ].

	self
		attribute: (BrTextAdornmentTextAttribute new
				beAppend;
				text: aDecorationText)
		from: aValueNode stopPosition
		to: aValueNode stopPosition
]
