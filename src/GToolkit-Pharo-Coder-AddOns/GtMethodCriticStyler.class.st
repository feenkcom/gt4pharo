Class {
	#name : #GtMethodCriticStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'critics'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #visiting }
GtMethodCriticStyler >> acceptNode: aSmaCCParseNode [
	critics
		do: [ :each | 
			(each matches: aSmaCCParseNode)
				ifTrue: [ self highlight: aSmaCCParseNode fromCritic: each ] ].
	super acceptNode: aSmaCCParseNode
]

{ #category : #accessing }
GtMethodCriticStyler >> critics [
	^ critics
]

{ #category : #accessing }
GtMethodCriticStyler >> critics: aCollection [
	critics := aCollection
]

{ #category : #styling }
GtMethodCriticStyler >> highlight: aSmaCCParseNode fromCritic: aCritic [
	aCritic
		attributesAndLocationsFor: aSmaCCParseNode
		from: coderViewModel coderModel
		do: [ :attrs :interval | 
			self
				attributes: attrs
				from: interval first
				to: interval last ]
]

{ #category : #accessing }
GtMethodCriticStyler >> initialize [
	super initialize.
	critics := GtMethodCritic activeCritics
]
