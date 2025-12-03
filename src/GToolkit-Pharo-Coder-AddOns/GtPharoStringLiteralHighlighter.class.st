Class {
	#name : #GtPharoStringLiteralHighlighter,
	#superclass : #GtPharoCodeHighlighter,
	#instVars : [
		'string',
		'caseSensitive',
		'lowercase'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Highlighter'
}

{ #category : #accessing }
GtPharoStringLiteralHighlighter class >> string: aString caseSensitive: aBoolean [

	^ self new
		  string: aString;
		  caseSensitive: aBoolean
]

{ #category : #accessing }
GtPharoStringLiteralHighlighter >> caseSensitive [

	^ caseSensitive
]

{ #category : #accessing }
GtPharoStringLiteralHighlighter >> caseSensitive: aBoolean [

	caseSensitive := aBoolean
]

{ #category : #accessing }
GtPharoStringLiteralHighlighter >> initialize [

	super initialize.

	caseSensitive := true
]

{ #category : #accessing }
GtPharoStringLiteralHighlighter >> lowercase [

	^ lowercase
]

{ #category : #accessing }
GtPharoStringLiteralHighlighter >> string [

	^ string
]

{ #category : #accessing }
GtPharoStringLiteralHighlighter >> string: aString [

	string := aString.
	lowercase := aString asLowercase
]

{ #category : #accessing }
GtPharoStringLiteralHighlighter >> visitStringLiteral: aNode [

	(aNode string = self string or: [ 
		 self caseSensitive not and: [ 
			 aNode string asLowercase = self lowercase ] ]) ifFalse: [ ^ self ].
			 
	stream nextPut: (aNode startPosition to: aNode stopPosition)
]
