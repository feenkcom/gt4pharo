Class {
	#name : #GtRBRemoveTraitUsageRefactoring,
	#superclass : #GtRBTraitRefactoring,
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #preconditions }
GtRBRemoveTraitUsageRefactoring >> applicabilityPreconditions [
	| condition |
	condition := RBCondition
			withBlock: [ self checkClassIncludesTrait.
				true ].
	^ self
		forPharo13AndNewer: [ {super applicabilityPreconditions first & condition} ]
		forOlder: [ super applicabilityPreconditions & condition ]
]

{ #category : #transforming }
GtRBRemoveTraitUsageRefactoring >> basicTransform [
	class traitExpression: self traitExpressionAfterRemoval.
	self model changes defineClass: class gtDefinitionString
]

{ #category : #preconditions }
GtRBRemoveTraitUsageRefactoring >> checkClassIncludesTrait [
	class := class asClassWithTrait.
	(self includesTrait: traitName in: class)
		ifFalse:
			[ ^ self refactoringError: traitName , ' is not used in ' , class name ]
]

{ #category : #accessing }
GtRBRemoveTraitUsageRefactoring >> gtDescription [
	<return: #String or: #BlRunRopedText>
	
	^ ('Remove' asRopedText glamorousRoundedBackground)
		append: ' trait usage ' asRopedText;
		append: traitName asRopedText glamorousRoundedBackground;
		append: ' from ' asRopedText;
		append: class name asRopedText
]

{ #category : #transforming }
GtRBRemoveTraitUsageRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtRBRemoveTraitUsageRefactoring >> removeTraitFromExpression: anAST [
	anAST isVariable
		ifTrue: [ ^ anAST name = traitName
				ifTrue: [ nil ]
				ifFalse: [ anAST ] ].
	(anAST isMessage and: [ anAST isBinary ])
		ifTrue: [ | left right |
			left := self removeTraitFromExpression: anAST receiver.
			right := self removeTraitFromExpression: anAST arguments first.
			right isNil
				ifTrue: [ ^ left ].
			left isNil
				ifTrue: [ ^ anAST selector = #-
						ifTrue: [ nil ]
						ifFalse: [ right ] ].
			^ RBMessageNode
				receiver: left
				selector: anAST selector
				arguments: {right} ].
	anAST isLiteral
		ifTrue: [ ^ anAST ].
	self refactoringError: 'Unknown trait expression'
]

{ #category : #transforming }
GtRBRemoveTraitUsageRefactoring >> traitExpressionAfterRemoval [
	| expression ast |
	expression := class traitExpression.
	ast := RBParser parseExpression: expression.
	ast := self removeTraitFromExpression: ast.
	^ ast isNil
		ifTrue: [ '{}' ]
		ifFalse: [ ast formattedCode ]
]

{ #category : #transforming }
GtRBRemoveTraitUsageRefactoring >> transform [
	self basicTransform
]
