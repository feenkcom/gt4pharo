"
I am an abstract {{gtClass:GtPharoRenameVariableCoderController}} that renames the text of a string or symbol literal, e.g., a baseline or a package name in a baseline method. I do not rename the quotes or the hash of a symbol, see {{gtMethod:GtPharoRenameLiteralCoderController>>#intervalForNode:}}. All literals with the same value in the method are renamed together. My subclasses are {{gtClass:GtPharoRenameBaselineCoderController}} and {{gtClass:GtPharoRenamePackageCoderController}}. I replace {{gtClass:GtRenameLiteralItemController}}.
"
Class {
	#name : #GtPharoRenameLiteralCoderController,
	#superclass : #GtPharoRenameVariableCoderController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #testing }
GtPharoRenameLiteralCoderController class >> isAbstract [
	^ self name = #GtPharoRenameLiteralCoderController
]

{ #category : #accessing }
GtPharoRenameLiteralCoderController >> intervalForNode: aNode [
	"Interval of the text of a literal without quotes and without the hash of a symbol, similar to {{gtMethod:GtRenameLiteralItemController>>#intervalForNode:}}."

	| aSource aStart aStop |
	aSource := aNode source.
	aStart := aNode startPosition.
	aStop := aNode stopPosition.
	aSource first = $# ifTrue: [ aStart := aStart + 1. aSource := aSource allButFirst ].
	(aSource notEmpty and: [ aSource first = $' ])
		ifTrue: [ aStart := aStart + 1. aStop := aStop - 1 ].
	^ aStart to: aStop
]

{ #category : #accessing }
GtPharoRenameLiteralCoderController >> originalName [
	^ originalNode literalValue asString
]

{ #category : #accessing }
GtPharoRenameLiteralCoderController >> otherRenameIntervals [
	"Intervals of all other literals with the same value."

	| someIntervals |
	someIntervals := OrderedCollection new.
	originalNode topParent
		withAllNodesDo: [ :each | 
			(each ~~ originalNode
				and: [ each isErrorNode not
						and: [ each isLiteral and: [ each literalValue = originalNode literalValue ] ] ])
				ifTrue: [ someIntervals add: (self intervalForNode: each) ] ].
	^ someIntervals
]

{ #category : #accessing }
GtPharoRenameLiteralCoderController >> primaryRenameInterval [
	^ self intervalForNode: originalNode
]
