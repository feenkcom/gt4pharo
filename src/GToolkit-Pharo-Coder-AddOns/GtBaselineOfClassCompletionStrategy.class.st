Class {
	#name : #GtBaselineOfClassCompletionStrategy,
	#superclass : #GtBaselineCompletionStrategy,
	#category : 'GToolkit-Pharo-Coder-AddOns-Expandable baseline'
}

{ #category : #private }
GtBaselineOfClassCompletionStrategy >> nameStreamMatching: aString [
	| name |
	name := 'BaselineOf' , aString.
	^ ((AsyncDepthFirstTraversalStream root: BaselineOf children: #subclasses) select: [ :each | each name beginsWith: name ])
		collect: [ :each | each name allButFirst: 10 ]
]
