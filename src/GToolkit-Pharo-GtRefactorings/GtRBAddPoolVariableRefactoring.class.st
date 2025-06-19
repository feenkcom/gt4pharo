Class {
	#name : #GtRBAddPoolVariableRefactoring,
	#superclass : #RBVariableRefactoring,
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #transforming }
GtRBAddPoolVariableRefactoring >> basicTransform [
	class addPoolDictionary: variableName asSymbol
]

{ #category : #preconditions }
GtRBAddPoolVariableRefactoring >> checkClassReferencePoolVariable: anAssociation existingPoolName: aString [
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
										, anAssociation key , ' which is defined in both '
										, variableName , ' and ' , aString ] ]
						value: cls;
						value: cls class ] ]
]

{ #category : #preconditions }
GtRBAddPoolVariableRefactoring >> checkConflictingPoolVariableNames [
	| newPool |
	newPool := Smalltalk globals at: variableName asSymbol.
	class sharedPools
		do: [ :pool | 
			newPool == pool
				ifFalse: [ pool
						bindingsDo: [ :binding | 
							(newPool includesKey: binding key)
								ifTrue: [ self
										checkClassReferencePoolVariable: binding
										existingPoolName: pool name ] ] ] ]
]

{ #category : #accessing }
GtRBAddPoolVariableRefactoring >> gtDescription [
	<return: #String or: #BlRunRopedText>
	
	^ ('Add' asRopedText glamorousRoundedBackground)
		append: ' pool named ' asRopedText;
		append: variableName asRopedText glamorousRoundedBackground;
		append: ' to ' asRopedText;
		append: class name asRopedText
]

{ #category : #preconditions }
GtRBAddPoolVariableRefactoring >> preconditions [
	^ (RBCondition isMetaclass: class) not
		& (RBCondition isPoolDictionary: variableName in: self model)
		& (RBCondition includesPoolDictionary: variableName in: class) not
		&
			(RBCondition
				withBlock: [ self checkConflictingPoolVariableNames.
					true ])
]

{ #category : #transforming }
GtRBAddPoolVariableRefactoring >> privateTranform [
	self basicTransform
]

{ #category : #transforming }
GtRBAddPoolVariableRefactoring >> transform [
	self basicTransform
]
