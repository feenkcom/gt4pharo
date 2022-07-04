Class {
	#name : #GtPharoCompleterExamplesMethodBodyTextStyler,
	#superclass : #BrRBTextStyler,
	#instVars : [
		'methodPatternSource'
	],
	#category : #'GToolkit-Pharo-Completer-Examples'
}

{ #category : #adding }
GtPharoCompleterExamplesMethodBodyTextStyler >> addAttributes: attributes from: start to: stop [
	| length |
	length := methodPatternSource size + 1.
	start <= length
		ifTrue: [ ^ self ].
	^ super addAttributes: attributes from: start - length to: stop - length
]

{ #category : #accessing }
GtPharoCompleterExamplesMethodBodyTextStyler >> methodPatternSource: aString [
	methodPatternSource := aString
]

{ #category : #parsing }
GtPharoCompleterExamplesMethodBodyTextStyler >> parse: aText isMethod: isMethod [
	| source |
	source := methodPatternSource , ' ' , aText asString.
	^ super parse: source isMethod: true
]
