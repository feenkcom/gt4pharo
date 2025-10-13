Class {
	#name : #GtTraitUpdateForm,
	#superclass : #GtBehaviorUpdateForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtTraitUpdateForm class >> onTrait: aTrait [
	^ self new onTrait: aTrait
]

{ #category : #accessing }
GtTraitUpdateForm >> classVarsDescription [
	^ nil
]

{ #category : #accessing }
GtTraitUpdateForm >> commit [
	| category aClass |
	category := self commitPackage categoryName.
	aClass := newClassName asClass.
	aClass classSide slots
		do: [ :aSlot | 
			(RBRemoveInstanceVariableChange remove: aSlot name from: aClass classSide)
				execute ].
	aClass := Smalltalk classInstaller
			make: [ :builder | 
				builder
					name: newClassName;
					category: category;
					slots: slots;
					traitComposition: self traitComposition;
					beTrait ].
	self installClassSlotsOn: aClass.
	^ aClass
]

{ #category : #accessing }
GtTraitUpdateForm >> onTrait: aTrait [
	self newClassName: aTrait name.
	self slots: (aTrait slots collect: #name).
	self traits: (aTrait traits collect: #name).
	self
		packageAndTagName: (GtPackageAndTagName new
				packageName: aTrait package name;
				tagName: ((aTrait package tagOrNilOf: aTrait) ifNotNil: #name)).
	self classSlots: (aTrait classSide slots collect: #name).
	self
		superSlots: ((aTrait allSlots collect: #name) asSet
				difference: (aTrait slots collect: #name) asSet)
]

{ #category : #accessing }
GtTraitUpdateForm >> poolsDescription [
	^ nil
]

{ #category : #accessing }
GtTraitUpdateForm >> superclassDescription [
	^ nil
]
