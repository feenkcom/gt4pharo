"
I exemplify the undo and redo of ${class:GtRBAddClassChange}$: classes are referred to by name, so undoing and redoing class definitions also works when classes are removed and restored in between.
My examples use ${method:GtRefactoryChangeManager class>>#isolatedInstanceDuring:}$, so they do not affect the global undo/redo history.
"
Class {
	#name : #GtRBAddClassChangeUndoExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #support }
GtRBAddClassChangeUndoExamples >> classNamed: aString [
	"Answer a class name in the dummy package, so that the class is removed with it"

	^ ((self packageName copyReplaceAll: '-' with: '') , aString) asSymbol
]

{ #category : #cleanup }
GtRBAddClassChangeUndoExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ].
	environment := nil
]

{ #category : #'examples - namespace' }
GtRBAddClassChangeUndoExamples >> convertToSiblingUndoRedo [
	"The refactoring defines the new class and moves the subclasses under it.
	Redoing it after an undo moves them under the class created again"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aRootClass someSubclassNames aNewClassName aRefactoring applied |
			self newEnvironment.
			aRootClass := environment anyDummyRootClass realClass.
			someSubclassNames := {self classNamed: 'SubclassOne'.
					self classNamed: 'SubclassTwo'}.
			someSubclassNames
				do: [ :eachName | (aRootClass << eachName package: self packageName) install ].
			aNewClassName := self classNamed: 'Sibling'.

			aRefactoring := GtChildrenToSiblingsRefactoring
					name: aNewClassName
					class: aRootClass
					subclasses: aRootClass subclasses.
			aRefactoring primitiveExecute.
			self
				assert: (aRefactoring model changes gtAllChanges
						count: [ :each | each isKindOf: GtRBChangeSuperclassChange ])
				equals: someSubclassNames size.
			aRefactoring model changes gtExecuteWithUndo.
			applied := self snapshotOf: {aNewClassName} , someSubclassNames.
			self
				assert: (someSubclassNames
						allSatisfy: [ :each | (Smalltalk at: each) superclass == (Smalltalk at: aNewClassName) ]).

			2
				timesRepeat: [
					aChangeManager undoChange.
					self assert: (Smalltalk includesKey: aNewClassName) not.
					self
						assert: (someSubclassNames
								allSatisfy: [ :each | (Smalltalk at: each) superclass == aRootClass ]).

					aChangeManager redoChange.
					self assert: (self snapshotOf: {aNewClassName} , someSubclassNames) equals: applied ].

			applied ]
]

{ #category : #'examples - undo and redo' }
GtRBAddClassChangeUndoExamples >> createClassAndSubclassUndoRedo [
	"Undoing removes the classes, redoing creates them again.
	The subclass must be created under the restored class, not the removed one"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager | 
			| aName aSubclassName created |
			self newEnvironment.
			aName := self classNamed: 'NewClass'.
			aSubclassName := self classNamed: 'NewSubclass'.
			(GtRBAddClassChange
				definitionString: (self definitionOf: aName superclass: 'Object' slots: '{ #a }'))
				gtExecuteWithUndo.
			(GtRBAddClassChange
				definitionString: (self definitionOf: aSubclassName superclass: aName slots: '{ #b }'))
				gtExecuteWithUndo.
			created := self snapshotOf: {aName. aSubclassName}.

			2
				timesRepeat: [ 
					aChangeManager undoChange; undoChange.
					self assert: (Smalltalk includesKey: aSubclassName) not.
					self assert: (Smalltalk includesKey: aName) not.

					aChangeManager redoChange; redoChange.
					self assert: (self snapshotOf: {aName. aSubclassName}) equals: created ].

			created ]
]

{ #category : #support }
GtRBAddClassChangeUndoExamples >> definitionOf: aClassName superclass: aSuperclassName slots: aSlotsString [
	^ aSuperclassName , ' << #' , aClassName , ' slots: ' , aSlotsString , '; package: '
		, self packageName storeString
]

{ #category : #support }
GtRBAddClassChangeUndoExamples >> isolatedChangeManagerDuring: aBlock [
	"Evaluate aBlock with an isolated change manager.
	The dummy classes are removed before the global change manager is restored,
	so that neither the example nor its clean up affects the global undo/redo history"

	^ GtRefactoryChangeManager
		isolatedInstanceDuring: [ :aChangeManager | [ aBlock cull: aChangeManager ] ensure: [ self cleanUp ] ]
]

{ #category : #support }
GtRBAddClassChangeUndoExamples >> newEnvironment [
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
	^ environment
]

{ #category : #support }
GtRBAddClassChangeUndoExamples >> packageName [
	^ environment anyDummyPackage realPackage name
]

{ #category : #'examples - undo and redo' }
GtRBAddClassChangeUndoExamples >> redefineSubclassUndoRedo [
	"The redefinition is redone after both classes are removed and created again"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager | 
			| aName aSubclassName redefined |
			self newEnvironment.
			aName := self classNamed: 'NewClass'.
			aSubclassName := self classNamed: 'NewSubclass'.
			(GtRBAddClassChange
				definitionString: (self definitionOf: aName superclass: 'Object' slots: '{ #a }'))
				gtExecuteWithUndo.
			(GtRBAddClassChange
				definitionString: (self definitionOf: aSubclassName superclass: aName slots: '{ #b }'))
				gtExecuteWithUndo.
			(GtRBAddClassChange
				definitionString: (self
						definitionOf: aSubclassName
						superclass: aName
						slots: '{ #b . #c }')) gtExecuteWithUndo.
			redefined := self snapshotOf: {aName. aSubclassName}.
			self assert: (Smalltalk at: aSubclassName) slotNames equals: #(#b #c).

			3 timesRepeat: [ aChangeManager undoChange ].
			self assert: (Smalltalk includesKey: aName) not.

			3 timesRepeat: [ aChangeManager redoChange ].
			self assert: (self snapshotOf: {aName. aSubclassName}) equals: redefined.

			redefined ]
]

{ #category : #'examples - undo and redo' }
GtRBAddClassChangeUndoExamples >> redefinitionRestoresLayoutAndClassSideSlots [
	"An old-style definition drops the class-side slots, special slots and the layout.
	The undo restores them"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager |
			| aName aClass before |
			self newEnvironment.
			aName := self classNamed: 'VariableClass'.
			aClass := (Object << aName
					layout: VariableLayout;
					slots: {#a. #b => WeakSlot};
					package: self packageName) install.
			aClass classSide slots: {#one => WeakSlot. #two}.
			before := self snapshotOf: {aName}.

			(GtRBAddClassChange
				definitionString: 'Object subclass: #' , aName
						, ' instanceVariableNames: ''a'' classVariableNames: '''' poolDictionaries: '''' category: '
						, self packageName storeString) gtExecuteWithUndo.
			self assert: (Smalltalk at: aName) classSide slots isEmpty.
			self assert: (Smalltalk at: aName) slotNames equals: #(#a).

			aChangeManager undoChange.
			self assert: (self snapshotOf: {aName}) equals: before.

			aChangeManager redoChange.
			self assert: (Smalltalk at: aName) slotNames equals: #(#a).

			before ]
]

{ #category : #support }
GtRBAddClassChangeUndoExamples >> snapshotOf: someClassNames [
	"Answer the definitions and class-side slots of the classes,
	and whether their superclasses are the current classes with their names"

	^ someClassNames
		collect: [ :eachName | 
			| aClass |
			aClass := Smalltalk at: eachName ifAbsent: [ nil ].
			eachName
				-> (aClass
						ifNil: [ #missing ]
						ifNotNil: [ {aClass isObsolete.
								aClass superclass
									== (Smalltalk at: aClass superclass name ifAbsent: [ nil ]).
								aClass definitionString.
								aClass classSide slots collect: #definitionString as: Array} ]) ]
		as: Array
]

{ #category : #'examples - undo and redo' }
GtRBAddClassChangeUndoExamples >> undoOfNewClassRemovesIt [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ 
			| aClassName anUndoChange |
			self newEnvironment.
			aClassName := self classNamed: 'NewClass'.
			anUndoChange := (GtRBAddClassChange
					definitionString: (self definitionOf: aClassName superclass: 'Object' slots: '{ #a }'))
					asUndoOperation.

			self assert: (anUndoChange isKindOf: GtRBRemoveClassChange).
			self assert: anUndoChange changeClassName equals: aClassName.

			anUndoChange ]
]

{ #category : #'examples - undo and redo' }
GtRBAddClassChangeUndoExamples >> undoOfRedefinitionKeepsNoClass [
	"The undo of a redefinition restores the definition from a string that includes the class-side slots,
	so it keeps neither the class nor its superclass as objects"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [
			| aClass anUndoChange |
			self newEnvironment.
			aClass := environment anyDummyRootClass realClass.
			aClass classSide slots: {#aClassSideSlot}.
			anUndoChange := (GtRBAddClassChange
					definitionString: (self
							definitionOf: aClass name
							superclass: 'Object'
							slots: '{}')) asUndoOperation.

			self
				assert: (anUndoChange gtAllChanges collect: #class) asArray
				equals: {GtRBAddClassChange}.
			self
				assert: (anUndoChange gtAllChanges first definitionString
						includesSubstring: 'classSlots: {#aClassSideSlot}').
			anUndoChange gtAllChanges
				do: [ :eachChange |
					eachChange class allInstVarNames
						do: [ :eachName |
							| aValue |
							aValue := eachChange instVarNamed: eachName.
							self assert: aValue isBehavior not.
							self assert: (aValue isKindOf: ShiftClassBuilder) not ] ].

			anUndoChange ]
]
