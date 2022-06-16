Class {
	#name : #GtMethodCriticRunner,
	#superclass : #Object,
	#traits : 'TCriticRunner',
	#classTraits : 'TCriticRunner classTrait',
	#instVars : [
		'critic',
		'currentMethod'
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
GtMethodCriticRunner >> issues [
	| methods |
	methods := IdentitySet new.
	critic
		potentialMethodsDo: [ :each | 
			| ast |
			currentMethod := each.
			ast := GtPharoParser parseWithErrors: each sourceCode.
			ast
				withAllNodesDo: [ :node | (critic matches: node from: self) ifTrue: [ methods add: each ] ].
			currentMethod := nil ].
	^ methods
]

{ #category : #typing }
GtMethodCriticRunner >> typeOf: aGtPharoProgramNode [
	^ GtPharoProgramNode
		typeOf: aGtPharoProgramNode
		in: self behavior
		bindings: nil
]
