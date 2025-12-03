"
I highlight non-breakable spaces. 
I am particularly useful if a non-breakable space is inserted into a source code which prevents the code from being accepted. 
#Example
The following code includes a string with non-breakable character: {{gtExample:GtPharoNonBreakableSpaceStylerExamples>>#nbspSourceCode}}

"
Class {
	#name : #GtPharoNonBreakableSpaceStyler,
	#superclass : #GtCoderAstStyler,
	#category : 'GToolkit-Pharo-Coder-AddOns-NonBreakable Space'
}

{ #category : #comparing }
GtPharoNonBreakableSpaceStyler >> = anObject [
	^ self class = anObject class
]

{ #category : #comparing }
GtPharoNonBreakableSpaceStyler >> hash [
	^ self class hash
]

{ #category : #accessing }
GtPharoNonBreakableSpaceStyler >> style: aText ast: anAst [
	<return: #BlText>
	| allIndexes |
	allIndexes := aText finder
		              character: Character nbsp;
		              searchAll.

	allIndexes do: [ :eachIndex | 
		(aText from: eachIndex to: eachIndex) underlineColor:
			BrGlamorousColors linkWithErrorColor ].
			
	^ aText
]
