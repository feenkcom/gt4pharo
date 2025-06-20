Class {
	#name : #GtRBRemovePoolVariableRefactoring,
	#superclass : #RBVariableRefactoring,
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #transforming }
GtRBRemovePoolVariableRefactoring >> basicTransform [
	class removePoolDictionary: variableName asSymbol
]

{ #category : #preconditions }
GtRBRemovePoolVariableRefactoring >> checkClassReferencePoolVariable: anAssociation [
	class withAllSubclasses
		do: [ :sub | 
			sub realClass
				ifNotNil: [ :cls | 
					[ :behavior | 
					"Should look in the model, but currently that is not supported"
					(behavior whichSelectorsReferTo: anAssociation)
						ifNotEmpty: [ :sel | 
							self
								refactoringError:
									behavior name asString , '>>' , sel first , ' references '
										, anAssociation key ] ]
						value: cls;
						value: cls class ] ]
]

{ #category : #preconditions }
GtRBRemovePoolVariableRefactoring >> checkReferenceToPoolDictionary [
	| newPool |
	newPool := Smalltalk globals at: variableName asSymbol.
	newPool
		bindingsDo:
			[ :binding | self checkClassReferencePoolVariable: binding ]
]

{ #category : #accessing }
GtRBRemovePoolVariableRefactoring >> gtDescription [
	<return: #String or: #BlRunRopedText>
	
	^ ('Remove' asRopedText glamorousRoundedBackground)
		append: ' pool named ' asRopedText;
		append: variableName asRopedText glamorousRoundedBackground;
		append: ' from ' asRopedText;
		append: class name asRopedText
]

{ #category : #preconditions }
GtRBRemovePoolVariableRefactoring >> preconditions [
	^ (RBCondition isMetaclass: class) not
		& (RBCondition includesPoolDictionary: variableName in: class)
		&
			(RBCondition
				withBlock: [ self checkReferenceToPoolDictionary.
					true ])
]

{ #category : #transforming }
GtRBRemovePoolVariableRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtRBRemovePoolVariableRefactoring >> transform [
	self basicTransform
]
