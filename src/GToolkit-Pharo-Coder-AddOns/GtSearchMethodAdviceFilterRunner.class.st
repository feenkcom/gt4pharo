Class {
	#name : #GtSearchMethodAdviceFilterRunner,
	#superclass : #Object,
	#traits : 'TMethodAdviceRunner',
	#classTraits : 'TMethodAdviceRunner classTrait',
	#instVars : [
		'currentMethod',
		'found',
		'advice'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #running }
GtSearchMethodAdviceFilterRunner class >> does: advice includeMethod: aMethod [
	^ self new
		advice: advice;
		includesMethod: aMethod
]

{ #category : #accessing }
GtSearchMethodAdviceFilterRunner >> advice [
	^ advice
]

{ #category : #accessing }
GtSearchMethodAdviceFilterRunner >> advice: anObject [
	advice := anObject
]

{ #category : #accessing }
GtSearchMethodAdviceFilterRunner >> behavior [
	^ currentMethod
		ifNil: [ nil class ]
		ifNotNil: [ currentMethod methodClass ]
]

{ #category : #accessing }
GtSearchMethodAdviceFilterRunner >> foundIssue: aCritic in: aNode [
	found := true
]

{ #category : #testing }
GtSearchMethodAdviceFilterRunner >> includesMethod: aCompiledMethod [
	| source |
	currentMethod := aCompiledMethod.
	source := aCompiledMethod sourceCode.
	found := false.
	self processNode: (GtPharoParser parseWithErrors: source).
	currentMethod := nil.
	^ found
]

{ #category : #private }
GtSearchMethodAdviceFilterRunner >> processNode: aNode [
	(advice matches: aNode from: self) ifTrue: [ found := true ].
	aNode nodesDo: [ :node | self processNode: node ].
	advice finish: aNode from: self
]
