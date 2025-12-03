Class {
	#name : #GtRefactoringAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'refactoringController',
		'focusOnFirstShow'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #accessing }
GtRefactoringAttribute >> cancel [
	refactoringController cancelRefactoring
]

{ #category : #accessing }
GtRefactoringAttribute >> focusNext: aBoolean in: anEditorElement from: currentEditor [
	| first last previous |
	anEditorElement
		allChildrenBreadthFirstDo: [ :each | 
			(each userData at: #isRefactoringEditor ifAbsent: [ false ])
				ifTrue: [ first ifNil: [ first := each ].
					last := each.
					(aBoolean not and: [ each == currentEditor and: [ previous notNil ] ])
						ifTrue: [ previous requestFocus.
							^ true ].
					(aBoolean and: [ previous == currentEditor ])
						ifTrue: [ each requestFocus.
							^ true ].
					previous := each ] ].
	aBoolean
		ifTrue: [ (first notNil and: [ first ~~ currentEditor ])
				ifTrue: [ first requestFocus.
					^ true ] ]
		ifFalse: [ (last notNil and: [ last ~~ currentEditor ])
				ifTrue: [ last requestFocus.
					^ true ] ].
	^ false
]

{ #category : #accessing }
GtRefactoringAttribute >> focusOnFirstShow [
	^ focusOnFirstShow
]

{ #category : #accessing }
GtRefactoringAttribute >> focusOnFirstShow: aBoolean [
	focusOnFirstShow := aBoolean
]

{ #category : #initialization }
GtRefactoringAttribute >> initialize [
	super initialize.
	self beNotOverwritableByStyler.
	self beAppend.
	focusOnFirstShow := true
]

{ #category : #testing }
GtRefactoringAttribute >> isFocusable [
	^ true
]

{ #category : #accessing }
GtRefactoringAttribute >> refactoringController [
	^ refactoringController
]

{ #category : #accessing }
GtRefactoringAttribute >> refactoringController: anObject [
	refactoringController := anObject
]
