"
I exemplify ${class:GtRBChangeSuperclassChange}$: changing the superclass of a class keeps its layout, the kinds of its slots, its class-side slots and their values, and undo and redo refer to the classes by name.
My examples use ${method:GtRefactoryChangeManager class>>#isolatedInstanceDuring:}$, so they do not affect the global undo/redo history.
"
Class {
	#name : #GtRBChangeSuperclassChangeExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #support }
GtRBChangeSuperclassChangeExamples >> assertSuperclassOf: aClassName is: aSuperclassName [
	"The superclass must be the current class with that name, on both sides"

	| aClass aSuperclass |
	aClass := Smalltalk at: aClassName.
	aSuperclass := Smalltalk at: aSuperclassName.
	self assert: aClass superclass == aSuperclass.
	self assert: aClass classSide superclass == aSuperclass classSide
]

{ #category : #'examples - change' }
GtRBChangeSuperclassChangeExamples >> changeSuperclassKeepsShape [
	"Only the superclass changes. The layout, the kinds of slots, the class-side slots
	and the value of a class-side slot are kept, also by undo and redo"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aClassName aShape |
			aClassName := self newShapedClass.
			aShape := self shapeOf: aClassName.

			(GtRBChangeSuperclassChange
				change: aClassName
				toBeUnder: (self classNamed: 'OtherParent')) gtExecuteWithUndo.
			self assertSuperclassOf: aClassName is: (self classNamed: 'OtherParent').
			self assert: (self shapeOf: aClassName) equals: aShape.

			2
				timesRepeat: [
					aChangeManager undoChange.
					self assertSuperclassOf: aClassName is: (self classNamed: 'Parent').
					self assert: (self shapeOf: aClassName) equals: aShape.

					aChangeManager redoChange.
					self assertSuperclassOf: aClassName is: (self classNamed: 'OtherParent').
					self assert: (self shapeOf: aClassName) equals: aShape ].

			aShape ]
]

{ #category : #'examples - refactorings' }
GtRBChangeSuperclassChangeExamples >> changeSuperclassRefactoringKeepsShape [
	"The refactoring records a single change of the superclass,
	instead of defining the class again from the names that the model knows"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aClassName aShape aRefactoring someChanges |
			aClassName := self newShapedClass.
			aShape := self shapeOf: aClassName.

			aRefactoring := GtRBChangeSuperclassRefactoring
					changeSuperclassOf: aClassName
					to: (self classNamed: 'OtherParent').
			aRefactoring primitiveExecute.
			someChanges := aRefactoring model changes gtAllChanges.
			self assert: someChanges size equals: 1.
			self
				assert: someChanges first
				equals: (GtRBChangeSuperclassChange
						change: aClassName
						toBeUnder: (self classNamed: 'OtherParent')).
			self
				assert: (aRefactoring model classNamed: aClassName) superclass name
				equals: (self classNamed: 'OtherParent').

			aRefactoring model changes gtExecuteWithUndo.
			self assertSuperclassOf: aClassName is: (self classNamed: 'OtherParent').
			self assert: (self shapeOf: aClassName) equals: aShape.

			aChangeManager undoChange.
			self assertSuperclassOf: aClassName is: (self classNamed: 'Parent').
			self assert: (self shapeOf: aClassName) equals: aShape.

			aRefactoring ]
]

{ #category : #support }
GtRBChangeSuperclassChangeExamples >> classNamed: aString [
	"Answer a class name in the dummy package, so that the class is removed with it"

	^ ((self packageName copyReplaceAll: '-' with: '') , aString) asSymbol
]

{ #category : #cleanup }
GtRBChangeSuperclassChangeExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ].
	environment := nil
]

{ #category : #support }
GtRBChangeSuperclassChangeExamples >> isolatedChangeManagerDuring: aBlock [
	"Evaluate aBlock with an isolated change manager.
	The dummy classes are removed before the global change manager is restored,
	so that neither the example nor its clean up affects the global undo/redo history"

	^ GtRefactoryChangeManager
		isolatedInstanceDuring: [ :aChangeManager | [ aBlock cull: aChangeManager ] ensure: [ self cleanUp ] ]
]

{ #category : #support }
GtRBChangeSuperclassChangeExamples >> newShapedClass [
	"Answer the name of a class under Parent with a variable layout, a weak slot,
	class-side slots of two kinds and a value in a class-side slot.
	OtherParent is another class it can be moved under"

	| aClass |
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
	#('Parent' 'OtherParent')
		do: [ :each | (Object << (self classNamed: each) package: self packageName) install ].
	aClass := ((Smalltalk at: (self classNamed: 'Parent')) << (self classNamed: 'Shaped')
			layout: VariableLayout;
			slots: {#a. #w => WeakSlot};
			package: self packageName) install.
	aClass classSide slots: {#count. #cache => WeakSlot}.
	(aClass classSide slotNamed: #count) write: 7 to: aClass.
	^ aClass name
]

{ #category : #support }
GtRBChangeSuperclassChangeExamples >> packageName [
	^ environment anyDummyPackage realPackage name
]

{ #category : #'examples - preview' }
GtRBChangeSuperclassChangeExamples >> previewShowsDefinitionWithNewSuperclass [
	"The refactoring preview shows the change as a diff of the class definition with the new superclass,
	and names the new superclass in its title"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [
			| aClassName aChange aDiff |
			aClassName := self newShapedClass.
			aChange := GtRBChangeSuperclassChange
					change: aClassName
					toBeUnder: (self classNamed: 'OtherParent').
			aDiff := aChange gtDiffChange.

			self assert: (aDiff from includesSubstring: (self classNamed: 'Parent')).
			self
				assert: (aDiff to copyReplaceAll: (self classNamed: 'OtherParent') with: (self classNamed: 'Parent'))
				equals: aDiff from.
			self
				assert: aChange displayString
				equals: 'Change superclass of ' , aClassName , ' to ' , (self classNamed: 'OtherParent').
			self assert: (GtUserActivatableChange fromChange: aChange) hasDiffChange.

			aDiff ]
]

{ #category : #'examples - change' }
GtRBChangeSuperclassChangeExamples >> redoUnderSuperclassDefinedAgain [
	"Undo moves the class back and then removes the new superclass, redo defines it again.
	The class is then moved under the superclass that is defined again, not under the removed one"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aClassName aNewSuperclassName aShape |
			aClassName := self newShapedClass.
			aShape := self shapeOf: aClassName.
			aNewSuperclassName := self classNamed: 'NewParent'.
			(GtRBAddClassChange
				definitionString: 'Object << #' , aNewSuperclassName , ' package: '
						, self packageName printString) gtExecuteWithUndo.
			(GtRBChangeSuperclassChange change: aClassName toBeUnder: aNewSuperclassName)
				gtExecuteWithUndo.

			aChangeManager
				undoChange;
				undoChange.
			self assert: (Smalltalk includesKey: aNewSuperclassName) not.
			self assertSuperclassOf: aClassName is: (self classNamed: 'Parent').

			aChangeManager
				redoChange;
				redoChange.
			self assertSuperclassOf: aClassName is: aNewSuperclassName.
			self assert: (self shapeOf: aClassName) equals: aShape.

			aShape ]
]

{ #category : #'examples - refactorings' }
GtRBChangeSuperclassChangeExamples >> reparentClassesInNamespace [
	"Moving classes under another class in a GT namespace records a change of their superclass
	that refers to the classes by name"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [
			| aClassName aModel someChanges |
			aClassName := self newShapedClass.
			aModel := GtRBNamespace new.
			aModel
				reparentClasses: {aModel classNamed: aClassName}
				to: (aModel classNamed: (self classNamed: 'OtherParent')).

			someChanges := aModel changes changes.
			self assert: someChanges size equals: 1.
			self
				assert: someChanges first
				equals: (GtRBChangeSuperclassChange
						change: aClassName
						toBeUnder: (self classNamed: 'OtherParent')).

			aModel ]
]

{ #category : #support }
GtRBChangeSuperclassChangeExamples >> shapeOf: aClassName [
	"Answer what a change of the superclass must keep"

	| aClass |
	aClass := Smalltalk at: aClassName.
	^ {aClass classLayout class name.
		aClass slots collect: #definitionString as: Array.
		aClass classSide slots collect: #definitionString as: Array.
		(aClass classSide slotNamed: #count) read: aClass}
]

{ #category : #'examples - change' }
GtRBChangeSuperclassChangeExamples >> undoRefersToClassesByName [
	"The undo changes the superclass back by name, and keeps no class as an object"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [
			| aClassName anUndoChange |
			aClassName := self newShapedClass.
			anUndoChange := (GtRBChangeSuperclassChange
					change: aClassName
					toBeUnder: (self classNamed: 'OtherParent')) asUndoOperation.

			self
				assert: anUndoChange
				equals: (GtRBChangeSuperclassChange
						change: aClassName
						toBeUnder: (self classNamed: 'Parent')).
			anUndoChange class allInstVarNames
				do: [ :eachName |
					| aValue |
					aValue := anUndoChange instVarNamed: eachName.
					self assert: aValue isBehavior not.
					self assert: (aValue isKindOf: ShiftClassBuilder) not ].

			anUndoChange ]
]
