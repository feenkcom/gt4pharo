"
I am used to exemplify {{gtClass: GtRefactoringsPreviewButton }} behavior. 
See {{gtClass: GtRefactoringsPreviewButtonExamples }} for more details.

"
Class {
	#name : #GtRefactoringsDummyClass,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Refactorings - Support'
}

{ #category : #testing }
GtRefactoringsDummyClass >> isDummyExampleObject [
	"Most likely it will return true or false"
	
	^ (0 to: 1) atRandom = 0
]

{ #category : #accessing }
GtRefactoringsDummyClass >> thisIsALongMethodThatWillBeRefactored [
	"Keep in mind that this is a dummy method to test refactorings UI :-)"

	| anObject |
	anObject := GtRefactoringsDummyClass new.

	anObject isDummyExampleObject
		ifTrue: [  "Dummy objects can do what ever they wish." ]
]

{ #category : #accessing }
GtRefactoringsDummyClass >> userOfThisIsALongMethodThatWillBeRefactored [
	"Keep in mind that this is a dummy method to test refactorings UI :-)"

	| anObject |
	anObject := GtRefactoringsDummyClass new thisIsALongMethodThatWillBeRefactored.

	anObject isDummyExampleObject
		ifTrue: [  "Dummy objects can do what ever they wish." ]
]

{ #category : #accessing }
GtRefactoringsDummyClass >> userTwoOfThisIsALongMethodThatWillBeRefactored [
	"Keep in mind that this is a dummy method to test refactorings UI :-)"

	| anObject |
	anObject := GtRefactoringsDummyClass new thisIsALongMethodThatWillBeRefactored.

	anObject isDummyExampleObject
		ifTrue: [  "Dummy objects can do what ever they wish." ]
]
