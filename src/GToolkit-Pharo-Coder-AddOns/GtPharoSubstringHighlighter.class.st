Class {
	#name : #GtPharoSubstringHighlighter,
	#superclass : #GtPharoCodeHighlighter,
	#instVars : [
		'substring'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Highlighter'
}

{ #category : #'instance creation' }
GtPharoSubstringHighlighter class >> substring: aString [
	^ self new substring: aString
]

{ #category : #visiting }
GtPharoSubstringHighlighter >> searchSourceIn: aNode [
	| source index |
	source := aNode completeSource asString.

	index := 1.
	[ (index := source
			findString: self substring
			startingAt: index
			caseSensitive: false) > 0 ]
		whileTrue: [ stream nextPut: (index to: index + self substring size - 1).
			index := index + self substring size ]
]

{ #category : #accessing }
GtPharoSubstringHighlighter >> substring [
	^ substring
]

{ #category : #accessing }
GtPharoSubstringHighlighter >> substring: aString [
	substring := aString
]

{ #category : #visiting }
GtPharoSubstringHighlighter >> visitMethod: aMethodNode [
	self searchSourceIn: aMethodNode
]

{ #category : #accessing }
GtPharoSubstringHighlighter >> visitSequence: aSequence [
	^ aSequence parent
		ifNil: [ self searchSourceIn: aSequence ]
		ifNotNil: [ super visitSequence: aSequence ]
]
