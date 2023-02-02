Class {
	#name : #GtPP2InlineProductionRefactoring,
	#superclass : #RBInlineMethodRefactoring,
	#instVars : [
		'variableName'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtPP2InlineProductionRefactoring >> hasVariableReference [
	(class whoDefinesInstanceVariable: variableName) withAllSubclasses
		do: [ :each | 
			(each whichSelectorsReferToInstanceVariable: variableName) notEmpty
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #initialization }
GtPP2InlineProductionRefactoring >> inline: anInterval inMethod: aSelector forClass: aClass [
	| ast variable method |
	super
		inline: anInterval
		inMethod: aSelector
		forClass: aClass.
	method := class methodFor: sourceSelector.
	ast := method ast.
	ast ifNil: [ self refactoringFailure: 'Could not parse sources' ].
	variable := ast whichNodeIsContainedBy: sourceInterval.
	variable isVariable
		ifFalse: [ self refactoringFailure: 'Node is not a variable' ].
	variableName := variable name.
	variable
		replaceWith: (RBMessageNode
				receiver: (RBVariableNode named: 'self')
				selector: variable name asSymbol).
	method compileTree: ast.
	sourceInterval := sourceInterval first to: sourceInterval last + 5
]

{ #category : #accessing }
GtPP2InlineProductionRefactoring >> transform [
	super transform.
	self hasVariableReference
		ifFalse: [ (class whoDefinesInstanceVariable: variableName)
				removeInstanceVariable: variableName.
			(class whoDefinesMethod: variableName asSymbol)
				removeMethod: variableName asSymbol ].
	self gtCleanupChanges
]
