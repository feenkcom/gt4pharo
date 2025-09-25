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
	| class |
	class := Smalltalk classInstaller
			make: [ :builder | 
				builder
					fillFor: innerClass;
					beTrait;
					name: newClassName trim;
					category: (packageAndTag tagName trim
							ifEmpty: [ packageAndTag packageName trim ]
							ifNotEmpty: [ packageAndTag fullName ]) ].
	self forPharo12AndNewer:
			[ class copyAllMethodsFrom: innerClass.
			class class copyAllMethodsFrom: innerClass class ]
		forPharo11: 
			[ class copyAllCategoriesFrom: innerClass.
			class class copyAllCategoriesFrom: innerClass class ].
	^ class
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
