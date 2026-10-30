"
I exemplify ${class:GtFluidDefinitionStringBuilder}$: the definitions of new classes and traits, what the definition keeps from the data of an existing class or trait, and ${method:GtFluidDefinitionStringBuilder>>#fillFromBehavior:}$, which takes that data from a class or trait.
The examples with classes use dummy classes and ${method:GtRefactoryChangeManager class>>#isolatedInstanceDuring:}$, so they do not affect the global undo/redo history.
"
Class {
	#name : #GtFluidDefinitionStringBuilderExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #private }
GtFluidDefinitionStringBuilderExamples >> classNamed: aString [
	"Answer a class name in the dummy package, so that the class is removed with it"

	^ ((self packageName copyReplaceAll: '-' with: '') , aString) asSymbol
]

{ #category : #private }
GtFluidDefinitionStringBuilderExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ].
	environment := nil
]

{ #category : #private }
GtFluidDefinitionStringBuilderExamples >> createPackage [
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1
]

{ #category : #private }
GtFluidDefinitionStringBuilderExamples >> define: aDefinitionString [
	(GtRBAddClassChange definitionString: aDefinitionString) gtExecuteWithUndo
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> definitionOfExistingClassRecreatesIt [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ | aName aShape aBuilder |
			self createPackage.
			aName := self newShapedClass.
			aShape := self shapeOf: aName.
			aBuilder := GtFluidDefinitionStringBuilder new
					className: aName;
					traitNames: {self classNamed: 'TPlain'};
					slotNames: #('a' 'w');
					sharedVariableNames: #('Shared');
					classSlotNames: #('count' 'cache');
					packageName: self packageName;
					fillFromBehavior: aName asClass;
					yourself.
			self define: aBuilder definitionString.
			self assert: (self shapeOf: aName) equals: aShape.
			self assert: aShape last equals: 7.
			aBuilder ]
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> definitionOfExistingTraitRecreatesIt [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ | aName aShape aBuilder |
			self createPackage.
			aName := self newShapedTrait.
			aShape := self shapeOf: aName.
			aBuilder := GtFluidDefinitionStringBuilder new
					beTrait;
					className: aName;
					slotNames: #('a' 'w');
					classSlotNames: #('count');
					packageName: self packageName;
					fillFromBehavior: aName asClass;
					yourself.
			self define: aBuilder definitionString.
			self assert: (self shapeOf: aName) equals: aShape.
			self assert: aShape last equals: 7.
			aBuilder ]
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> existingLayoutAndSlotDefinitionsAreKept [
	<gtExample>
	| aBuilder |
	aBuilder := GtFluidDefinitionStringBuilder new
			className: self missingClassName;
			slotNames: #('a' 'w' 'b');
			classSlotNames: #('count' 'cache' 'extra');
			packageName: 'ExamplePackage';
			existingLayoutName: 'VariableLayout';
			existingSlotDefinitions: {#a -> '#a'. #w -> '#w => WeakSlot'};
			existingClassSlotDefinitions: {#count -> '#count'. #cache -> '#cache => WeakSlot'};
			yourself.
	self
		assert: aBuilder definitionString
		equals: 'Object << #GtFluidDefinitionStringBuilderExampleMissingClass
	layout: VariableLayout;
	slots: { #a . #w => WeakSlot . #b };
	sharedVariables: { };
	sharedPools: { };
	classSlots: { #count . #cache => WeakSlot . #extra };
	package: ''ExamplePackage'''.
	^ aBuilder
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> existingTraitCompositionIsKept [
	<gtExample>
	| aBuilder |
	aBuilder := GtFluidDefinitionStringBuilder new
			className: self missingClassName;
			traitNames: #('TGtPharoDummyTraitOne');
			packageName: 'ExamplePackage';
			existingTraitNames: #('TGtPharoDummyTraitOne') composition: 'TGtPharoDummyTraitOne - {#m}';
			yourself.
	self
		assert: aBuilder definitionString
		equals: 'Object << #GtFluidDefinitionStringBuilderExampleMissingClass
	traits: TGtPharoDummyTraitOne - {#m};
	slots: { };
	sharedVariables: { };
	sharedPools: { };
	classSlots: { };
	package: ''ExamplePackage'''.
	^ aBuilder
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> fillFromClass [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ | aName aTraitName aBuilder |
			self createPackage.
			aName := self newShapedClass.
			aTraitName := self classNamed: 'TPlain'.
			aBuilder := GtFluidDefinitionStringBuilder new
					className: aName;
					traitNames: {aTraitName};
					slotNames: #('a' 'w');
					sharedVariableNames: #('Shared');
					classSlotNames: #('count' 'cache');
					packageName: self packageName;
					fillFromBehavior: aName asClass;
					yourself.
			self
				assert: aBuilder definitionString
				equals: 'Object << ' , aName printString , '
	layout: VariableLayout;
	traits: ' , aTraitName , ' - {#m};
	slots: { #a . #w => WeakSlot };
	sharedVariables: { #Shared };
	sharedPools: { };
	classSlots: { #count . #cache => ProcessLocalSlot };
	package: ' , self packageName printString.
			aBuilder ]
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> fillFromTrait [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ | aName aBuilder |
			self createPackage.
			aName := self newShapedTrait.
			aBuilder := GtFluidDefinitionStringBuilder new
					beTrait;
					className: aName;
					slotNames: #('a' 'w');
					classSlotNames: #('count');
					packageName: self packageName;
					fillFromBehavior: aName asClass;
					yourself.
			self
				assert: aBuilder definitionString
				equals: 'Trait << ' , aName printString , '
	slots: { #a . #w => WeakSlot };
	classSlots: { #count };
	package: ' , self packageName printString.
			self assert: aBuilder existingLayoutName isNil.
			aBuilder ]
]

{ #category : #private }
GtFluidDefinitionStringBuilderExamples >> isolatedChangeManagerDuring: aBlock [
	"Evaluate aBlock with an isolated change manager.
	The dummy classes are removed before the global change manager is restored,
	so that neither the example nor its clean up affects the global undo/redo history"

	^ GtRefactoryChangeManager
		isolatedInstanceDuring: [ :aChangeManager | [ aBlock cull: aChangeManager ] ensure: [ self cleanUp ] ]
]

{ #category : #private }
GtFluidDefinitionStringBuilderExamples >> missingClassName [
	| aName |
	aName := #GtFluidDefinitionStringBuilderExampleMissingClass.
	self assert: (Smalltalk globals includesKey: aName) not.
	^ aName
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> newClassDefinition [
	<gtExample>
	| aBuilder |
	aBuilder := GtFluidDefinitionStringBuilder new
			className: self missingClassName;
			superclassName: 'Object';
			traitNames: #('TGtPharoDummyTraitOne' ' TGtPharoDummyTraitTwo ');
			slotNames: #('a' 'b');
			sharedVariableNames: #('Shared');
			sharedPoolNames: #('ChronologyConstants');
			classSlotNames: #('count');
			tagName: 'Core';
			packageName: 'ExamplePackage';
			yourself.
	self
		assert: aBuilder definitionString
		equals: 'Object << #GtFluidDefinitionStringBuilderExampleMissingClass
	traits: TGtPharoDummyTraitOne + TGtPharoDummyTraitTwo;
	slots: { #a . #b };
	sharedVariables: { #Shared };
	sharedPools: { ChronologyConstants };
	classSlots: { #count };
	tag: ''Core'';
	package: ''ExamplePackage'''.
	^ aBuilder
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> newClassDefinitionWithoutVariables [
	<gtExample>
	| aBuilder |
	aBuilder := GtFluidDefinitionStringBuilder new
			className: self missingClassName;
			packageName: 'ExamplePackage';
			yourself.
	self
		assert: aBuilder definitionString
		equals: 'Object << #GtFluidDefinitionStringBuilderExampleMissingClass
	slots: { };
	sharedVariables: { };
	sharedPools: { };
	classSlots: { };
	package: ''ExamplePackage'''.
	^ aBuilder
]

{ #category : #private }
GtFluidDefinitionStringBuilderExamples >> newPlainTrait [
	| aName |
	aName := self classNamed: 'TPlain'.
	self define: 'Trait << ' , aName printString , '
	package: ' , self packageName printString.
	^ aName
]

{ #category : #private }
GtFluidDefinitionStringBuilderExamples >> newShapedClass [
	"Answer the name of a class with a comment, a variable layout, a trait without one method,
	a weak slot, class-side slots of two kinds and a value in a class-side slot.
	The class side has no WeakSlot: changing the shape of a class with a class-side WeakSlot
	that was never written fails in Shift and leaves a half-built class"

	| aTraitName aName |
	aTraitName := self newPlainTrait.
	aName := self classNamed: 'Shaped'.
	self
		define: 'Object << ' , aName printString
				, '
	layout: VariableLayout;
	traits: ' , aTraitName , ' - {#m};
	slots: { #a . #w => WeakSlot };
	sharedVariables: { #Shared };
	classSlots: { #count . #cache => ProcessLocalSlot };
	package: ' , self packageName printString.
	(RBCommentChange comment: 'A shaped class' in: aName asClass) gtExecuteWithUndo.
	(aName asClass classSide slotNamed: #count) write: 7 to: aName asClass.
	^ aName
]

{ #category : #private }
GtFluidDefinitionStringBuilderExamples >> newShapedTrait [
	| aName |
	aName := self classNamed: 'TShaped'.
	self
		define: 'Trait << ' , aName printString
				, '
	slots: { #a . #w => WeakSlot };
	classSlots: { #count };
	package: ' , self packageName printString.
	(aName asClass classSide slotNamed: #count) write: 7 to: aName asClass.
	^ aName
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> newTraitDefinition [
	<gtExample>
	| aBuilder |
	aBuilder := GtFluidDefinitionStringBuilder new
			beTrait;
			className: self missingClassName;
			traitNames: #('TGtPharoDummyTraitOne');
			slotNames: #('a');
			sharedVariableNames: #('Ignored');
			classSlotNames: #('count');
			packageName: 'ExamplePackage';
			yourself.
	self
		assert: aBuilder definitionString
		equals: 'Trait << #GtFluidDefinitionStringBuilderExampleMissingClass
	traits: TGtPharoDummyTraitOne;
	slots: { #a };
	classSlots: { #count };
	package: ''ExamplePackage'''.
	^ aBuilder
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> otherTraitsAreComposedByName [
	<gtExample>
	| aBuilder |
	aBuilder := GtFluidDefinitionStringBuilder new
			className: self missingClassName;
			traitNames: #('TGtPharoDummyTraitOne' 'TGtPharoDummyTraitTwo');
			packageName: 'ExamplePackage';
			existingTraitNames: #('TGtPharoDummyTraitOne') composition: 'TGtPharoDummyTraitOne - {#m}';
			yourself.
	self
		assert: aBuilder definitionString
		equals: 'Object << #GtFluidDefinitionStringBuilderExampleMissingClass
	traits: TGtPharoDummyTraitOne + TGtPharoDummyTraitTwo;
	slots: { };
	sharedVariables: { };
	sharedPools: { };
	classSlots: { };
	package: ''ExamplePackage'''.
	^ aBuilder
]

{ #category : #private }
GtFluidDefinitionStringBuilderExamples >> packageName [
	^ environment anyDummyPackage realPackage name asString
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> removedSlotsAreNotKept [
	<gtExample>
	| aBuilder |
	aBuilder := GtFluidDefinitionStringBuilder new
			className: self missingClassName;
			slotNames: #('a');
			packageName: 'ExamplePackage';
			existingSlotDefinitions: {#a -> '#a'. #w -> '#w => WeakSlot'};
			yourself.
	self
		assert: aBuilder definitionString
		equals: 'Object << #GtFluidDefinitionStringBuilderExampleMissingClass
	slots: { #a };
	sharedVariables: { };
	sharedPools: { };
	classSlots: { };
	package: ''ExamplePackage'''.
	^ aBuilder
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> rootTagIsLeftOut [
	<gtExample>
	| someBuilders |
	someBuilders := {nil.
			''.
			'ExamplePackage'.
			Package rootTagName}
			collect: [ :aTagName |
				GtFluidDefinitionStringBuilder new
					className: self missingClassName;
					tagName: aTagName;
					packageName: 'ExamplePackage';
					yourself ].
	someBuilders
		do: [ :each |
			self
				assert: each definitionString
				equals: 'Object << #GtFluidDefinitionStringBuilderExampleMissingClass
	slots: { };
	sharedVariables: { };
	sharedPools: { };
	classSlots: { };
	package: ''ExamplePackage''' ].
	^ someBuilders last
]

{ #category : #private }
GtFluidDefinitionStringBuilderExamples >> shapeOf: aName [
	"Answer what redefining a class or trait from its definition must keep"

	| aBehavior |
	aBehavior := aName asClass.
	^ {aBehavior classLayout class name.
		aBehavior slots collect: #definitionString as: Array.
		aBehavior classVarNames asArray.
		aBehavior traitComposition printString.
		aBehavior comment.
		aBehavior classSide slots collect: #definitionString as: Array.
		(aBehavior classSide slotNamed: #count) read: aBehavior}
]

{ #category : #examples }
GtFluidDefinitionStringBuilderExamples >> traitDefinitionHasNoLayout [
	<gtExample>
	| aBuilder |
	aBuilder := GtFluidDefinitionStringBuilder new
			beTrait;
			className: self missingClassName;
			packageName: 'ExamplePackage';
			existingLayoutName: 'VariableLayout';
			yourself.
	self
		assert: aBuilder definitionString
		equals: 'Trait << #GtFluidDefinitionStringBuilderExampleMissingClass
	slots: { };
	classSlots: { };
	package: ''ExamplePackage'''.
	^ aBuilder
]
