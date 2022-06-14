Class {
	#name : #GtRemoveParenthesisFixItAction,
	#superclass : #GtCriticFixItAction,
	#instVars : [
		'description'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics-FixIt'
}

{ #category : #'api - action' }
GtRemoveParenthesisFixItAction >> description [
	^ description ifNil: [ 'Remove unnecessary parenthesis' ]
]

{ #category : #accessing }
GtRemoveParenthesisFixItAction >> description: aString [
	description := aString
]

{ #category : #'api - action' }
GtRemoveParenthesisFixItAction >> id [
	^ GtRemoveParenthesisFixItActionElementId
]

{ #category : #executing }
GtRemoveParenthesisFixItAction >> updateSource [
	| string |
	string := SmaCCString on: node topParent completeSource.
	node leftParens
		do: [ :each | string deleteFrom: each startPosition to: each stopPosition ].
	node rightParens
		do: [ :each | string deleteFrom: each startPosition to: each stopPosition ].
	^ string asString
]
