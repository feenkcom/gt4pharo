Class {
	#name : #GtSnippetMoveMethodRefactoring,
	#superclass : #RBMoveMethodRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #'private - accessing' }
GtSnippetMoveMethodRefactoring >> getClassesForTemporaryVariable [
	(moveToClasses := (self options at: #variableTypesForReceiver) value: self) ifNil: [ super getClassesForTemporaryVariable ]
]

{ #category : #accessing }
GtSnippetMoveMethodRefactoring >> moveToClasses [
	^ moveToClasses
]

{ #category : #accessing }
GtSnippetMoveMethodRefactoring >> movedSelector [
	^ parseTree selector
]
