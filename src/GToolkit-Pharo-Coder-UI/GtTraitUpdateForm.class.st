Class {
	#name : #GtTraitUpdateForm,
	#superclass : #GtTraitCreationForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtTraitUpdateForm class >> onTrait: aTrait [
	^ self new onTrait: aTrait
]

{ #category : #accessing }
GtTraitUpdateForm >> commit [
	| category |
	category := self commitPackage categoryName.
	self newClassName asClass
		category: category;
		slots: slots;
		traitComposition: self traitComposition;
		beTrait
]

{ #category : #accessing }
GtTraitUpdateForm >> nameDescription [
	^ nil
]

{ #category : #accessing }
GtTraitUpdateForm >> onTrait: aTrait [
	self newClassName: aTrait name.
	self slots: (aTrait slots collect: #name).
	self traits: (aTrait traits collect: #name).
	self
		packageAndTagName: (GtPackageAndTagName new
				packageName: aTrait package name;
				tagName: (aTrait package classTagForClass: aTrait) name)
]
