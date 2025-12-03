Class {
	#name : #GtConvertToAssignmentFixItAction,
	#superclass : #GtMethodAdviceFixItAction,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #examples }
GtConvertToAssignmentFixItAction class >> rewriteEquals [
	<gtExample>
	^ self
		testOriginal: 'a: b c = b'
		generates: 'a: b c := b'
		forNode: [ :method | method body statements last ]
]

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
