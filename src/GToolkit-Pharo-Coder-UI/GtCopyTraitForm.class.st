Class {
	#name : #GtCopyTraitForm,
	#superclass : #Object,
	#instVars : [
		'innerClass',
		'superClassName',
		'onAccept',
		'newClassName',
		'packageAndTag'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Behavior'
}

{ #category : #'instance creation' }
GtCopyTraitForm class >> for: aClass [
	^ self new for: aClass
]

{ #category : #converting }
GtCopyTraitForm >> asElement [
	^ self asGtMagritteViewModel asElement
]

{ #category : #accessing }
GtCopyTraitForm >> copyTrait [
	"Copy the trait through one recorded change, so that it can be undone and keeps the undo history.
	The definition keeps the slots, the class-side slots and the trait composition of the copied trait.
	Only its own methods are copied: those of its traits come with the trait composition"

	| aName model newTrait |
	aName := newClassName trim asSymbol.
	model := GtRBNamespace new.
	model
		defineClass: (GtFluidDefinitionStringBuilder new
				beTrait;
				className: aName;
				traitNames: (innerClass traits collect: [ :each | each name ] as: Array);
				slotNames: (innerClass localSlots collect: [ :each | each name ] as: Array);
				classSlotNames: (innerClass classSide localSlots collect: [ :each | each name ] as: Array);
				tagName: packageAndTag tagName trim;
				packageName: packageAndTag packageName trim;
				fillFromBehavior: innerClass;
				definitionString).
	newTrait := model classNamed: aName.
	{innerClass -> newTrait.
		innerClass classSide -> newTrait classSide}
		do: [ :each |
			each key localSelectors
				do: [ :aSelector |
					each value
						compile: (each key sourceCodeAt: aSelector)
						classified: (each key >> aSelector) protocolName ] ].
	GtPharoCodeModifier current performRefactoryChange: model changes.

	^ self class environment classOrTraitNamed: aName
]

{ #category : #accessing }
GtCopyTraitForm >> for: aTrait [
	innerClass := aTrait.
	newClassName := aTrait name asString.
	packageAndTag := GtPackageAndTagName new
			packageName: aTrait package name;
			tagName: (self treatTag: aTrait)
]

{ #category : #accessing }
GtCopyTraitForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		label: 'Copy';
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					[ | aClass |
					aClass := GtPharoCodeModifier current critical: [ self copyTrait ].
					onAccept ifNotNil: [ onAccept value: aClass ] ] on: Error do: #debug ])
]

{ #category : #magritte }
GtCopyTraitForm >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Name';
		priority: 1;
		accessor: #newClassName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocCompletion: [ GtPharoCodeModifier current
				critical: [ GtStringsCompletionStrategy new
						completions: (GtPrefixTree withAll: Smalltalk classNames) ] ];
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNil ]
			labelled: 'Class name is already taken';
		addCondition: [ :aValue | aValue isEmpty or: [ aValue first isUppercase ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue isAllAlphaNumerics ]
			labelled: 'Class name must be alphanumeric'
]

{ #category : #accessing }
GtCopyTraitForm >> newClassName [

	^ newClassName
]

{ #category : #accessing }
GtCopyTraitForm >> newClassName: anObject [

	newClassName := anObject
]

{ #category : #accessing }
GtCopyTraitForm >> onAccept: anAction [
	onAccept := anAction
]

{ #category : #accessing }
GtCopyTraitForm >> packageAndTag [
	^ packageAndTag
]

{ #category : #accessing }
GtCopyTraitForm >> packageAndTag: anObject [
	packageAndTag := anObject
]

{ #category : #magritte }
GtCopyTraitForm >> packageAndTagDescription [
	<magritteDescription>
	^ GtPackageAndTagDescription new
		label: 'Package';
		priority: 3;
		accessor: #packageAndTag;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #accessing }
GtCopyTraitForm >> treatTag: aClass [
	| aCategoryName aPackageName aTagString |
	aCategoryName := aClass category.
	aPackageName := aClass package name.

	aTagString := (aCategoryName beginsWith: aPackageName)
			ifFalse: [ '' ]
			ifTrue: [ aCategoryName allButFirst: aPackageName size ].

	^ aTagString trimBoth: [ :aChar | aChar = $- or: [ aChar isSeparator ] ]
]
