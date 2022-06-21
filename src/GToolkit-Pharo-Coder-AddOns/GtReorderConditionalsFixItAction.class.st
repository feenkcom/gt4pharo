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
	| string bracketToDelete expr |
	string := SmaCCString on: node topParent completeSource.
	expr := node receiver message arguments first body statements last.
	expr needsParenthesisForKeyword
		ifTrue: [ string insert: '(' at: expr startPosition.
			string insert: ')' at: expr stopPosition + 1 ].
	node receiver leftParens
		do: [ :each | string deleteFrom: each startPosition to: each stopPosition ].
	node receiver rightParens
		do: [ :each | string deleteFrom: each startPosition to: each stopPosition ].
	bracketToDelete := node receiver message arguments first rightBracket.
	string
		deleteFrom: bracketToDelete startPosition
		to: bracketToDelete stopPosition.
	string insert: ' ]' at: node arguments last stopPosition + 1.
	^ string asString
]
