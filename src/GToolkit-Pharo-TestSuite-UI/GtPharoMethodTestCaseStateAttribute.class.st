"
I insert {{gtClass:GtPharoMethodTestCaseStateElement}} when a {{gtClass:BlText}} is displayed by {{gtClass:BrEditorElement}}. 
"
Class {
	#name : #GtPharoMethodTestCaseStateAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'testCase'
	],
	#category : 'GToolkit-Pharo-TestSuite-UI-Styler'
}

{ #category : #accessing }
GtPharoMethodTestCaseStateAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ { GtPharoMethodTestCaseStateElement new 
			testCase: self testCase;
			margin: (BlInsets top: 1 left: 6 bottom: 1 right: 1) }.
]

{ #category : #initialization }
GtPharoMethodTestCaseStateAttribute >> initialize [
	super initialize.
	self beAppend
]

{ #category : #printing }
GtPharoMethodTestCaseStateAttribute >> printOn: aStream [
	self testCase ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'example-status: ';
		print: self testCase statusLabel.
]

{ #category : #accessing }
GtPharoMethodTestCaseStateAttribute >> testCase [
	^ testCase
]

{ #category : #accessing }
GtPharoMethodTestCaseStateAttribute >> testCase: aTestCase [
	testCase := aTestCase
]
