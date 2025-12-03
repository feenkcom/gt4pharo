Class {
	#name : #GtPhlowSameViewReturnMethodFixItAction,
	#superclass : #GtMethodAdviceFixItAction,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #examples }
GtPhlowSameViewReturnMethodFixItAction class >> addEmptyViewReturn [
	<gtExample>
	^ self
		testOriginal: 'a: aView ^ aView'
		generates: 'a: aView ^ aView empty'
		forNode: [ :method | method body statements last value ]
]

{ #category : #'api - action' }
GtPhlowSameViewReturnMethodFixItAction >> description [
	^ 'Add empty view creation'
]

{ #category : #'api - action' }
GtPhlowSameViewReturnMethodFixItAction >> id [
	^ GtPhlowSameViewReturnMethodFixItActionElementId
]

{ #category : #executing }
GtPhlowSameViewReturnMethodFixItAction >> updateSource [
	| string |
	string := SmaCCString on: node topParent completeSource.
	string insert: ' empty' at: node stopPosition + 1.
	^ string asString
]
