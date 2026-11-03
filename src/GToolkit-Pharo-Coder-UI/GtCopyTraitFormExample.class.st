"
I exemplify ${class:GtCopyTraitForm}$.
My examples use ${method:GtRefactoryChangeManager class>>#isolatedInstanceDuring:}$, so they do not affect the global undo/redo history.
"
Class {
	#name : #GtCopyTraitFormExample,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-UI-Examples'
}

{ #category : #accessing }
GtCopyTraitFormExample >> copiedTraitName [
	^ 'TGtCopyTraitFormExampleCopy'
]

{ #category : #examples }
GtCopyTraitFormExample >> copyTraitCanBeUndone [
	"Copying a trait defines the copy and its methods through one recorded change:
	one undo removes the copy and keeps the changes recorded before it.
	The copy keeps the slots, the class-side slots and the trait composition,
	and gets only the methods that the copied trait defines itself"

	<gtExample>
	^ GtRefactoryChangeManager
		isolatedInstanceDuring: [ :aChangeManager |
			| aForm aCopy |
			[ aForm := GtCopyTraitForm new for: self defineSourceTraits.
			aForm newClassName: self copiedTraitName.
			aCopy := aForm copyTrait.
			self assert: aCopy isTrait.
			self assert: aCopy name asString equals: self copiedTraitName.
			self assert: aCopy package name asString equals: self packageName.
			self assert: (aCopy localSlots collect: [ :each | each name ] as: Array) equals: #(#ownSlot).
			self
				assert: (aCopy classSide localSlots collect: [ :each | each name ] as: Array)
				equals: #(#ownClassSlot).
			self assert: aCopy traitComposition printString equals: self usedTraitName.
			self assert: (aCopy localSelectors includes: #ownMethod).
			self assert: (aCopy localSelectors includes: #usedMethod) not.
			self assert: (aCopy includesSelector: #usedMethod).
			self assert: (aCopy classSide localSelectors includes: #ownClassMethod).

			aChangeManager undoChange.
			self assert: (self class environment includesKey: self copiedTraitName asSymbol) not.
			self assert: (self class environment includesKey: self sourceTraitName asSymbol).
			self assert: aChangeManager hasUndoableOperations.
			aCopy ] ensure: [ self removePackage ] ]
]

{ #category : #support }
GtCopyTraitFormExample >> defineSourceTraits [
	"Define, through recorded changes, a trait with a slot, a class-side slot and a method of each side,
	that uses another trait with a method"

	| aUsedTrait aSourceTrait |
	(GtRBAddClassChange
		definitionString: 'Trait << #' , self usedTraitName , '
	package: ' , self packageName printString) gtExecuteWithUndo.
	aUsedTrait := self usedTraitName asClass.
	(RBAddMethodChange compile: 'usedMethod ^ 1' in: aUsedTrait classified: 'examples')
		gtExecuteWithUndo.
	(GtRBAddClassChange
		definitionString: 'Trait << #' , self sourceTraitName , '
	traits: {' , self usedTraitName , '};
	slots: { #ownSlot };
	classSlots: { #ownClassSlot };
	package: ' , self packageName printString) gtExecuteWithUndo.
	aSourceTrait := self sourceTraitName asClass.
	(RBAddMethodChange compile: 'ownMethod ^ 2' in: aSourceTrait classified: 'examples')
		gtExecuteWithUndo.
	(RBAddMethodChange
		compile: 'ownClassMethod ^ 3'
		in: aSourceTrait classSide
		classified: 'examples') gtExecuteWithUndo.
	^ aSourceTrait
]

{ #category : #accessing }
GtCopyTraitFormExample >> packageName [
	^ 'GtCopyTraitFormExamplePackage'
]

{ #category : #support }
GtCopyTraitFormExample >> removePackage [
	(self class packageOrganizer packageNamed: self packageName ifAbsent: [ nil ])
		ifNotNil: [ :aPackage | aPackage removeFromSystem ]
]

{ #category : #accessing }
GtCopyTraitFormExample >> sourceTraitName [
	^ 'TGtCopyTraitFormExampleSource'
]

{ #category : #accessing }
GtCopyTraitFormExample >> usedTraitName [
	^ 'TGtCopyTraitFormExampleUsed'
]
