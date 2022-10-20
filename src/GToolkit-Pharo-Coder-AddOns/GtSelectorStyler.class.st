Class {
	#name : #GtSelectorStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'stylingMethod'
	],
	#classVars : [
		'ErrorAttributes'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtSelectorStyler class >> errorAttributes [
	^ ErrorAttributes
		ifNil: [ ErrorAttributes := {BlTextDecorationAttribute new underline
						color: BrGlamorousColors errorBorderColor} ]
]

{ #category : #examples }
GtSelectorStyler class >> hasErrorAttributesIn: aText [
	| errorAttribute |
	errorAttribute := self errorAttributes first.
	aText
		attributesDo: [ :attrs :pos | (attrs includes: errorAttribute) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #examples }
GtSelectorStyler class >> hasMissingColonAttributeIn: aText [
	aText
		attributesDo: [ :attrs :pos | (attrs includes: GtImplicitColonAttribute new) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #examples }
GtSelectorStyler class >> invalidBinaryOrKeywordExample [
	<gtExample>
	| styler text |
	styler := self new forBinaryOrKeyword.
	^ #('+-a' '+a+' 'a+' 'a!:')
		collect: [ :each | 
			text := styler style: each asRopedText.
			self assert: (self hasErrorAttributesIn: text).
			text ]
]

{ #category : #examples }
GtSelectorStyler class >> invalidKeywordExample [
	<gtExample>
	| styler text |
	styler := self new forKeyword.
	^ #('+-a' '+a+' 'a+' 'a!:' '+-@' '++')
		collect: [ :each | 
			text := styler style: each asRopedText.
			self assert: (self hasErrorAttributesIn: text).
			text ]
]

{ #category : #examples }
GtSelectorStyler class >> invalidUnaryExample [
	<gtExample>
	| styler text |
	styler := self new forUnary.
	^ #('ab c' 'ab+' '+' 'a:')
		collect: [ :each | 
			text := styler style: each asRopedText.
			self assert: (self hasErrorAttributesIn: text).
			text ]
]

{ #category : #examples }
GtSelectorStyler class >> validBinaryOrKeywordExample [
	<gtExample>
	| styler text |
	styler := self new forBinaryOrKeyword.
	^ #('+-@' '++' 'a:' 'a_b23')
		collect: [ :each | 
			text := styler style: each asRopedText.
			self assert: (self hasErrorAttributesIn: text) not.
			self
				assert: (self hasMissingColonAttributeIn: text) not
				equals: (each first isLetter not or: [ each last = $: ]).
			text ]
]

{ #category : #examples }
GtSelectorStyler class >> validKeywordExample [
	<gtExample>
	| styler text |
	styler := self new forKeyword.
	^ #('a:' 'a_b23')
		collect: [ :each | 
			text := styler style: each asRopedText.
			self assert: (self hasErrorAttributesIn: text) not.
			self
				assert: (self hasMissingColonAttributeIn: text) not
				equals: each last = $:.
			text ]
]

{ #category : #examples }
GtSelectorStyler class >> validUnaryExample [
	<gtExample>
	| styler text |
	styler := self new forUnary.
	^ #('abc' 'ab_' '_' 'a_34')
		collect: [ :each | 
			text := styler style: each asRopedText.
			self assert: (self hasErrorAttributesIn: text) not.
			text ]
]

{ #category : #initialization }
GtSelectorStyler >> forBinaryOrKeyword [
	stylingMethod := #styleBinaryOrKeyword:
]

{ #category : #initialization }
GtSelectorStyler >> forKeyword [
	stylingMethod := #styleKeyword:
]

{ #category : #initialization }
GtSelectorStyler >> forUnary [
	stylingMethod := #styleUnary:
]

{ #category : #private }
GtSelectorStyler >> privateStyle: aText [
	self perform: stylingMethod with: aText.
	^ aText
]

{ #category : #private }
GtSelectorStyler >> styleBinaryOrKeyword: aText [
	| selector args |
	selector := aText asString.
	args := selector numArgs.
	args = 1 ifTrue: [ ^ self ].
	(args = 0 or: [ selector isEmpty ])
		ifTrue: [ ^ (aText from: aText size to: aText size)
				attributes: {GtImplicitColonAttribute new} ].
	aText attributes: self class errorAttributes
]

{ #category : #private }
GtSelectorStyler >> styleKeyword: aText [
	| selector args |
	selector := aText asString.
	args := selector numArgs.
	(args = 1 and: [ selector last = $: ]) ifTrue: [ ^ self ].
	(args = 0 or: [ selector isEmpty ])
		ifTrue: [ ^ (aText from: aText size to: aText size)
				attributes: {GtImplicitColonAttribute new} ].
	aText attributes: self class errorAttributes
]

{ #category : #accessing }
GtSelectorStyler >> styleUnary: aText [
	aText size = 0 ifTrue: [ ^ self ].
	(RBScanner isVariable: aText asString)
		ifFalse: [ aText attributes: self class errorAttributes ]
]
