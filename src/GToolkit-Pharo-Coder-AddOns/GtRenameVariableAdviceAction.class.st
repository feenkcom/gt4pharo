Class {
	#name : #GtRenameVariableAdviceAction,
	#superclass : #GtAdviceAction,
	#instVars : [
		'behavior',
		'oldName',
		'newName'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-ObjectAdvices'
}

{ #category : #'instance creation' }
GtRenameVariableAdviceAction class >> rename: oldName to: newName in: behavior [
	^ self new
		rename: oldName
			to: newName
			in: behavior;
		yourself
]

{ #category : #accessing }
GtRenameVariableAdviceAction >> defaultTitle [
	^ ('Rename ' , oldName , ' to ' , newName) asRopedText
]

{ #category : #executing }
GtRenameVariableAdviceAction >> executeOn: anElement [
	(self renameRefactoringClass
		rename: oldName
		to: newName
		in: behavior) execute
]

{ #category : #initialization }
GtRenameVariableAdviceAction >> rename: old to: new in: class [
	oldName := old.
	newName := new.
	behavior := class
]

{ #category : #executing }
GtRenameVariableAdviceAction >> renameRefactoringClass [
	^ self subclassResponsibility
]
