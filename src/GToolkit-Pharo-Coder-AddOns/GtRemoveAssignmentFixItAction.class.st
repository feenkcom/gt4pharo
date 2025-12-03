Class {
	#name : #GtRemoveAssignmentFixItAction,
	#superclass : #GtMethodAdviceFixItAction,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #examples }
GtRemoveAssignmentFixItAction class >> removeAssignment [
	<gtExample>
	^ self
		testOriginal: 'a |b| ^b:=self printString'
		generates: 'a |b| ^self printString'
		forNode: [ :method | method body statements last value ]
]

{ #category : #'api - action' }
GtRemoveAssignmentFixItAction >> description [
	^ 'Remove assignment of ' , node variable variableName
]

{ #category : #'api - action' }
GtRemoveAssignmentFixItAction >> id [
	^ GtRemoveAssignmentFixItActionElementId
]

{ #category : #executing }
GtRemoveAssignmentFixItAction >> updateSource [
	| string |
	string := SmaCCString on: node topParent completeSource.
	string
		deleteFrom: node variable startPosition
		to: node assignmentToken stopPosition.
	^ string asString
]
