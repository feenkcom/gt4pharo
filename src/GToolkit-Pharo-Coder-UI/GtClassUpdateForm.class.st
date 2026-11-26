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
	self defineClass.
	^ Smalltalk classNamed: self rawClassName
]

{ #category : #accessing }
GtClassUpdateForm >> onClass: aClass [
	"The form edits the names as text: hold them as Strings, as its editors write them"

	| packageName tagName |
	self newClassName: aClass name.
	self superclassName: (aClass superclass ifNotNil: [ :v | v name asString ]).
	self
		slots: ((aClass slots select: [ :aSlot | aSlot definingClass = aClass ])
				collect: [ :each | each name asString ]).
	self traits: (aClass traits collect: [ :each | each name asString ]).
	packageName := aClass package name asString.
	tagName := (aClass package tagOrNilOf: aClass) ifNotNil: [ :v | v name asString ].
	self
		packageAndTagName: (GtPackageAndTagName new
				packageName: packageName;
				tagName: (tagName = packageName ifTrue: [ '' ] ifFalse: [ tagName ])).
	self pools: (aClass sharedPools collect: [ :each | each name asString ]).
	self classVars: (aClass classVarNames collect: #asString).
	self
		classSlots: ((aClass classSide slots
				select: [ :aSlot | aSlot definingClass = aClass classSide ])
				collect: [ :each | each name asString ])
]
