Class {
	#name : #GtMethodInlineMessageFromComponentRefactoringController,
	#superclass : #GtMethodInlineMessageSendRefactoringController,
	#instVars : [
		'implementor'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method'
}

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> addRefactoringPreview [
	self
		addRefactoringChangesPreview: self refactoring
		at: self previewPosition
		whenComplete: [ 
			self removeRefactoringAttribute.
			self allowSave ]
]

{ #category : #initialization }
GtMethodInlineMessageFromComponentRefactoringController >> implementor: aClass [
	implementor := aClass
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> inlineRefactoringClass [
	^ RBInlineMethodFromComponentRefactoring
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> performMethodRefactoring: aRefactoring [
	[ aRefactoring primitiveExecute.
	(aRefactoring model changes changes
		allSatisfy: [ :each | 
			(each isKindOf: RBAddMethodChange)
				and: [ each selector = sourceCoderViewModel coderModel currentSelector
						and: [ sourceCoderViewModel behavior = each changeClass ] ] ])
		ifTrue: [ (self changedSourceForCurrentMethod: aRefactoring model changes)
				ifNotNil: [ :source | ^ self setText: source ] ] ]
		on: RBRefactoringError
		do: [ :ex | ^ self inform: ex messageText ].
	self preventSave.
	sourceCoderViewModel selectNone.
	self addRefactoringPreview
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> previewPosition [
	^ node sourceInterval last
]

{ #category : #accessing }
GtMethodInlineMessageFromComponentRefactoringController >> refactoring [
	| refactoring |
	refactoring := super refactoring.
	refactoring
		setOption: #implementorToInline
		toUse: [ :ref :classes | classes detect: [ :each | each realClass = implementor ] ifNone: [ nil ] ].
	^ refactoring
]
