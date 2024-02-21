Class {
	#name : #GtRefactoringError,
	#superclass : #RBRefactoringError,
	#category : #'GToolkit-Pharo-Coder-UI-Extract method'
}

{ #category : #accessing }
GtRefactoringError >> messageBlock [
	^ tag ifNil: [ super messageBlock ]
]
