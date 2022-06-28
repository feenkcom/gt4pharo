Class {
	#name : #GtSearchMethodCriticFilter,
	#superclass : #GtSearchMethodsFilter,
	#traits : 'TCriticRunner',
	#classTraits : 'TCriticRunner classTrait',
	#instVars : [
		'critic',
		'currentMethod',
		'found'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtSearchMethodCriticFilter >> behavior [
	^ currentMethod
		ifNil: [ nil class ]
		ifNotNil: [ currentMethod methodClass ]
]

{ #category : #accessing }
GtSearchMethodCriticFilter >> critic: aMethodCritic [
	critic := aMethodCritic
]

{ #category : #accessing }
GtSearchMethodCriticFilter >> defaultFilterScope [
	^ critic potentialFilter ifNil: [ super defaultFilterScope ]
]

{ #category : #accessing }
GtSearchMethodCriticFilter >> foundIssue: aCritic in: aNode [
	found := true
]

{ #category : #testing }
GtSearchMethodCriticFilter >> includesMethod: aCompiledMethod [
	| source |
	currentMethod := aCompiledMethod.
	source := aCompiledMethod sourceCode.
	found := false.
	self processNode: (GtPharoParser parseWithErrors: source).
	currentMethod := nil.
	^ found
]

{ #category : #accessing }
GtSearchMethodCriticFilter >> processNode: aNode [
	(critic matches: aNode from: self) ifTrue: [ found := true ].
	aNode nodesDo: [ :node | self processNode: node ].
	critic finish: aNode from: self
]
