Class {
	#name : #GtRGMethodDefinitionWithComparisonGroup,
	#superclass : #GtBasicGroup,
	#instVars : [
		'highlighter'
	],
	#category : #'GToolkit-Pharo-Metamodels'
}

{ #category : #accessing }
GtRGMethodDefinitionWithComparisonGroup >> highlighter [
	^ highlighter
]

{ #category : #accessing }
GtRGMethodDefinitionWithComparisonGroup >> highlighter: aHighlighter [
	highlighter := aHighlighter
]

{ #category : #accessing }
GtRGMethodDefinitionWithComparisonGroup >> lastMethod [
	^self last
]

{ #category : #accessing }
GtRGMethodDefinitionWithComparisonGroup >> penultimateMethod [
	^items at: items size - 1
]

{ #category : #printing }
GtRGMethodDefinitionWithComparisonGroup >> printOn: aStream [
	items ifNil: [ ^ super printOn: aStream ].
	
	aStream 
		<< '[';
		print: self size;
		<< ' ';
		<< (self size = 1 
			ifTrue: [ 'method' ]
			ifFalse: [ 'methods' ]);
		<< ']'
]
