Class {
	#name : #GtSelectorInputFilter,
	#superclass : #BrTextEditorInputFilter,
	#instVars : [
		'filterType'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #examples }
GtSelectorInputFilter class >> binaryOrKeywordExamples [
	<gtExample>
	| filter |
	filter := self forBinaryOrKeywordMessage.
	#(#(' a b c +!/_:' 'abc_:') #('' '') #(' !+' '!+') #('abc123_' 'abc123_') #('x:y:' 'x:') #(':a:' 'a:') #('+_a' '+'))
		do: [ :each | self assert: (filter filter: each first) equals: each last ].
	^ filter
]

{ #category : #'instace creation' }
GtSelectorInputFilter class >> forBinaryOrKeywordMessage [
	^ self new
		filterType: #filterBinaryOrKeywordMessage:;
		yourself
]

{ #category : #'instace creation' }
GtSelectorInputFilter class >> forKeywordMessage [
	^ self new
		filterType: #filterKeywordMessage:;
		yourself
]

{ #category : #'instace creation' }
GtSelectorInputFilter class >> forUnaryMessage [
	^ self new
		filterType: #filterUnaryMessage:;
		yourself
]

{ #category : #examples }
GtSelectorInputFilter class >> keywordExamples [
	<gtExample>
	| filter |
	filter := self forKeywordMessage.
	#(#(' a b c +!/_:' 'abc_:') #('' '') #(' !+' '') #('abc123_' 'abc123_') #('x:y:' 'x:') #(':a:' 'a:'))
		do: [ :each | self assert: (filter filter: each first) equals: each last ].
	^ filter
]

{ #category : #examples }
GtSelectorInputFilter class >> unaryExamples [
	<gtExample>
	| filter |
	filter := self forUnaryMessage.
	#(#(' a b c +!/_' 'abc_') #('' '') #(' !+' '') #('abc123_' 'abc123_'))
		do: [ :each | self assert: (filter filter: each first) equals: each last ].
	^ filter
]

{ #category : #filtering }
GtSelectorInputFilter >> filter: aString [
	| chars |
	chars := aString trim.
	chars isEmpty ifTrue: [ ^ chars ].
	^ self perform: filterType with: chars
]

{ #category : #filtering }
GtSelectorInputFilter >> filterBinaryOrKeywordMessage: aString [
	^ aString first isSpecial
		ifTrue: [ aString select: #isSpecial ]
		ifFalse: [ self filterKeywordMessage: aString ]
]

{ #category : #filtering }
GtSelectorInputFilter >> filterKeywordMessage: aString [
	^ String
		streamContents: [ :stream | 
			aString
				detect: [ :each | 
					(each isAlphaNumeric or: [ each = $_ ]) ifTrue: [ stream nextPut: each ].
					each = $: and: [ stream position > 0 ] ]
				ifFound: [ stream nextPut: $: ] ]
]

{ #category : #accessing }
GtSelectorInputFilter >> filterType [
	^ filterType
]

{ #category : #accessing }
GtSelectorInputFilter >> filterType: aSymbol [
	filterType := aSymbol
]

{ #category : #filtering }
GtSelectorInputFilter >> filterUnaryMessage: aString [
	^ aString select: [ :each | each isAlphaNumeric or: [ each = $_ ] ]
]
