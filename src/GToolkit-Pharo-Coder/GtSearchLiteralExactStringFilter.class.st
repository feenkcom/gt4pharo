Class {
	#name : #GtSearchLiteralExactStringFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'string',
		'caseSensitive',
		'lowercase'
	],
	#category : #'GToolkit-Pharo-Coder-Filters'
}

{ #category : #accessing }
GtSearchLiteralExactStringFilter class >> string: aString caseSensitive: aBoolean [

	^ self new
		  string: aString;
		  caseSensitive: aBoolean
]

{ #category : #comparing }
GtSearchLiteralExactStringFilter >> = anObject [

	^ self class = anObject class and: [ self string = anObject string ]
]

{ #category : #accessing }
GtSearchLiteralExactStringFilter >> caseSensitive [

	^ caseSensitive ifNil: [ true ]
]

{ #category : #accessing }
GtSearchLiteralExactStringFilter >> caseSensitive: aBoolean [

	caseSensitive := aBoolean
]

{ #category : #printing }
GtSearchLiteralExactStringFilter >> gtDisplayOn: stream [
	stream
		print: self string;
		nextPutAll: ' stringLiteralMatch'
]

{ #category : #comparing }
GtSearchLiteralExactStringFilter >> hash [

	^ self class hash bitXor: self string hash
]

{ #category : #testing }
GtSearchLiteralExactStringFilter >> includesMethod: aCompiledMethod [

	^ aCompiledMethod hasLiteralSuchThat: [ :aLiteral | 
		  aLiteral isString and: [ 
			  aLiteral isSymbol not and: [ 
				  aLiteral = self string or: [ 
					  self caseSensitive not and: [ 
						  aLiteral asLowercase = self lowercase ] ] ] ] ]
]

{ #category : #accessing }
GtSearchLiteralExactStringFilter >> initialize [

	super initialize.

	caseSensitive := true
]

{ #category : #testing }
GtSearchLiteralExactStringFilter >> lowercase [

	^ lowercase
]

{ #category : #accessing }
GtSearchLiteralExactStringFilter >> string [

	^ string
]

{ #category : #accessing }
GtSearchLiteralExactStringFilter >> string: aString [

	string := aString.
	lowercase := aString asLowercase
]
