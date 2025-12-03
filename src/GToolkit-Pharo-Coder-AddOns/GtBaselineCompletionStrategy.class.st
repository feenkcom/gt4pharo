Class {
	#name : #GtBaselineCompletionStrategy,
	#superclass : #GtStreamedCompletionStrategy,
	#category : 'GToolkit-Pharo-Coder-AddOns-Expandable baseline'
}

{ #category : #accessing }
GtBaselineCompletionStrategy >> completionActionStreamFor: aText at: positionInteger requested: aBoolean [
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
				labeled: (self labelFor: each withSearch: partialName)
				completion: (each allButFirst: partialName size)
				position: positionInteger
				from: positionInteger - partialName size + 1.
			deleteAction isNil
				ifTrue: [ insert ]
				ifFalse:
					[ (GtCompositeCompletionAction labeled: insert displayText)
						addAction: deleteAction;
						addAction: insert;
						yourself ] ]
]

{ #category : #testing }
GtBaselineCompletionStrategy >> hasCompletionsAt: anInteger in: aText [
	^ true
]

{ #category : #private }
GtBaselineCompletionStrategy >> nameStreamMatching: aString [
	^ self subclassResponsibility
]
