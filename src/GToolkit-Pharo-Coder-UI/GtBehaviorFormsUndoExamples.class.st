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
GtBehaviorFormsUndoExamples >> isolatedChangeManagerDuring: aBlock [
	"Evaluate aBlock with an isolated change manager.
	The dummy classes are removed before the global change manager is restored,
	so that neither the example nor its clean up affects the global undo/redo history"

	^ GtRefactoryChangeManager
		isolatedInstanceDuring: [ :aChangeManager | [ aBlock cull: aChangeManager ] ensure: [ self cleanUp ] ]
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
