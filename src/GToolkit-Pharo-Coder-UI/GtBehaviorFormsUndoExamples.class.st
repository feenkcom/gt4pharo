"
I exemplify saving from the class and trait forms: a save is one undoable change that defines the class or trait together with its class-side slots, and keeps the layout, the kinds of the slots, the trait composition and the values of the class-side slots that the form does not change.
My examples use ${method:GtRefactoryChangeManager class>>#isolatedInstanceDuring:}$, so they do not affect the global undo/redo history.
"
Class {
	#name : #GtBehaviorFormsUndoExamples,
	#superclass : #GtCreationFormExample,
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #examples }
GtBehaviorFormsUndoExamples >> classCreationFormRefusesSlotNamesOfItsSuperclass [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ | aForm |
			self createPackage.
			aForm := GtClassCreationForm new
					superclassName: self newSuperclassWithSlots;
					traits: {self newTraitWithSlots};
					yourself.
			self assert: (self is: #('n' 'x') validFor: aForm slotsDescription).
			self assert: (self is: #('s') validFor: aForm slotsDescription) not.
			self assert: (self is: #('c' 'cx') validFor: aForm classSlotsDescription).
			self assert: (self is: #('cs') validFor: aForm classSlotsDescription) not.
			self assert: (self is: #('name') validFor: aForm classSlotsDescription) not.
			aForm ]
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> classCreationWithClassSideSlotIsOneUndoableChange [
	"The class creation form defines the class with its class-side slots in one change"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aForm aName |
			self createPackage.
			self newShapedClass.
			aName := self classNamed: 'Created'.
			aForm := GtClassCreationForm new
					newClassName: aName;
					slots: {'a'};
					classSlots: {'count'};
					packageAndTagName: self packageAndTagName;
					yourself.
			self
				scripterSaving: aForm
				thenAssert: [ (self shapeOf: aName)
						= {#FixedLayout.
								{'#a'}.
								#().
								'{}'.
								''.
								{'#count'}.
								{nil}} ]
				afterUndo: [ (Smalltalk globals includesKey: aName) not ]
				in: aChangeManager ]
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> classNamed: aString [
	"Answer a class name in the dummy package, so that the class is removed with it"

	^ ((self packageName copyReplaceAll: '-' with: '') , aString) asSymbol
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> classUpdateAddingClassSideSlotKeepsValues [
	"Adding a class-side slot in the class definition form keeps the values of the other class-side slots"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aName aShape aForm |
			self createPackage.
			aName := self newShapedClass.
			aShape := self shapeOf: aName.
			aForm := GtClassUpdateForm new onClass: aName asClass.
			aForm classSlots: (aForm classSlots asOrderedCollection copyWith: 'extra').
			self
				scripterSaving: aForm
				thenAssert: [ (self shapeOf: aName)
						= ((aShape copyFrom: 1 to: 5)
								, {{'#count'. '#extra'}.
										{7. nil}}) ]
				afterUndo: [ (self shapeOf: aName) = aShape ]
				in: aChangeManager ]
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> classUpdateFormAcceptsExistingSlotsNamedLikeTraitSlots [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ | aTraitName aName aForm |
			self createPackage.
			aTraitName := self newTraitWithSlots.
			aName := self classNamed: 'ShadowsTraitSlots'.
			self
				define: 'Object << ' , aName printString , '
	traits: ' , aTraitName , ';
	slots: { #x };
	classSlots: { #cx };
	package: ' , self packageName printString.
			aForm := GtClassUpdateForm new onClass: aName asClass.
			self assert: aForm slots asArray equals: #(#x).
			self assert: aForm classSlots asArray equals: #(#cx).
			self assert: (self is: aForm slots validFor: aForm slotsDescription).
			self assert: (self is: aForm classSlots validFor: aForm classSlotsDescription).
			aForm superclassName: self newSuperclassWithSlots.
			self assert: (self is: #('x') validFor: aForm slotsDescription).
			self assert: (self is: #('x' 's') validFor: aForm slotsDescription) not.
			aForm ]
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> classUpdateFormRefusesSlotNamesOfANewSuperclass [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ | aName aForm |
			self createPackage.
			aName := self classNamed: 'Plain'.
			self
				define: 'Object << ' , aName printString , '
	slots: { #own };
	package: ' , self packageName printString.
			aForm := GtClassUpdateForm new onClass: aName asClass.
			self assert: (self is: #('own' 's') validFor: aForm slotsDescription).
			aForm superclassName: self newSuperclassWithSlots.
			self assert: (self is: #('own') validFor: aForm slotsDescription).
			self assert: (self is: #('own' 's') validFor: aForm slotsDescription) not.
			self assert: (self is: #('cs') validFor: aForm classSlotsDescription) not.
			aForm ]
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> classUpdateFormShowsOnlyOwnSlots [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ | aName aForm |
			self createPackage.
			aName := self newClassUsingTraitWithSlots.
			aForm := GtClassUpdateForm new onClass: aName asClass.
			self assert: aForm slots asArray equals: #(#own).
			self assert: aForm classSlots asArray equals: #().
			self assert: (self is: #('own' 'x') validFor: aForm slotsDescription).
			self assert: (self is: #('cx') validFor: aForm classSlotsDescription).
			aForm ]
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> classUpdateKeepsTraitExclusions [
	"Saving the class definition form with the same traits keeps the trait composition, with its exclusions"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aTraitName aName aShape |
			self createPackage.
			aTraitName := self newShapedTrait.
			aName := self classNamed: 'UsesTrait'.
			self
				define: 'Object << ' , aName printString , '
	traits: ' , aTraitName , ' - {#m};
	package: ' , self packageName printString.
			aShape := self shapeOf: aName.
			self assert: (aShape at: 4) equals: aTraitName , ' - {#m}'.
			self
				scripterSaving: (GtClassUpdateForm new onClass: aName asClass)
				thenAssert: [ (self shapeOf: aName) = aShape ]
				afterUndo: [ (self shapeOf: aName) = aShape ]
				in: aChangeManager ]
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> classUpdateUsingTraitWithSlotsKeepsTraitSlots [
	"Adding a slot to a class that uses a trait with slots leaves the slots of the trait to the trait.
	After the undo only the instance side is compared: the undo definition makes the class-side slot
	of the trait a slot of the class (F5, RBRefactoryClassChange>>#undoClassDefinitionFor:)"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aName aTraitName aForm aShape |
			self createPackage.
			aName := self newClassUsingTraitWithSlots.
			aTraitName := self classNamed: 'TWithSlots'.
			aShape := self slotDefinersOf: aName.
			aForm := GtClassUpdateForm new onClass: aName asClass.
			aForm slots: (aForm slots asOrderedCollection copyWith: 'extra').
			self
				scripterSaving: aForm
				thenAssert: [ (self slotDefinersOf: aName)
						= {{#extra -> aName. #own -> aName. #x -> aTraitName}.
								{#cx -> (aTraitName , ' classTrait')}} ]
				afterUndo: [ (self slotDefinersOf: aName) first = aShape first ]
				in: aChangeManager ]
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> classUpdateWithoutEditsKeepsShape [
	"Saving the class definition form without edits keeps the layout, the kinds of the slots,
	the comment and the values of the class-side slots"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aName aShape |
			self createPackage.
			aName := self newShapedClass.
			aShape := self shapeOf: aName.
			self
				assert: aShape
				equals: {#VariableLayout.
						{'#a'. '#w => WeakSlot'}.
						#(#Shared).
						'{}'.
						'A shaped class'.
						{'#count'}.
						{7}}.
			self
				scripterSaving: (GtClassUpdateForm new onClass: aName asClass)
				thenAssert: [ (self shapeOf: aName) = aShape ]
				afterUndo: [ (self shapeOf: aName) = aShape ]
				in: aChangeManager ]
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ].
	environment := nil
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> createPackage [
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> define: aDefinitionString [
	"Define a class or trait with an undoable change, so that the undo/redo history is not empty"

	(GtRBAddClassChange definitionString: aDefinitionString) gtExecuteWithUndo
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> is: someNames validFor: aDescription [
	^ [ aDescription validate: someNames.
		true ] on: MAError do: [ :anError | false ]
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> isolatedChangeManagerDuring: aBlock [
	"Evaluate aBlock with an isolated change manager.
	The dummy classes are removed before the global change manager is restored,
	so that neither the example nor its clean up affects the global undo/redo history"

	^ GtRefactoryChangeManager
		isolatedInstanceDuring: [ :aChangeManager | [ aBlock cull: aChangeManager ] ensure: [ self cleanUp ] ]
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> newClassUsingTraitWithSlots [
	| aTraitName aName |
	aTraitName := self newTraitWithSlots.
	aName := self classNamed: 'UsesTraitWithSlots'.
	self
		define: 'Object << ' , aName printString , '
	traits: ' , aTraitName , ';
	slots: { #own };
	package: ' , self packageName printString.
	^ aName
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> newShapedClass [
	"Answer the name of a class with a comment, a variable layout, a weak slot,
	a shared variable and a value in a class-side slot"

	| aName |
	aName := self classNamed: 'Shaped'.
	self
		define: 'Object << ' , aName printString
				, '
	layout: VariableLayout;
	slots: { #a . #w => WeakSlot };
	sharedVariables: { #Shared };
	classSlots: { #count };
	package: ' , self packageName printString.
	(RBCommentChange comment: 'A shaped class' in: aName asClass) gtExecuteWithUndo.
	(aName asClass classSide slotNamed: #count) write: 7 to: aName asClass.
	^ aName
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> newShapedTrait [
	"Answer the name of a trait with a slot and a value in a class-side slot"

	| aName |
	aName := self classNamed: 'TShaped'.
	self
		define: 'Trait << ' , aName printString
				, '
	slots: { #a };
	classSlots: { #count };
	package: ' , self packageName printString.
	(aName asClass classSide slotNamed: #count) write: 7 to: aName asClass.
	^ aName
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> newSuperclassWithSlots [
	| aName |
	aName := self classNamed: 'SuperWithSlots'.
	self
		define: 'Object << ' , aName printString , '
	slots: { #s };
	classSlots: { #cs };
	package: ' , self packageName printString.
	^ aName
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> newTraitUsingTraitWithSlots [
	| aTraitName aName |
	aTraitName := self newTraitWithSlots.
	aName := self classNamed: 'TUsesTraitWithSlots'.
	self
		define: 'Trait << ' , aName printString , '
	traits: ' , aTraitName , ';
	slots: { #y };
	classSlots: { #cy };
	package: ' , self packageName printString.
	^ aName
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> newTraitWithSlots [
	"Answer the name of a trait with a slot and a class-side slot"

	| aName |
	aName := self classNamed: 'TWithSlots'.
	self
		define: 'Trait << ' , aName printString , '
	slots: { #x };
	classSlots: { #cx };
	package: ' , self packageName printString.
	^ aName
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> packageAndTagName [
	^ GtPackageAndTagName new
		packageName: self packageName;
		tagName: ''
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> packageName [
	^ environment anyDummyPackage realPackage name
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> save: aScripter [
	aScripter
		clickStep: [ :s |
			s
				label: 'Click save button';
				// #toolbar;
				onChildAt: 1 ]
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> scripterSaving: aForm thenAssert: aSavedBlock afterUndo: anUndoneBlock in: aChangeManager [
	"Save from aForm, check that the form defined the class or trait and evaluate aSavedBlock,
	then undo once and evaluate anUndoneBlock. The setup of each example records changes,
	so the history must not be empty after the undo"

	| scripter aSavedBehavior |
	aForm onAccept: [ :aBehavior | aSavedBehavior := aBehavior ].
	scripter := self scripterWithModel: [ aForm ].
	self save: scripter.
	scripter
		assertStep: [ :s |
			s
				label: 'Assert the form defined the class or trait';
				satisfies: [ :anElement |
					aSavedBehavior notNil
						and: [ aSavedBehavior == (Smalltalk globals classOrTraitNamed: aForm rawClassName) ] ] ].
	scripter
		assertStep: [ :s |
			s
				label: 'Assert the saved class or trait';
				satisfies: [ :anElement | aSavedBlock value ] ].
	self undo: aChangeManager in: scripter.
	scripter
		assertStep: [ :s |
			s
				label: 'Assert one undo reverts the save';
				satisfies: [ :anElement | anUndoneBlock value ] ].
	scripter
		assertStep: [ :s |
			s
				label: 'Assert the history before the save is kept';
				satisfies: [ :anElement | aChangeManager hasUndoableOperations ] ].
	^ scripter
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> shapeOf: aName [
	"Answer what saving from a form must keep, or nil if there is no class or trait with that name"

	| aBehavior |
	aBehavior := Smalltalk globals classOrTraitNamed: aName.
	aBehavior ifNil: [ ^ nil ].
	^ {aBehavior classLayout class name.
		aBehavior slots collect: #definitionString as: Array.
		aBehavior classVarNames asArray.
		aBehavior traitComposition printString.
		aBehavior comment.
		aBehavior classSide slots collect: #definitionString as: Array.
		aBehavior classSide slots collect: [ :each | each read: aBehavior ] as: Array}
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> slotDefinersOf: aName [
	"Answer the slots of the class or trait, on the instance side and on the class side,
	with the name of the class or trait that defines each of them, sorted by slot name"

	| aBehavior sorted |
	aBehavior := aName asClass.
	sorted := [ :someSlots |
		(someSlots collect: [ :each | each name -> each definingClass name ])
			asSortedCollection: [ :a :b | a key <= b key ] ].
	^ {(sorted value: aBehavior slots) asArray.
		(sorted value: (aBehavior classSide allSlots select: [ :each | each definingClass isClassSide ])) asArray}
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> traitCreationFormRefusesOnlyClassSideSlotNamesOfEveryClassSide [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ | aForm |
			self createPackage.
			aForm := GtTraitCreationForm new
					traits: {self newTraitWithSlots};
					yourself.
			self assert: (self is: #('y' 'x') validFor: aForm slotsDescription).
			self assert: (self is: #('cy' 'cx') validFor: aForm classSlotsDescription).
			self assert: (self is: #('name') validFor: aForm classSlotsDescription) not.
			aForm ]
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> traitCreationWithClassSideSlotIsOneUndoableChange [
	"The trait creation form defines the trait with its class-side slots in one change,
	and keeps the undo/redo history"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aForm aName |
			self createPackage.
			self newShapedTrait.
			aName := self classNamed: 'TCreated'.
			aForm := GtTraitCreationForm new
					newClassName: aName;
					slots: {'a'};
					classSlots: {'count'};
					packageAndTagName: self packageAndTagName;
					yourself.
			self
				scripterSaving: aForm
				thenAssert: [ (Smalltalk globals classOrTraitNamed: aName) isTrait
						and: [ (self shapeOf: aName)
								= {#FixedLayout.
										{'#a'}.
										#().
										'{}'.
										''.
										{'#count'}.
										{nil}} ] ]
				afterUndo: [ (Smalltalk globals classOrTraitNamed: aName) isNil ]
				in: aChangeManager ]
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> traitUpdateFormShowsOnlyOwnSlots [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ | aName aForm |
			self createPackage.
			aName := self newTraitUsingTraitWithSlots.
			aForm := GtTraitUpdateForm new onTrait: aName asClass.
			self assert: aForm slots asArray equals: #(#y).
			self assert: aForm classSlots asArray equals: #(#cy).
			self assert: (self is: #('y' 'x') validFor: aForm slotsDescription).
			self assert: (self is: #('cy' 'cx') validFor: aForm classSlotsDescription).
			aForm ]
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> traitUpdateUsingTraitWithSlotsKeepsTraitSlots [
	"Adding a slot to a trait that uses a trait with slots leaves the slots of the used trait to it.
	After the undo only the instance side is compared, as in classUpdateUsingTraitWithSlotsKeepsTraitSlots"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aName aTraitName aForm aShape |
			self createPackage.
			aName := self newTraitUsingTraitWithSlots.
			aTraitName := self classNamed: 'TWithSlots'.
			aShape := self slotDefinersOf: aName.
			aForm := GtTraitUpdateForm new onTrait: aName asClass.
			aForm slots: (aForm slots asOrderedCollection copyWith: 'z').
			self
				scripterSaving: aForm
				thenAssert: [ (self slotDefinersOf: aName)
						= {{#x -> aTraitName. #y -> aName. #z -> aName}.
								{#cx -> (aTraitName , ' classTrait'). #cy -> (aName , ' classTrait')}} ]
				afterUndo: [ (self slotDefinersOf: aName) first = aShape first ]
				in: aChangeManager ]
]

{ #category : #examples }
GtBehaviorFormsUndoExamples >> traitUpdateWithoutEditsKeepsShape [
	"Saving the trait definition form without edits keeps the values of the class-side slots
	and the undo/redo history"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aName aShape |
			self createPackage.
			aName := self newShapedTrait.
			aShape := self shapeOf: aName.
			self assert: aShape last equals: {7}.
			self
				scripterSaving: (GtTraitUpdateForm new onTrait: aName asClass)
				thenAssert: [ (self shapeOf: aName) = aShape ]
				afterUndo: [ (self shapeOf: aName) = aShape ]
				in: aChangeManager ]
]

{ #category : #private }
GtBehaviorFormsUndoExamples >> undo: aChangeManager in: aScripter [
	aScripter
		doStep: [ :s |
			s
				label: 'Undo the save';
				action: [ :anElement | aChangeManager undoChange ] ]
]
