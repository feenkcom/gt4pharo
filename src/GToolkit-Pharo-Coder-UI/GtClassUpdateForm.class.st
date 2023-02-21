Class {
	#name : #GtClassUpdateForm,
	#superclass : #GtClassCreationForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtClassUpdateForm class >> isAdditionForm [
	^ false
]

{ #category : #accessing }
GtClassUpdateForm class >> onClass: aClass [
	^ self new onClass: aClass
]

{ #category : #accessing }
GtClassUpdateForm >> nameDescription [
	^ nil
]

{ #category : #accessing }
GtClassUpdateForm >> onClass: aClass [
	self newClassName: aClass name.
	self superclassName: aClass superclass name.
	self slots: (aClass slots collect: #name).
	self traits: (aClass traits collect: #name).
	self
		packageAndTagName: (GtPackageAndTagName new
				packageName: aClass package name;
				tagName: (aClass package classTagForClass: aClass) name).
	self pools: aClass sharedPools.
	self classVars: (aClass classVarNames collect: #asString)
]
