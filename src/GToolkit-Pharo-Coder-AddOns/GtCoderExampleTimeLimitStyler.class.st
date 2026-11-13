"
I decorate the millisecond argument of the {{gtMethod:GtExample>>#timeLimit:}} example pragma with a human readable duration, e.g., `<timeLimit: 120000>` reads as `<timeLimit: 120000 ms (2 minutes)>`.
The decoration is a non-editable {{gtClass:BrTextAdornmentTextAttribute}} appended after the number literal, so the method source code stays unchanged.
I am added to example method coders by {{gtMethod:GtPharoMethodCoder>>#exampleAstFor:into:viewModel:}}.
See {{gtClass:GtCoderExampleTimeLimitStylerExamples}} for examples, e.g., {{gtExample:GtCoderExampleTimeLimitStylerExamples>>#timeLimitsOverview | codeExpanded=false | previewExpanded=true | previewHeight=500}}
.
"
Class {
	#name : #GtCoderExampleTimeLimitStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Examples'
}

{ #category : #private }
GtCoderExampleTimeLimitStyler >> printCount: aCount unit: aUnitName [
	^ aCount printString , ' ' , aUnitName
		, (aCount = 1 ifTrue: [ '' ] ifFalse: [ 's' ])
]

{ #category : #accessing }
GtCoderExampleTimeLimitStyler >> timeLimitDecorationFor: aNumberOfMilliseconds [
	"Return a short human readable decoration of a time limit in milliseconds, e.g., ' ms (2 minutes)', ' ms (~3 minutes)' if the value is not exact, or nil for invalid values"

	(aNumberOfMilliseconds isNumber and: [ aNumberOfMilliseconds >= 0 ])
		ifFalse: [ ^ nil ].

	aNumberOfMilliseconds < 1000 ifTrue: [ ^ ' ms' ].

	^ ' ms (' , (self timeLimitLabelFor: aNumberOfMilliseconds) , ')'
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

{ #category : #accessing }
GtCoderExampleTimeLimitStyler >> timeLimitLabelFor: aNumberOfMilliseconds [
	"Return a single number with a unit, e.g., '2 minutes', '90 seconds', or '~3 minutes'.
	Use the largest unit in which the time limit is a whole number up to 99.
	Otherwise, round it in the largest unit in which it is at least 2 and mark it with ~"

	| theUnits |
	theUnits := {3600000 -> 'hour'.
			60000 -> 'minute'.
			1000 -> 'second'}.

	theUnits
		do: [ :eachUnit | 
			| aValue |
			aValue := aNumberOfMilliseconds / eachUnit key.
			(aValue isInteger and: [ aValue <= 99 ])
				ifTrue: [ ^ self printCount: aValue unit: eachUnit value ] ].

	theUnits
		do: [ :eachUnit | 
			| aValue |
			aValue := aNumberOfMilliseconds / eachUnit key.
			(aValue >= 2 or: [ eachUnit = theUnits last ])
				ifTrue: [ ^ '~' , (self printCount: aValue rounded unit: eachUnit value) ] ].

	^ nil
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
