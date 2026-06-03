Class {
	#name : #GtMethodAdviceConsideringSignal,
	#superclass : #GtMethodAdviceSignal,
	#instVars : [
		'isStyled',
		'node',
		'text'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices-Signals'
}

{ #category : #initialization }
GtMethodAdviceConsideringSignal >> initialize [
	super initialize.
	isStyled := false
]

{ #category : #accessing }
GtMethodAdviceConsideringSignal >> isStyled [
	^ isStyled ifNil: [ false ]
]

{ #category : #accessing }
GtMethodAdviceConsideringSignal >> isStyled: anObject [
	isStyled := anObject
]

{ #category : #accessing }
GtMethodAdviceConsideringSignal >> node [
	^ node
]

{ #category : #accessing }
GtMethodAdviceConsideringSignal >> node: anObject [
	node := anObject
]

{ #category : #'as yet unclassified' }
GtMethodAdviceConsideringSignal >> nodeIsMatching [
	| aStyler |
	advice ifNil: [ ^ false ].
	styler ifNil: [ ^ false ].
	node ifNil: [ ^ false ].
	text ifNil: [ ^ false ].
	
	aStyler := styler copy.
	aStyler instVarNamed: #text put: text.

	^ advice matches: node from: aStyler
]

{ #category : #printing }
GtMethodAdviceConsideringSignal >> printOneLineContentsOn: aStream [
	self isStyled
		ifTrue: [ aStream nextPutAll: '+ ' ]
		ifFalse: [ aStream nextPutAll: '- ' ].
	aStream print: (self advice ifNotNil: #class).
	aStream nextPut: $:; space.
	aStream print: node
]

{ #category : #accessing }
GtMethodAdviceConsideringSignal >> text [
	^ text
]

{ #category : #accessing }
GtMethodAdviceConsideringSignal >> text: anObject [
	text := anObject
]
