Class {
	#name : 'GtMethodRefactoringController',
	#superclass : 'GtPharoSourceCoderRefactoringController',
	#instVars : [
		'node'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : 'private' }
GtMethodRefactoringController >> changedSourceForCurrentMethod: aRefactoryChange [
	aRefactoryChange changes
		reverseDo: [ :each | 
			((each isKindOf: RBAddMethodChange)
				and: [ each selector = sourceCoderViewModel coderModel currentSelector
						and: [ sourceCoderViewModel behavior = each changeClass ] ])
				ifTrue: [ ^ each source ] ].
	^ nil
]

{ #category : 'accessing' }
GtMethodRefactoringController >> node [

	^ node
]

{ #category : 'accessing' }
GtMethodRefactoringController >> node: anObject [

	node := anObject
]

{ #category : 'private' }
GtMethodRefactoringController >> performMethodRefactoring: aRefactoring [
	[ aRefactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :ex | ^ false ].
	(self changedSourceForCurrentMethod: aRefactoring model changes)
		ifNotNil: [ :source | 
			self setText: source.
			^ true ].
	^ false
]

{ #category : 'executing' }
GtMethodRefactoringController >> safelyExecute [
	
	sourceCoderViewModel selectNone.
	self performMethodRefactoring: self refactoring
]
