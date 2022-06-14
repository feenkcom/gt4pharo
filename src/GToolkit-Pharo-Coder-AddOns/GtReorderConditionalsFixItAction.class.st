Class {
	#name : #GtReorderConditionalsFixItAction,
	#superclass : #GtCriticFixItAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics-FixIt'
}

{ #category : #'api - action' }
GtReorderConditionalsFixItAction >> description [
	^ 'Rewrite "(a <1s> [b]) <1s> [c]" as "a <1s> [b <1s> [c]]"'
		expandMacrosWith: node selector
]

{ #category : #'api - action' }
GtReorderConditionalsFixItAction >> id [
	^ GtReorderConditionalsFixItActionElementId
]

{ #category : #private }
GtReorderConditionalsFixItAction >> updateSource [
	| string bracketToDelete |
	string := SmaCCString on: node topParent completeSource.
	node receiver leftParens
		do: [ :each | string deleteFrom: each startPosition to: each stopPosition ].
	node receiver rightParens
		do: [ :each | string deleteFrom: each startPosition to: each stopPosition ].
	bracketToDelete := node receiver message arguments first rightBracket.
	string
		deleteFrom: bracketToDelete startPosition
		to: bracketToDelete stopPosition.
	string insert: ']' at: node stopPosition + 1.
	^ string asString
]
