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

	self assert: (aChange isKindOf: RBRemoveClassChange).
	self assert: aChange changeClassName equals: aClass name.
	self assert: (Smalltalk includesKey: aClass name).

	^ aStencil
]

{ #category : #support }
GtCoderRemoveClassPreviewStencilExamples >> newRemoveClassesStencil [
	| someClasses aStencil aChange |
	environment := GtPharoDummiesGenerator withPackages: 1 classes: 3.

	someClasses := GtPharoClassGroup
			withAll: environment anyDummyPackage realPackage definedClasses asArray.

	aStencil := GtCoderRemoveClassesPreviewStencil new classesToRemove: someClasses.
	aChange := aStencil removeChange.

	self assert: (aChange isKindOf: RBCompositeRefactoryChange).
	self assert: aChange changes size equals: 3.
	self
		assert: (aChange changes collect: #changeClassName) asSet
		equals: (someClasses collect: #name) asSet.
	self assert: (someClasses allSatisfy: [ :each | Smalltalk includesKey: each name ]).

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
