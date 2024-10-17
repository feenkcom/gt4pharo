Class {
	#name : #GtSearchScopedMethodsScope,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-SearchFilters-Support'
}

{ #category : #'gt - extensions' }
GtSearchScopedMethodsScope class >> gtScopesFor: aView [
	<gtClassView>
	^ aView columnedList
		title: 'Scopes';
		items: [ self allSubclasses sort: [ :a :b | a order < b order ] ];
		column: 'Order' text: [ :each | each order ] width: 50;
		column: 'Icon' icon: [ :each | each new icon ];
		column: 'Label' text: [ :each | each new label ];
		column: 'Class' text: #yourself;
		sendTool: [ :each | GtClassCoderTool forClass: each ];
		actionUpdateButton
]

{ #category : #factory }
GtSearchScopedMethodsScope class >> itemInstancesForFilterContext: aFilterContext into: aStream [
	self subclassResponsibility
]

{ #category : #accessing }
GtSearchScopedMethodsScope class >> order [
	^ 1000
]

{ #category : #comparing }
GtSearchScopedMethodsScope >> = anObject [
	self == anObject ifTrue: [ ^ true ].

	^ self class = anObject class and: [ self itemValue = anObject itemValue ]
]

{ #category : #printing }
GtSearchScopedMethodsScope >> gtDisplayOn: aStream [
	aStream nextPutAll: self label
]

{ #category : #accessing }
GtSearchScopedMethodsScope >> gtIconName [
	^ self itemValue gtSystemIconName
]

{ #category : #comparing }
GtSearchScopedMethodsScope >> hash [
	^ self class hash bitXor: self itemValue hash
]

{ #category : #testing }
GtSearchScopedMethodsScope >> includesMethod: aCompiledMethod [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtSearchScopedMethodsScope >> itemValue [
	^ nil
]

{ #category : #accessing }
GtSearchScopedMethodsScope >> label [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtSearchScopedMethodsScope >> order [
	^ self class order
]
