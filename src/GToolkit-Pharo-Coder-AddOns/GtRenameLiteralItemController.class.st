Class {
	#name : #GtRenameLiteralItemController,
	#superclass : #GtRenameVariableController,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtRenameLiteralItemController >> allRenameIntervals [
	| intervals |
	intervals := OrderedCollection new.
	intervals add: (self intervalForNode: self originalNode).
	self originalNode topParent
		withAllNodesDo: [ :each | 
			(each ~~ self originalNode
				and: [ each isLiteral and: [ each literalValue = self originalNode literalValue ] ])
				ifTrue: [ intervals add: (self intervalForNode: each) ] ].
	^ intervals
]

{ #category : #accessing }
GtRenameLiteralItemController >> intervalForNode: aNode [
	| source hasQuotes |
	source := aNode source.
	hasQuotes := source last = $'.
	^ aNode startPosition
		+ (hasQuotes ifTrue: [ source indexOf: $' ] ifFalse: [ 1 ])
		to: aNode stopPosition - (hasQuotes ifTrue: [ 1 ] ifFalse: [ 0 ])
]

{ #category : #accessing }
GtRenameLiteralItemController >> originalName [
	^ self originalNode literalValue
]

{ #category : #accessing }
GtRenameLiteralItemController >> originalSourcePosition [
	^ self intervalForNode: self originalNode
]

{ #category : #accessing }
GtRenameLiteralItemController >> renamePosition [
	^ super renamePosition
		+ (self originalNode source last = $' ifTrue: [ 1 ] ifFalse: [ 0 ])
]
