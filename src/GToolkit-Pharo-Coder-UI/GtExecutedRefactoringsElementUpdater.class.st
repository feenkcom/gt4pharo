Class {
	#name : #GtExecutedRefactoringsElementUpdater,
	#superclass : #Object,
	#traits : 'TGtExecutedRefactoringsStateVisitor',
	#classTraits : 'TGtExecutedRefactoringsStateVisitor classTrait',
	#instVars : [
		'element',
		'refactoringsViewModel',
		'executedRefactorings'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #accessing }
GtExecutedRefactoringsElementUpdater >> element [
	^ element
]

{ #category : #accessing }
GtExecutedRefactoringsElementUpdater >> element: anObject [
	element := anObject
]

{ #category : #accessing }
GtExecutedRefactoringsElementUpdater >> executedRefactorings [
	^ executedRefactorings
]

{ #category : #accessing }
GtExecutedRefactoringsElementUpdater >> executedRefactorings: anObject [
	executedRefactorings := anObject
]

{ #category : #'api - initialization' }
GtExecutedRefactoringsElementUpdater >> forRefactoringsElement: anElement [
	self element: anElement.
	self refactoringsViewModel: anElement refactoringsViewModel.
	self executedRefactorings: anElement refactoringsViewModel executedRefactorings
]

{ #category : #testing }
GtExecutedRefactoringsElementUpdater >> ifRefactoringsElementOutOfSyncDo: aBlock [
	refactoringsViewModel executedRefactorings == executedRefactorings
		ifFalse: [ ^ aBlock value ].
	element refactoringsViewModel == refactoringsViewModel
		ifFalse: [ ^ aBlock value ]
]

{ #category : #accessing }
GtExecutedRefactoringsElementUpdater >> refactoringsViewModel [
	^ refactoringsViewModel
]

{ #category : #accessing }
GtExecutedRefactoringsElementUpdater >> refactoringsViewModel: anObject [
	refactoringsViewModel := anObject
]

{ #category : #'api - updating' }
GtExecutedRefactoringsElementUpdater >> update [
	self visitState: executedRefactorings state
]

{ #category : #private }
GtExecutedRefactoringsElementUpdater >> updateToDisplayPreview [
]
