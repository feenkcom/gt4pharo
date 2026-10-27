"
I remove a class from the system.
My undo restores the class and the subclasses it still has, using their definitions as strings (${class:GtRBAddClassChange}$), followed by their class-side slots, comments and local methods:
- superclasses are restored before their subclasses and referenced by name, so restored subclasses are attached to the restored superclasses,
- the undo keeps no reference to the removed class objects.
"
Class {
	#name : #GtRBRemoveClassChange,
	#superclass : #RBRemoveClassChange,
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #private }
GtRBRemoveClassChange >> addUndoChangesFor: aClass to: aCompositeChange [
	"Unlike RBRemoveClassChange>>#asUndoOperation, do not define the class with a builder 
	filled by #fillFor:. Such a builder keeps the class and its superclass as objects: 
	when the superclass is removed andrestored too, the class is restored under the obsolete
	superclass, and the removed class stays referenced by the undo. #fillFor: also copies the
	class-side slots, which the superclass adds a second time.
	The definition string does not include the class-side slots, so they are added separately.
	Only local methods are compiled, methods from traits come back with the trait composition"

	aCompositeChange
		addChange: (GtRBAddClassChange definitionString: (self undoClassDefinitionFor: aClass)).

	aClass comment
		ifNotNil: [ :aComment | aCompositeChange comment: aComment in: aClass ].

	{aClass.
		aClass class}
		do: [ :eachBehavior | 
			eachBehavior localSelectors
				do: [ :eachSelector | 
					aCompositeChange
						compile: (eachBehavior sourceCodeAt: eachSelector)
						in: eachBehavior
						classified: (eachBehavior >> eachSelector) protocolName ] ]
]

{ #category : #converting }
GtRBRemoveClassChange >> asUndoOperation [
	"Restore the class and the subclasses it still has from their definitions.
	Superclasses are restored before their subclasses and found by name,
	and the undo keeps no reference to the removed class objects."

	| classChanges |
	
	classChanges := changeFactory compositeRefactoryChange.
	
	self addUndoChangesFor: self changeClass to: classChanges.
	self changeClass
		allSubclassesDo: [ :eachClass | self addUndoChangesFor: eachClass to: classChanges ].
		
	^ classChanges
]
