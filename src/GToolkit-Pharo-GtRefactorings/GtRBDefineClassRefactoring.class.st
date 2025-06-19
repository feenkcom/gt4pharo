Class {
	#name : #GtRBDefineClassRefactoring,
	#superclass : #RBClassRefactoring,
	#instVars : [
		'definitionString',
		'superclass',
		'category'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtRBDefineClassRefactoring class >> model: aRBSmalltalk addClass: aName superclass: aSuperclassName category: aSymbol definition: aString [
	^self new
		model: aRBSmalltalk;
		addClass: aName
			superclass: aSuperclassName
			category: aSymbol 
			definition: aString;
		yourself
]

{ #category : #accessing }
GtRBDefineClassRefactoring >> addClass: aName superclass: aSuperclassName category: aSymbol definition: aString [ 
	self className: aName.
	superclass := self classObjectFor: aSuperclassName.
	category := aSymbol.

	definitionString := aString
]

{ #category : #transforming }
GtRBDefineClassRefactoring >> basicTransform [
	self model changes defineClass: definitionString
]

{ #category : #accessing }
GtRBDefineClassRefactoring >> definition: aString [
	definitionString := aString
	
]

{ #category : #preconditions }
GtRBDefineClassRefactoring >> preconditions [
	| cond |
	cond := ((RBCondition isMetaclass: superclass) 
				errorMacro: 'Superclass must not be a metaclass') not.

	^ cond & (RBCondition isValidClassName: className) 
		& (RBCondition isGlobal: className in: self model) not 
			& (RBCondition isSymbol: category) 
			& ((RBCondition withBlock: [category isNotEmpty ]) 
					errorMacro: 'Invalid category name')
]

{ #category : #transforming }
GtRBDefineClassRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtRBDefineClassRefactoring >> transform [
	self basicTransform
]
