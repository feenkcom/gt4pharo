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
	"The form edits the names as text: hold them as Strings, as its editors write them"

	self newClassName: aTrait name.
	self
		slots: ((aTrait slots select: [ :aSlot | aSlot definingClass = aTrait ])
				collect: [ :each | each name asString ]).
	self traits: (aTrait traits collect: [ :each | each name asString ]).
	self
		packageAndTagName: (GtPackageAndTagName new
				packageName: aTrait package name asString;
				tagName: ((aTrait package tagOrNilOf: aTrait) ifNotNil: [ :v | v name asString ])).
	self
		classSlots: ((aTrait classSide slots
				select: [ :aSlot | aSlot definingClass = aTrait classSide ])
				collect: [ :each | each name asString ])
]

{ #category : #accessing }
GtTraitUpdateForm >> poolsDescription [
	^ nil
]

{ #category : #accessing }
GtTraitUpdateForm >> superclassDescription [
	^ nil
]
