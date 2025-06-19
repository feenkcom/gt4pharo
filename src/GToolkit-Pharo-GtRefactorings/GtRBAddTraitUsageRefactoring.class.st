Class {
	#name : #GtRBAddTraitUsageRefactoring,
	#superclass : #GtRBTraitRefactoring,
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #transforming }
GtRBAddTraitUsageRefactoring >> basicTransform [
	| newExpression |
	newExpression := class traitExpression
			ifNil: [ traitName ]
			ifNotNil: [ :exp | exp , ' + ' , traitName ].
	class traitExpression: newExpression.
	self model changes defineClass: class gtDefinitionString
]

{ #category : #private }
GtRBAddTraitUsageRefactoring >> checkClassDoesNotHaveSameSlotsAsTrait [
	| aTrait theTraitSlots aClass |

	aClass := class.
	aTrait := Smalltalk globals
		at: traitName asSymbol
		ifAbsent: [ ^ false ].

	theTraitSlots := aTrait slotNames asSet.
	({ aClass }, aClass allSubclasses, aClass allSuperclasses) do: [ :eachClass |
		| theClassSlotNames |
		theClassSlotNames := eachClass instanceVariableNames.
		theClassSlotNames
			do: [ :eachSlotName |
				(theTraitSlots includes: eachSlotName)
					ifTrue: [
						^ false ] ] ].
			
	^ true
]

{ #category : #private }
GtRBAddTraitUsageRefactoring >> checkClassDoesNotIncludeTrait [
	class := class asClassWithTrait.
	class withAllSuperclasses
		do: [ :each | 
			(self includesTrait: traitName in: each)
				ifTrue: [ ^ self
						refactoringError: traitName , ' is already included in ' , each name ] ]
]

{ #category : #accessing }
GtRBAddTraitUsageRefactoring >> gtDescription [
	<return: #String or: #BlRunRopedText>
	
	^ ('Add' asRopedText glamorousRoundedBackground)
		append: ' trait usage ' asRopedText;
		append: traitName asRopedText glamorousRoundedBackground;
		append: ' to ' asRopedText;
		append: class name asRopedText
]

{ #category : #preconditions }
GtRBAddTraitUsageRefactoring >> preconditions [
	^ (super preconditions
		&
			(RBCondition
				withBlock: [ self checkClassDoesNotIncludeTrait.
					true ]))
				&
			(RBCondition
				withBlock: [ self checkClassDoesNotHaveSameSlotsAsTrait ]
				errorString: 'Class (superclasses or subclasses) already has slot from the ', traitName)
]

{ #category : #transforming }
GtRBAddTraitUsageRefactoring >> privateTranform [
	self basicTransform
]

{ #category : #transforming }
GtRBAddTraitUsageRefactoring >> transform [
	self basicTransform
]
