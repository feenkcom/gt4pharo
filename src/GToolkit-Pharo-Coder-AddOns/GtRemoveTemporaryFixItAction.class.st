Class {
	#name : #GtRemoveTemporaryFixItAction,
	#superclass : #GtCriticFixItAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics-FixIt'
}

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
