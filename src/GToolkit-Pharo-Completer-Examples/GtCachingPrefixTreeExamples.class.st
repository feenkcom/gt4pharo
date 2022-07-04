Class {
	#name : #GtCachingPrefixTreeExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Completer-Examples'
}

{ #category : #implementers }
GtCachingPrefixTreeExamples >> implementersExample [
	<gtExample>
	| tree |
	tree := GtCachingPrefixTree new.
	(tree add: 'asdf' weight: 1) addImplementer: thisContext method.
	(tree add: 'bb' weight: 1) addImplementer: thisContext method.
	self assert: (tree implementersOf: 'asd') isEmpty.
	self assert: (tree implementersOf: 'asdf') asArray = {thisContext method}.
	self assert: (tree implementersOf: 'asdfg') isEmpty.
	^ tree
]

{ #category : #references }
GtCachingPrefixTreeExamples >> referencesExample [
	<gtExample>
	| tree |
	tree := GtCachingPrefixTree new.
	(tree add: 'asdf' weight: 1) addReference: thisContext method.
	(tree add: 'bb' weight: 1) addReference: thisContext method.
	self assert: (tree referencesTo: 'asd') isEmpty.
	self assert: (tree referencesTo: 'asdf') asArray = {thisContext method}.
	self assert: (tree referencesTo: 'asdfg') isEmpty.
	^ tree
]
