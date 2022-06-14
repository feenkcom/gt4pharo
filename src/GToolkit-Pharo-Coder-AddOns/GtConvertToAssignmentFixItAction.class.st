Class {
	#name : #GtConvertToAssignmentFixItAction,
	#superclass : #GtCriticFixItAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics-FixIt'
}

{ #category : #'api - action' }
GtConvertToAssignmentFixItAction >> description [
	^ 'Convert #= message to assignment'
]

{ #category : #'api - action' }
GtConvertToAssignmentFixItAction >> id [
	^ GtConvertToAssignmentFixItActionElementId
]

{ #category : #executing }
GtConvertToAssignmentFixItAction >> updateSource [
	| string |
	string := SmaCCString on: node topParent completeSource.
	string insert: ':' at: node selectorParts first startPosition.
	^ string asString
]
