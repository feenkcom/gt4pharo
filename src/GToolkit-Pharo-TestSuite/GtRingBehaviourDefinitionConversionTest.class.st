Class {
	#name : #GtRingBehaviourDefinitionConversionTest,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-TestSuite-Utility'
}

{ #category : #utils }
GtRingBehaviourDefinitionConversionTest >> createRingClassEntityForExistingClass [
	| ringEnvironment currentClass ringClass |
	ringEnvironment := RGEnvironment new.
	currentClass := self currentClass.

	ringClass := ringEnvironment ensureClassNamed: currentClass name.

	ringClass
		package: (ringEnvironment ensurePackageNamed: currentClass package name);
		category: currentClass category;
		superclass: (ringEnvironment ensureClassNamed: currentClass superclass name);
		instanceVariables: currentClass instVarNames;
		classVariables: currentClass classVarNames.

	ringClass comment content: currentClass comment.
	ringClass classSide instanceVariables: currentClass class instVarNames.
	^ ringClass 
]

{ #category : #utils }
GtRingBehaviourDefinitionConversionTest >> currentClass [
	^ BlElement
]

{ #category : #examples }
GtRingBehaviourDefinitionConversionTest >> testRingClassToRingClassDefinitionConversion [
	<gtExample>
	| ringClass ringDefinition |
	
	ringClass  := self createRingClassEntityForExistingClass.
	ringDefinition := ringClass asRingDefinition.
	
	self 
		forPharo12: [
			self 
				assert: ringDefinition package name 
				equals: self currentClass package name] 
		forPharo11AndPharo10: [
			self 
				assert: ringDefinition package name 
				equals: self currentClass category ].
	self assert: ringDefinition category equals: self currentClass category.
	
	^ ringDefinition
]
