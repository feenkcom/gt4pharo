Class {
	#name : #GtMethodInlineRefactoringController,
	#superclass : #GtPharoSourceCoderRefactoringController,
	#instVars : [
		'node'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #private }
GtMethodInlineRefactoringController >> changedSourceForCurrentMethod: aRefactoryChange [
	aRefactoryChange changes
		reverseDo: [ :each | 
			((each isKindOf: RBAddMethodChange)
				and: [ each selector = sourceCoderViewModel coderModel currentSelector
						and: [ sourceCoderViewModel behavior = each changeClass ] ])
				ifTrue: [ ^ each source ] ].
	^ nil
]

{ #category : #'as yet unclassified' }
GtMethodInlineRefactoringController >> executeIn: anElement [
	[ super executeIn: anElement ]
		ensure: [ anElement enqueueTask: [ anElement requestFocus ] asBlTask ]
]

{ #category : #accessing }
GtMethodInlineRefactoringController >> node [

	^ node
]

{ #category : #accessing }
GtMethodInlineRefactoringController >> node: anObject [

	node := anObject
]

{ #category : #private }
GtMethodInlineRefactoringController >> performMethodRefactoring: aRefactoring [
	[ aRefactoring primitiveExecute ]
		on: RBRefactoringError
		do: [ :ex | 
			self inform: self refactoringName , ': ' , ex messageText.
			^ false ].
	(self changedSourceForCurrentMethod: aRefactoring model changes)
		ifNotNil: [ :source | 
			self setText: source.
			^ true ].
	^ false
]

{ #category : #executing }
GtMethodInlineRefactoringController >> safelyExecute [
	
	sourceCoderViewModel selectNone.
	self performMethodRefactoring: self refactoring
]
