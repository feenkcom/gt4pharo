Class {
	#name : #GtClassUpdateForm,
	#superclass : #GtBehaviorUpdateForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtClassUpdateForm class >> onClass: aClass [
	^ self new onClass: aClass
]

{ #category : #accessing }
GtClassUpdateForm >> commit [
	| aClass |
	aClass := newClassName asClass.
	self removeClassSlots: aClass.
	self defineClass.
	aClass := Smalltalk classNamed: self rawClassName.
	self installClassSlotsOn: aClass.

	^ aClass
]

{ #category : #accessing }
GtClassUpdateForm >> onClass: aClass [
	| packageName tagName |
	self newClassName: aClass name.
	self superclassName: (aClass superclass ifNotNil: #name).
	self
		slots: ((aClass slots select: [ :aSlot | aSlot definingClass = aClass ]) collect: #name).
	self traits: (aClass traits collect: #name).
	packageName := aClass package name.
	tagName := (aClass package tagOrNilOf: aClass) ifNotNil: #name.
	self
		packageAndTagName: (GtPackageAndTagName new
				packageName: packageName;
				tagName: (tagName = packageName ifTrue: [ '' ] ifFalse: [ tagName ])).
	self pools: (aClass sharedPools collect: #name).
	self classVars: (aClass classVarNames collect: #asString).
	self classSlots: (aClass classSide slots collect: #name).
	self
		superSlots: ((aClass allSlots collect: #name) asSet
				difference: (aClass slots collect: #name) asSet)
]

{ #category : #accessing }
GtClassUpdateForm >> removeClassSlots: aClass [
	| changes |
	aClass classSide slots isEmpty ifTrue: [ ^ self ].
	changes := aClass classSide slots
			collect: [ :aSlot | RBRemoveInstanceVariableChange remove: aSlot name from: aClass classSide ].
	(RBCompositeRefactoryChange new
		name: 'Remove class slots';
		changes: changes;
		yourself) gtExecuteWithUndo
]
