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
	self defineTrait.
	^ Smalltalk classNamed: self rawClassName
]

{ #category : #accessing }
GtTraitUpdateForm >> onTrait: aTrait [
	self newClassName: aTrait name.
	self
		slots: ((aTrait slots select: [ :aSlot | aSlot definingClass = aTrait ]) collect: #name).
	self traits: (aTrait traits collect: #name).
	self
		packageAndTagName: (GtPackageAndTagName new
				packageName: aTrait package name;
				tagName: ((aTrait package tagOrNilOf: aTrait) ifNotNil: #name)).
	self
		classSlots: ((aTrait classSide slots select: [ :aSlot | aSlot definingClass = aTrait classSide ])
				collect: #name)
]

{ #category : #accessing }
GtTraitUpdateForm >> poolsDescription [
	^ nil
]

{ #category : #accessing }
GtTraitUpdateForm >> superclassDescription [
	^ nil
]
