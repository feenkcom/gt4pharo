Class {
	#name : #GtRemoveTemporaryFixItAction,
	#superclass : #GtMethodAdviceFixItAction,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #examples }
GtRemoveTemporaryFixItAction class >> removeTemp [
	<gtExample>
	^ self
		testOriginal: 'a | a | Transcript print: 1'
		generates: 'a  Transcript print: 1'
		forNode: [ :method | method body variables first ]
]

{ #category : #examples }
GtRemoveTemporaryFixItAction class >> removeTempInTemps [
	<gtExample>
	^ self
		testOriginal: 'a | a b c | Transcript print: 1'
		generates: 'a | a c | Transcript print: 1'
		forNode: [ :method | method body variables second ]
]

{ #category : #accessing }
GtRemoveTemporaryFixItAction >> description [
	^ 'Remove temporary ' , node variableName
]

{ #category : #accessing }
GtRemoveTemporaryFixItAction >> id [
	^ GtRemoveTemporaryFixItActionElementId
]

{ #category : #accessing }
GtRemoveTemporaryFixItAction >> updateSource [
	| string |
	string := SmaCCString on: node topParent completeSource.
	node parent variables size = 1
		ifTrue: [ string
				deleteFrom: node parent leftBar startPosition
				to: node parent rightBar stopPosition ]
		ifFalse: [ string
				deleteFrom: node startPosition - (string whitespaceBeforeIndex: node startPosition) size
				to: node stopPosition ].
	^ string asString
]
