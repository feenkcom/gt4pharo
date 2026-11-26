"
I show what {{gtClass:GtPharoDummiesGenerator}} generates: classes as before by default, and, on request, class variables, class-side slots, traits and accessors that refer to the variables.
"
Class {
	#name : #GtPharoDummiesGeneratorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Dummies'
}

{ #category : #examples }
GtPharoDummiesGeneratorExamples >> hierarchyWithVariablesAndTraits [
	"On request, each class gets class variables and class-side slots, and the root class uses the traits of its package. The accessors refer to the variables"

	<gtExample>
	<return: #Array>
	| generator environment aPackage aRoot aLeaf aTrait |
	generator := GtPharoDummiesGenerator new
			amountOfPackages: 1;
			amountOfClasses: 2;
			amountOfClassVariables: 1;
			amountOfClassSlots: 1;
			amountOfTraits: 1;
			yourself.
	environment := generator generateHierarchy.
	^ [ aPackage := environment dummyPackages first.
	aRoot := aPackage dummyClasses first.
	aLeaf := aPackage dummyClasses last.
	aTrait := aPackage dummyTraits first.
	self assert: aPackage dummyTraits size equals: 1.
	self assert: aTrait realClass isTrait.
	self assert: aTrait realClass instVarNames equals: #(#traitSlot1).
	self
		assert: aRoot realClass traitComposition traits asArray
		equals: {aTrait realClass}.
	self assert: aLeaf realClass traitComposition isEmpty.
	self assert: aLeaf realClass superclass equals: aRoot realClass.
	{aRoot.
		aLeaf}
		do: [ :each | 
			self assert: each classVariableNames size equals: 1.
			self assert: each classSlotNames size equals: 1.
			self
				assert: each realClass classVarNames asArray
				equals: each classVariableNames asArray.
			self
				assert: each realClass classSide instVarNames asArray
				equals: each classSlotNames asArray ].
	aPackage dummyClasses , aPackage dummyTraits
		do: [ :each | generator addDummyAccessorsToClass: each ].
	self
		assert: ((aRoot realClass >> aRoot instVarNames first asSymbol)
				instanceVariableReadNodes collect: [ :aNode | aNode name ]) asArray
		equals: {aRoot instVarNames first asSymbol}.
	self
		assert: (aRoot realClass classSide
				includesSelector: aRoot classVariableNames first uncapitalized asSymbol).
	self
		assert: (aRoot realClass classSide
				includesSelector: (aRoot classSlotNames first , ':') asSymbol).
	self assert: (aTrait realClass includesSelector: #traitSlot1).
	self
		assert: (aRoot dummyMethods
				anySatisfy: [ :each | each selector = aRoot instVarNames first asSymbol ]).
	self assert: aRoot anyDummyUnaryMethod selector equals: #method1.
	(aPackage dummyClasses , aPackage dummyTraits
		collect: [ :each | each className ]) asArray ]
		ensure: [ environment removeFromSystem ]
]

{ #category : #examples }
GtPharoDummiesGeneratorExamples >> hierarchyWithoutOptions [
	"By default the generated classes have no class variables, no class-side slots and no traits, and their methods do not refer to their variables"

	<gtExample>
	<return: #Array>
	| environment aPackage |
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 2.
	^ [ aPackage := environment dummyPackages first.
	self assert: aPackage dummyTraits isEmpty.
	aPackage dummyClasses
		do: [ :each | 
			self assert: each realClass classVarNames isEmpty.
			self assert: each realClass classSide instVarNames isEmpty.
			self assert: each realClass traitComposition isEmpty.
			self assert: each classVariableNames isEmpty.
			self assert: each classSlotNames isEmpty.
			self
				assert: (each realClass methods
						allSatisfy: [ :aMethod | aMethod instanceVariableReadNodes isEmpty ]) ].
	(aPackage dummyClasses collect: [ :each | each className ]) asArray ]
		ensure: [ environment removeFromSystem ]
]
