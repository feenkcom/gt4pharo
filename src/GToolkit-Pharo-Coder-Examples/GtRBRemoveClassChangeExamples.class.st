"
I exemplify ${class:GtRBRemoveClassChange}$: removing classes and undoing the removal restores them exactly, also in a hierarchy.
My examples use ${method:GtRefactoryChangeManager class>>#isolatedInstanceDuring:}$, so they do not affect the global undo/redo history.
"
Class {
	#name : #GtRBRemoveClassChangeExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #support }
GtRBRemoveClassChangeExamples >> assertUndoOf: aChange restores: someClassNames removing: someRemovedClassNames in: aChangeManager [
	| before |
	before := self snapshotOf: someClassNames.
	self assert: (someRemovedClassNames allSatisfy: [ :each | Smalltalk includesKey: each ]).

	aChange gtExecuteWithUndo.
	self assert: (someRemovedClassNames noneSatisfy: [ :each | Smalltalk includesKey: each ]).
	self assert: aChangeManager hasUndoableOperations.

	aChangeManager undoChange.
	self assert: (self snapshotOf: someClassNames) equals: before.
	self assert: aChangeManager hasUndoableOperations not.

	aChangeManager redoChange.
	self assert: (someRemovedClassNames noneSatisfy: [ :each | Smalltalk includesKey: each ]).

	^ aChange
]

{ #category : #cleanup }
GtRBRemoveClassChangeExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ].
	environment := nil
]

{ #category : #support }
GtRBRemoveClassChangeExamples >> isolatedChangeManagerDuring: aBlock [
	"Evaluate aBlock with an isolated change manager.
	The dummy classes are removed before the global change manager is restored,
	so that neither the example nor its clean up affects the global undo/redo history"

	^ GtRefactoryChangeManager
		isolatedInstanceDuring: [ :aChangeManager | [ aBlock cull: aChangeManager ] ensure: [ self cleanUp ] ]
]

{ #category : #'examples - remove class' }
GtRBRemoveClassChangeExamples >> removeClassWithCommentAndClassSideSlot [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager | 
			| aClass |
			environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
			aClass := environment anyDummyLeafClass realClass.
			aClass comment: 'A comment to restore'.
			aClass class instanceVariableNames: 'classSideSlot'.
			aClass class compile: 'classSideMethod ^ classSideSlot' classified: 'examples'.

			self
				assertUndoOf: (GtRBRemoveClassChange remove: aClass)
				restores: {aClass name}
				removing: {aClass name}
				in: aChangeManager ]
]

{ #category : #'examples - remove class' }
GtRBRemoveClassChangeExamples >> removeClassWithTraitLayoutAndSharedVariable [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager | 
			| aPackageName aTraitName aClassName |
			environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
			aPackageName := environment anyDummyPackage realPackage name.
			aTraitName := (aPackageName copyReplaceAll: '-' with: '') , 'TExampleTrait'.
			aClassName := (aPackageName copyReplaceAll: '-' with: '') , 'ExampleClass'.
			(Trait << aTraitName asSymbol package: aPackageName) install
				compile: 'traitMethod ^ 1'
				classified: 'examples'.
			(Object << aClassName asSymbol
				layout: VariableLayout;
				traits: {Smalltalk at: aTraitName asSymbol};
				slots: {#aSlot};
				sharedVariables: {#ASharedVariable};
				tag: 'ExampleTag';
				package: aPackageName) install
				compile: 'localMethod ^ ASharedVariable'
				classified: 'examples'.

			self
				assertUndoOf: (GtRBRemoveClassChange remove: (Smalltalk at: aClassName asSymbol))
				restores: {aClassName asSymbol}
				removing: {aClassName asSymbol}
				in: aChangeManager ]
]

{ #category : #'examples - remove class' }
GtRBRemoveClassChangeExamples >> removeHierarchy [
	"Subclasses are removed first, the undo restores superclasses first"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager | 
			| aRootClass someClassNames |
			environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 3.
			aRootClass := environment anyDummyRootClass realClass.
			aRootClass comment: 'A root comment to restore'.
			someClassNames := aRootClass withAllSubclasses collect: #name as: Array.

			self
				assertUndoOf: (GtCoderRemoveClassesPreviewStencil
						removeChangeForClasses: aRootClass withAllSubclasses
						named: 'Remove hierarchy')
				restores: someClassNames
				removing: someClassNames
				in: aChangeManager ]
]

{ #category : #'examples - remove class' }
GtRBRemoveClassChangeExamples >> removeTrait [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager | 
			| aPackageName aTraitName |
			environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
			aPackageName := environment anyDummyPackage realPackage name.
			aTraitName := ((aPackageName copyReplaceAll: '-' with: '') , 'TExampleTrait') asSymbol.
			(Trait << aTraitName package: aPackageName) install
				compile: 'traitMethod ^ 1'
				classified: 'examples'.

			self
				assertUndoOf: (GtRBRemoveClassChange remove: (Smalltalk at: aTraitName))
				restores: {aTraitName}
				removing: {aTraitName}
				in: aChangeManager ]
]

{ #category : #support }
GtRBRemoveClassChangeExamples >> snapshotOf: someClassNames [
	"Answer what the undo must restore: the definitions, comments, class-side slots and local methods"

	^ someClassNames
		collect: [ :eachName | 
			| aClass |
			aClass := Smalltalk at: eachName ifAbsent: [ nil ].
			eachName
				-> (aClass
						ifNil: [ #missing ]
						ifNotNil: [ {aClass isObsolete.
								aClass superclass ifNil: [ false ] ifNotNil: [ :aSuperclass | aSuperclass isObsolete ].
								aClass definitionString.
								aClass comment.
								aClass class instVarNames.
								({aClass. aClass class}
									collect: [ :eachBehavior | 
										(eachBehavior localSelectors asSortedCollection asArray
											collect: [ :eachSelector | 
												eachSelector
													-> {eachBehavior sourceCodeAt: eachSelector.
															(eachBehavior >> eachSelector) protocolName} ]) ])} ]) ]
		as: Array
]

{ #category : #'examples - remove class' }
GtRBRemoveClassChangeExamples >> undoKeepsNoRemovedClass [
	"The undo is built from definitions as strings and class names, so it keeps no class objects alive"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ 
			| aRootClass anUndoChange |
			environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 2.
			aRootClass := environment anyDummyRootClass realClass.
			aRootClass class instanceVariableNames: 'classSideSlot'.
			anUndoChange := (GtRBRemoveClassChange remove: aRootClass) asUndoOperation.

			self
				assert: (anUndoChange gtAllChanges count: [ :each | each isKindOf: GtRBAddClassChange ])
				equals: 2.
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
