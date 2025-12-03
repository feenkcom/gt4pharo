Class {
	#name : #GtPharoCommentsReferenceHighlighter,
	#superclass : #GtPharoCodeHighlighter,
	#instVars : [
		'commentsFilter'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Highlighter'
}

{ #category : #accessing }
GtPharoCommentsReferenceHighlighter >> commentsFilter: aGtSearchCommentsFilter [
	commentsFilter := aGtSearchCommentsFilter
]

{ #category : #accessing }
GtPharoCommentsReferenceHighlighter >> visitMethod: aNode [
	commentsFilter
		matchingIntervalsInAst: aNode
		do: [ :eachInterval | stream nextPut: eachInterval ]
]
