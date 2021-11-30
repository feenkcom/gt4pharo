Class {
	#name : #GtBaselineCompletionStrategy,
	#superclass : #GtCompletionStrategy,
	#category : #'GToolkit-Pharo-Coder-AddOns-Expandable baseline'
}

{ #category : #accessing }
GtBaselineCompletionStrategy >> completionActionStreamFor: aText at: positionInteger [
	| string first partialName names last ch deleteAction |
	string := aText asString.
	first := positionInteger.
	[ first > 0 and: [ (string at: first) ~= $' ] ] whileTrue: [ first := first - 1 ].
	first = 0 ifTrue: [ ^ #() ].
	partialName := string copyFrom: first + 1 to: positionInteger.
	names := self nameStreamMatching: partialName.
	last := positionInteger.
	[ last <= string size and: [ (ch := string at: last) isSeparator not and: [ ch ~= $' ] ] ] whileTrue: [ last := last + 1 ].
	last - 1 > positionInteger
		ifTrue:
			[ deleteAction := GtDeleteTextCompletionAction
				labeled: ''
				from: positionInteger + 1
				to: last - 1 ].
	^ names
		collect:
			[ :each | 
			| insert |
			insert := GtInsertTextCompletionAction
				labeled: each
				completion: (each allButFirst: partialName size)
				position: positionInteger
				from: positionInteger - partialName size + 1.
			deleteAction isNil
				ifTrue: [ insert ]
				ifFalse:
					[ (GtCompositeCompletionAction labeled: insert label)
						addAction: deleteAction;
						addAction: insert;
						yourself ] ]
]

{ #category : #accessing }
GtBaselineCompletionStrategy >> completionActionsFor: aText at: positionInteger max: maxInteger [
	^ ((self completionActionStreamFor: aText at: positionInteger) take: maxInteger) toArray wait
]

{ #category : #testing }
GtBaselineCompletionStrategy >> hasCompletionsAt: anInteger in: aText [
	^ true
]

{ #category : #private }
GtBaselineCompletionStrategy >> nameStreamMatching: aString [
	^ self subclassResponsibility
]
