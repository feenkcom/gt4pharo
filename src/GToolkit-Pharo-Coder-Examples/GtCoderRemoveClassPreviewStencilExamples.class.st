"
I exemplify ${class:GtCoderRemoveClassPreviewStencil}$ and ${class:GtCoderRemoveClassesPreviewStencil}$.
The removal of one or several classes must be undoable in one step through ${class:GtRefactoryChangeManager}$.
"
Class {
	#name : #GtCoderRemoveClassPreviewStencilExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Coders'
}

{ #category : #support }
GtCoderRemoveClassPreviewStencilExamples >> assertHierarchyIsRestored: someClassesWithSuperclassNames [
	someClassesWithSuperclassNames
		do: [ :each | 
			| aClass |
			aClass := Smalltalk at: each key ifAbsent: [ nil ].
			self assert: aClass notNil.
			self assert: aClass isObsolete not.
			self assert: aClass superclass name equals: each value.
			self assert: aClass superclass isObsolete not ]
]

{ #category : #support }
GtCoderRemoveClassPreviewStencilExamples >> assertIsRemovedInLeavesFirstOrder: aChange [
	"Subclasses must be removed before their superclasses"

	| depths |
	depths := aChange changes
			collect: [ :each | (Smalltalk at: each changeClassName) allSuperclasses size ].
	self assert: (depths asArray = (depths asArray sorted: [ :a :b | a >= b ]))
]

{ #category : #cleanup }
GtCoderRemoveClassPreviewStencilExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ].
	environment := nil
]

{ #category : #support }
GtCoderRemoveClassPreviewStencilExamples >> isolatedChangeManagerDuring: aBlock [
	^ GtRefactoryChangeManager
			isolatedInstanceDuring: [ :aChangeManager | 
				[ aBlock cull: aChangeManager ] 
					ensure: [ self cleanUp ] ]
]

{ #category : #support }
GtCoderRemoveClassPreviewStencilExamples >> newRemoveClassStencil [
	| aClass aStencil aChange |
	environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 1.
	aClass := environment anyDummyLeafClass realClass.

	aStencil := GtCoderRemoveClassPreviewStencil new classToRemove: aClass.
	aChange := aStencil removeChange.

	self assert: (aChange isKindOf: GtRBRemoveClassChange).
	self assert: aChange changeClassName equals: aClass name.
	self assert: aStencil hasSubclasses not.
	self assert: (Smalltalk includesKey: aClass name).

	^ aStencil
]

{ #category : #support }
GtCoderRemoveClassPreviewStencilExamples >> newRemoveClassesStencil [
	| someClasses aStencil aChange |
	environment := GtPharoDummiesGenerator withPackages: 1 classes: 3.
	"The classes tree passes a sequenceable collection of the selected classes"
	someClasses := GtPharoClassGroup
			withAll: environment anyDummyPackage realPackage definedClasses asArray.

	aStencil := GtCoderRemoveClassesPreviewStencil new classesToRemove: someClasses.
	aChange := aStencil removeChange.

	self assert: (aChange isKindOf: RBCompositeRefactoryChange).
	self assert: aChange changes size equals: 3.
	self assert: (aChange changes allSatisfy: [ :each | each isKindOf: GtRBRemoveClassChange ]).
	self
		assert: (aChange changes collect: #changeClassName) asSet
		equals: (someClasses collect: #name) asSet.
	self assert: aStencil hasSubclassesNotSelected not.
	self assert: (someClasses allSatisfy: [ :each | Smalltalk includesKey: each name ]).

	^ aStencil
]

{ #category : #support }
GtCoderRemoveClassPreviewStencilExamples >> newRemoveClassesWithSubclassesNotSelectedStencil [
	"Two hierarchies of two classes each, of which only the root classes are selected.
	The second root class references the unselected subclass of the first one, which is removed with it"

	| someClasses aStencil |
	environment := GtPharoDummiesGenerator withPackages: 2 classHierarchy: 2.
	(self rootClassInPackageAt: 2)
		compile: 'referenceToRemovedSubclass ^ ' , (self rootClassInPackageAt: 1) subclasses first name
		classified: 'examples'.
	someClasses := GtPharoClassGroup
			withAll: {self rootClassInPackageAt: 1.
					self rootClassInPackageAt: 2}.

	aStencil := GtCoderRemoveClassesPreviewStencil new classesToRemove: someClasses.

	self assert: aStencil hasSubclassesNotSelected.
	self assert: aStencil subclassesNotSelected size equals: 2.
	self assert: aStencil classesToRemoveWithSubclasses size equals: 4.
	self assert: aStencil selectedClassesExternalReferences isEmpty.
	self assert: aStencil subclassesExternalReferences isEmpty.
	self
		assert: aStencil subclassesWithReferencesDescription
		equals: '2 subclasses with 0 references'.

	^ aStencil
]

{ #category : #support }
GtCoderRemoveClassPreviewStencilExamples >> newRemoveHierarchyStencil [
	"A hierarchy of three classes. A class in another package references the root class and the last subclass,
	and the last subclass references the root class"

	| aRootClass aLastSubclass anotherClass aStencil |
	environment := GtPharoDummiesGenerator withPackages: 2 classHierarchy: 3.
	aRootClass := self rootClassInPackageAt: 1.
	aLastSubclass := aRootClass allSubclasses last.
	anotherClass := self rootClassInPackageAt: 2.
	anotherClass
		compile: 'referenceToRemovedClass ^ ' , aRootClass name
		classified: 'examples'.
	anotherClass
		compile: 'referenceToRemovedSubclass ^ ' , aLastSubclass name
		classified: 'examples'.
	aLastSubclass
		compile: 'referenceFromRemovedSubclass ^ ' , aRootClass name
		classified: 'examples'.

	aStencil := GtCoderRemoveClassPreviewStencil new classToRemove: aRootClass.

	self assert: aStencil hasSubclasses.
	self assert: aStencil subclassesToRemove size equals: 2.
	self
		assert: (aStencil classExternalReferences collect: #selector) asArray
		equals: #(#referenceToRemovedClass).
	self
		assert: (aStencil subclassesExternalReferences collect: #selector) asArray
		equals: #(#referenceToRemovedSubclass).
	self
		assert: aStencil subclassesWithReferencesDescription
		equals: '2 subclasses with 1 reference'.

	^ aStencil
]

{ #category : #'examples - remove class' }
GtCoderRemoveClassPreviewStencilExamples >> removeClassIsUndoable [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager | 
			| aStencil aClass aClassName instanceSelectors classSelectors |
			aStencil := self newRemoveClassStencil.
			aClass := aStencil classToRemove.
			aClassName := aClass name.
			instanceSelectors := aClass selectors asSortedCollection asArray.
			classSelectors := aClass class selectors asSortedCollection asArray.

			aStencil removeClass.
			self assert: (Smalltalk includesKey: aClassName) not.
			self assert: aChangeManager hasUndoableOperations.

			aChangeManager undoChange.
			self assert: (Smalltalk includesKey: aClassName).
			self
				assert: (Smalltalk at: aClassName) selectors asSortedCollection asArray
				equals: instanceSelectors.
			self
				assert: (Smalltalk at: aClassName) class selectors asSortedCollection asArray
				equals: classSelectors.

			aChangeManager redoChange.
			self assert: (Smalltalk includesKey: aClassName) not.

			aStencil ]
]

{ #category : #'examples - remove class' }
GtCoderRemoveClassPreviewStencilExamples >> removeClassStencil [
	<gtExample>
	^ self isolatedChangeManagerDuring: [ self newRemoveClassStencil ]
]

{ #category : #'examples - remove classes' }
GtCoderRemoveClassPreviewStencilExamples >> removeClassesIsUndoableInOneStep [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager | 
			| aStencil someClassNames |
			aStencil := self newRemoveClassesStencil.
			someClassNames := aStencil classesToRemove collect: #name as: Array.

			aStencil removeClasses.
			self assert: (someClassNames noneSatisfy: [ :each | Smalltalk includesKey: each ]).
			self assert: aChangeManager hasUndoableOperations.

			aChangeManager undoChange.
			self assert: (someClassNames allSatisfy: [ :each | Smalltalk includesKey: each ]).
			self assert: aChangeManager hasUndoableOperations not.

			aChangeManager redoChange.
			self assert: (someClassNames noneSatisfy: [ :each | Smalltalk includesKey: each ]).

			aStencil ]
]

{ #category : #'examples - remove classes' }
GtCoderRemoveClassPreviewStencilExamples >> removeClassesStencil [
	<gtExample>
	^ self isolatedChangeManagerDuring: [ self newRemoveClassesStencil ]
]

{ #category : #'examples - remove classes' }
GtCoderRemoveClassPreviewStencilExamples >> removeClassesWithSubclassesIsUndoable [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager | 
			| aStencil someClassesWithSuperclassNames |
			aStencil := self newRemoveClassesWithSubclassesNotSelectedStencil.
			someClassesWithSuperclassNames := (aStencil classesToRemove asArray
					, aStencil subclassesNotSelected)
					collect: [ :each | each name -> each superclass name ].

			aStencil removeWithSubclasses.
			self
				assert: (someClassesWithSuperclassNames
						noneSatisfy: [ :each | Smalltalk includesKey: each key ]).

			aChangeManager undoChange.
			self assertHierarchyIsRestored: someClassesWithSuperclassNames.
			self assert: aChangeManager hasUndoableOperations not.

			aChangeManager redoChange.
			self
				assert: (someClassesWithSuperclassNames
						noneSatisfy: [ :each | Smalltalk includesKey: each key ]).

			aStencil ]
]

{ #category : #'examples - remove classes' }
GtCoderRemoveClassPreviewStencilExamples >> removeClassesWithSubclassesNotSelectedStencil [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ 
			| aStencil aChange |
			aStencil := self newRemoveClassesWithSubclassesNotSelectedStencil.
			aChange := aStencil removeWithSubclassesChange.

			self assert: aChange changes size equals: 4.
			self
				assert: (aChange changes collect: #changeClassName) asSet
				equals: ((aStencil classesToRemove asArray , aStencil subclassesNotSelected)
						collect: #name) asSet.
			self assertIsRemovedInLeavesFirstOrder: aChange.

			aStencil ]
]

{ #category : #'examples - remove hierarchy' }
GtCoderRemoveClassPreviewStencilExamples >> removeHierarchyIsUndoable [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager | 
			| aStencil aRootName someClassesWithSuperclassNames |
			aStencil := self newRemoveHierarchyStencil.
			aRootName := aStencil classToRemove name.
			someClassesWithSuperclassNames := aStencil classToRemove withAllSubclasses
					collect: [ :each | each name -> each superclass name ]
					as: Array.

			"The root class is referenced from another package, which does not prevent the removal"
			aStencil removeHierarchy.
			self
				assert: (someClassesWithSuperclassNames
						noneSatisfy: [ :each | Smalltalk includesKey: each key ]).
			self assert: aChangeManager hasUndoableOperations.

			aChangeManager undoChange.
			self assertHierarchyIsRestored: someClassesWithSuperclassNames.
			self
				assert: (self rootClassInPackageAt: 2) new referenceToRemovedClass
					== (Smalltalk at: aRootName).
			self assert: aChangeManager hasUndoableOperations not.

			aChangeManager redoChange.
			self
				assert: (someClassesWithSuperclassNames
						noneSatisfy: [ :each | Smalltalk includesKey: each key ]).

			aStencil ]
]

{ #category : #'examples - remove hierarchy' }
GtCoderRemoveClassPreviewStencilExamples >> removeHierarchyStencil [
	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ 
			| aStencil aChange |
			aStencil := self newRemoveHierarchyStencil.
			aChange := aStencil removeHierarchyChange.

			self assert: (aChange isKindOf: RBCompositeRefactoryChange).
			self
				assert: (aChange changes collect: #changeClassName) asSet
				equals: (aStencil classToRemove withAllSubclasses collect: #name) asSet.
			self assert: aChange changes last changeClassName equals: aStencil classToRemove name.
			self assertIsRemovedInLeavesFirstOrder: aChange.

			aStencil ]
]

{ #category : #'examples - remove classes' }
GtCoderRemoveClassPreviewStencilExamples >> removeSelectedSuperclassAndSubclassIsUndoable [
	"The superclass is selected before its subclass, but the subclass must still be removed first"

	<gtExample>
	^ self
		isolatedChangeManagerDuring: [ :aChangeManager | 
			| aRootClass aSubclass aStencil someClassesWithSuperclassNames |
			environment := GtPharoDummiesGenerator withPackages: 1 classHierarchy: 2.
			aRootClass := self rootClassInPackageAt: 1.
			aSubclass := aRootClass subclasses first.
			someClassesWithSuperclassNames := {aRootClass name -> aRootClass superclass name.
					aSubclass name -> aSubclass superclass name}.

			aStencil := GtCoderRemoveClassesPreviewStencil new
					classesToRemove: (GtPharoClassGroup withAll: {aRootClass. aSubclass}).
			self assert: aStencil hasSubclassesNotSelected not.
			self assert: aStencil removeChange changes first changeClassName equals: aSubclass name.

			aStencil removeClasses.
			self
				assert: (someClassesWithSuperclassNames
						noneSatisfy: [ :each | Smalltalk includesKey: each key ]).

			aChangeManager undoChange.
			self assertHierarchyIsRestored: someClassesWithSuperclassNames.

			aStencil ]
]

{ #category : #support }
GtCoderRemoveClassPreviewStencilExamples >> rootClassInPackageAt: anIndex [
	^ ((environment dummyPackages asArray at: anIndex) dummyClasses
		detect: [ :each | each realClass superclass == Object ]) realClass
]
