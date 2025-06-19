Class {
	#name : #GtExtractMethodToComponentRefactoring,
	#superclass : #RBExtractMethodToComponentRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring'
}

{ #category : #transforming }
GtExtractMethodToComponentRefactoring >> extractMethod [
	| ast |
	super extractMethod.
	ast := class parseTreeForSelector: selector.
	ast body statements last isReturn ifFalse: [ ^ self ].
	(ast body statements last value isMessage
		and: [ ast body statements last value selector = extractedMethodSelector ])
		ifFalse: [ ^ self ].
	"ast body statements last replaceWith: ast body statements last value copy.
	class compileTree: ast"
]

{ #category : #transforming }
GtExtractMethodToComponentRefactoring >> inlineForwarder [
	"Changing to use Gt inline all variant"
	| refactoring |
	refactoring := GtInlineAllSendersRefactoring 
				model: self model
				sendersOf: extractedMethodSelector
				in: class.
	refactoring setOption: #inlineExpression toUse: [:ref :string | true].
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtExtractMethodToComponentRefactoring >> moveMethod [
	| variable refactoring |
	variable := self
			selectVariableToMoveMethodTo: extractedMethodSelector
			class: class.
	variable ifNil: [ self refactoringFailure: 'Did not extract method' ].
	refactoring := GtMoveMethodRefactoring
			model: self model
			selector: extractedMethodSelector
			class: class
			variable: variable.
	self performCompositeRefactoring: refactoring
]

{ #category : #transforming }
GtExtractMethodToComponentRefactoring >> privateTransform [
	super transform.
	self gtCleanupChanges
]

{ #category : #transforming }
GtExtractMethodToComponentRefactoring >> transform [
	super transform.
	self gtCleanupChanges
]
