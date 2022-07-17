Class {
	#name : #GtSearchMethodAdviceFilter,
	#superclass : #GtSearchMethodsFilter,
	#traits : 'TMethodAdviceRunner',
	#classTraits : 'TMethodAdviceRunner classTrait',
	#instVars : [
		'critic',
		'currentMethod',
		'found'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtSearchMethodAdviceFilter >> behavior [
	^ currentMethod
		ifNil: [ nil class ]
		ifNotNil: [ currentMethod methodClass ]
]

{ #category : #accessing }
GtSearchMethodAdviceFilter >> critic: aMethodCritic [
	critic := aMethodCritic
]

{ #category : #accessing }
GtSearchMethodAdviceFilter >> defaultFilterScope [
	^ critic potentialFilter ifNil: [ super defaultFilterScope ]
]

{ #category : #accessing }
GtSearchMethodAdviceFilter >> foundIssue: aCritic in: aNode [
	found := true
]

{ #category : #testing }
GtSearchMethodAdviceFilter >> includesMethod: aCompiledMethod [
	| source |
	currentMethod := aCompiledMethod.
	source := aCompiledMethod sourceCode.
	found := false.
	self processNode: (GtPharoParser parseWithErrors: source).
	currentMethod := nil.
	^ found
]

{ #category : #accessing }
GtSearchMethodAdviceFilter >> processNode: aNode [
	(critic matches: aNode from: self) ifTrue: [ found := true ].
	aNode nodesDo: [ :node | self processNode: node ].
	critic finish: aNode from: self
]
