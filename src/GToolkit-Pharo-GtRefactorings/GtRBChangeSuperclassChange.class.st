Class {
	#name : #GtRBChangeSuperclassChange,
	#superclass : #RBRefactoryClassChange,
	#instVars : [
		'newSuperclassName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #'instance creation' }
GtRBChangeSuperclassChange class >> change: aClassName toBeUnder: superclassName [
	^ self new
		changeClassName: aClassName;
		newSuperclassName: superclassName;
		yourself
]

{ #category : #comparing }
GtRBChangeSuperclassChange >> = aRefactoryClassChange [
	^ super = aRefactoryClassChange
		and: [ self newSuperclassName = aRefactoryClassChange newSuperclassName ]
]

{ #category : #converting }
GtRBChangeSuperclassChange >> asUndoOperation [
	| class |
	class := onSystemEnvironment classNamed: self changeClassName.
	^ self copy
		newSuperclassName: (class superclass ifNil: [ nil ] ifNotNil: [ :superClass | superClass name ])
]

{ #category : #private }
GtRBChangeSuperclassChange >> generateChanges [
	| class superclass |
	class := onSystemEnvironment classNamed: self changeClassName.
	superclass := newSuperclassName
			ifNil: [ nil ]
			ifNotNil: [ onSystemEnvironment classNamed: newSuperclassName ].
	class superclass: superclass
]

{ #category : #comparing }
GtRBChangeSuperclassChange >> hash [
	^ self newSuperclassName hash hashMultiply bitXor: super hash
]

{ #category : #accessing }
GtRBChangeSuperclassChange >> newSuperclassName [
	^ newSuperclassName
]

{ #category : #accessing }
GtRBChangeSuperclassChange >> newSuperclassName: anObject [
	newSuperclassName := anObject
]
