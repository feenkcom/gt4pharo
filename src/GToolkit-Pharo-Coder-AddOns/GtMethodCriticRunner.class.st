Class {
	#name : #GtMethodCriticRunner,
	#superclass : #Object,
	#traits : 'TCriticRunner',
	#classTraits : 'TCriticRunner classTrait',
	#instVars : [
		'critic',
		'currentMethod',
		'methods'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtMethodCriticRunner >> behavior [
	^ currentMethod
		ifNil: [ nil class ]
		ifNotNil: [ currentMethod methodClass ]
]

{ #category : #accessing }
GtMethodCriticRunner >> critic: aMethodCritic [
	critic := aMethodCritic
]

{ #category : #accessing }
GtMethodCriticRunner >> foundIssue: aCritic in: aNode [
	methods add: currentMethod
]

{ #category : #accessing }
GtMethodCriticRunner >> issues [
	methods ifNotNil: [ ^ methods ].
	methods := IdentitySet new.
	critic
		potentialMethodsDo: [ :each | 
			| ast |
			currentMethod := each.
			ast := GtPharoParser parseWithErrors: each sourceCode.
			self processNode: ast.
			currentMethod := nil ].
	^ methods
]

{ #category : #accessing }
GtMethodCriticRunner >> processNode: aNode [
	(critic matches: aNode from: self) ifTrue: [ methods add: currentMethod ].
	aNode nodesDo: [ :node | self processNode: node ].
	critic finish: aNode from: self
]

{ #category : #typing }
GtMethodCriticRunner >> typeOf: aGtPharoProgramNode [
	^ GtPharoProgramNode
		typeOf: aGtPharoProgramNode
		in: self behavior
		bindings: nil
]
