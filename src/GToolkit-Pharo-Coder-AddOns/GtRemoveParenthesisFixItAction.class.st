Class {
	#name : #GtRemoveParenthesisFixItAction,
	#superclass : #GtMethodAdviceFixItAction,
	#instVars : [
		'description'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #examples }
GtRemoveParenthesisFixItAction class >> rewriteToDo [
	<gtExample>
	^ self
		testOriginal: 'a (1 to: 10) do: [:i | Transcript print: i; cr]'
		generates: 'a 1 to: 10 do: [:i | Transcript print: i; cr]'
		forNode: [ :method | method body statements last receiver ]
]

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
