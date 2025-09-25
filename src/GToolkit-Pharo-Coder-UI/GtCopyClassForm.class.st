Class {
	#name : #GtCopyClassForm,
	#superclass : #Object,
	#instVars : [
		'innerClass',
		'superClassName',
		'onAccept',
		'newClassName',
		'packageAndTag',
		'copyMethods'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Behavior'
}

{ #category : #'instance creation' }
GtCopyClassForm class >> for: aClass [
	^ self new for: aClass
]

{ #category : #converting }
GtCopyClassForm >> asElement [
	^ self asGtMagritteViewModel focusFirstInputField asElement
]

{ #category : #accessing }
GtCopyClassForm >> copyClass [
	| class |
	class := Smalltalk classInstaller
			make: [ :builder | 
				self
					forPharo12AndNewer: [ builder fillFor: innerClass ]
					forPharo11: [ builder gtFillFor: innerClass ].
				builder
					name: newClassName trim;
					superclass: superClassName trim asClass;
					category: (packageAndTag tagName trim
							ifEmpty: [ packageAndTag packageName trim ]
							ifNotEmpty: [ packageAndTag fullName ]) ].
	copyMethods
		ifTrue: [ class copyAllMethodsFrom: innerClass.
			class class copyAllMethodsFrom: innerClass class ].
	^ class
]

{ #category : #accessing }
GtCopyClassForm >> copyMethods [

	^ copyMethods
]

{ #category : #accessing }
GtCopyClassForm >> copyMethods: anObject [

	copyMethods := anObject
]

{ #category : #magritte }
GtCopyClassForm >> copyMethodsDescription [
	<magritteDescription>
	^(MABooleanDescription new)
		label: 'Copy methods';
		priority: 3;
		accessor: #copyMethods;
		editorAptitude: 
				[BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [BrGlamorousLabelAptitude new glamorousFormLabelStyle]
]

{ #category : #accessing }
GtCopyClassForm >> for: aClass [
	innerClass := aClass.
	newClassName := aClass name asString.
	superClassName := aClass superclass name asString.
	copyMethods := true.
	packageAndTag := GtPackageAndTagName new
			packageName: aClass package name;
			tagName: (self treatTag: aClass)
]

{ #category : #accessing }
GtCopyClassForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		label: 'Copy';
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					[ | aClass |
					aClass := GtPharoCodeModifier current critical: [ self copyClass ].
					onAccept ifNotNil: [ onAccept value: aClass ] ] on: Error do: #debug ])
]

{ #category : #magritte }
GtCopyClassForm >> nameDescription [
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
		addCondition: [ :aValue | aValue asString allSatisfy: [ :c | c isAlphaNumeric or: [ c = $_ ] ] ]
			labelled: 'Class name must be alphanumeric'
]

{ #category : #accessing }
GtCopyClassForm >> newClassName [

	^ newClassName
]

{ #category : #accessing }
GtCopyClassForm >> newClassName: anObject [

	newClassName := anObject
]

{ #category : #accessing }
GtCopyClassForm >> onAccept: anAction [
	onAccept := anAction
]

{ #category : #accessing }
GtCopyClassForm >> packageAndTag [
	^ packageAndTag
]

{ #category : #accessing }
GtCopyClassForm >> packageAndTag: anObject [
	packageAndTag := anObject
]

{ #category : #magritte }
GtCopyClassForm >> packageAndTagDescription [
	<magritteDescription>
	^ GtPackageAndTagDescription new
		label: 'Package';
		priority: 3;
		accessor: #packageAndTag;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #magritte }
GtCopyClassForm >> superClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Superclass';
		priority: 2;
		accessor: #superClassName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocCompletion: [ GtPharoCodeModifier current
				critical: [ GtStringsCompletionStrategy new
						completions: (GtPrefixTree withAll: Smalltalk classNames) ] ];
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNotNil ]
			labelled: 'Class does not exist'
]

{ #category : #accessing }
GtCopyClassForm >> superClassName [

	^ superClassName
]

{ #category : #accessing }
GtCopyClassForm >> superClassName: anObject [

	superClassName := anObject
]

{ #category : #accessing }
GtCopyClassForm >> treatTag: aClass [
	| aCategoryName aPackageName aTagString |
	aCategoryName := aClass category.
	aPackageName := aClass package name.

	aTagString := (aCategoryName beginsWith: aPackageName)
			ifFalse: [ '' ]
			ifTrue: [ aCategoryName allButFirst: aPackageName size ].

	^ aTagString trimBoth: [ :aChar | aChar = $- or: [ aChar isSeparator ] ]
]
