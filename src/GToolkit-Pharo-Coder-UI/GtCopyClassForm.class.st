Class {
	#name : #GtCopyClassForm,
	#superclass : #Object,
	#instVars : [
		'innerClass',
		'superClassName',
		'packageName',
		'tagName',
		'onAccept',
		'newClassName'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Behavior'
}

{ #category : #'instance creation' }
GtCopyClassForm class >> for: aClass [
	^ self new for: aClass
]

{ #category : #accessing }
GtCopyClassForm >> acceptAction [
	<magritteActionDescription>
	^ MAActionDescription new
		label: 'Accept';
		action: [ :aModel :aButton | 
			[ | aClass |
			aClass := self copyClass.
			onAccept ifNotNil: [ onAccept value: aClass ] ] on: Error do: #inspect ];
		beCommitAction
]

{ #category : #converting }
GtCopyClassForm >> asElement [
	^ self asGtMagritteViewModel asElement
]

{ #category : #accessing }
GtCopyClassForm >> copyClass [
	| class |
	class := Smalltalk classInstaller
			make: [ :builder | 
				builder
					fillFor: innerClass;
					name: newClassName trim;
					superclass: superClassName trim asClass;
					category: (tagName trim
							ifEmpty: [ packageName trim ]
							ifNotEmpty: [ packageName trim , '-' , tagName trim ]) ].
	class copyAllCategoriesFrom: innerClass.
	class class copyAllCategoriesFrom: innerClass class.
	^ class
]

{ #category : #accessing }
GtCopyClassForm >> for: aClass [
	innerClass := aClass.
	newClassName := aClass name asString.
	superClassName := aClass superclass name asString.
	packageName := aClass package name.
	tagName := self treatTag: aClass 
]

{ #category : #magritte }
GtCopyClassForm >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Name';
		priority: 1;
		accessor: #newClassName;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNil ]
			labelled: 'Class name is already taken';
		addCondition: [ :aValue | aValue isEmpty or: [ aValue first isUppercase ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue isAllAlphaNumerics ]
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

{ #category : #magritte }
GtCopyClassForm >> packageDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Package';
		priority: 3;
		accessor: #packageName;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: (GtPrefixTree withAll: RPackageOrganizer default packageNames) ];
		addCondition: [ :aValue | (RPackageOrganizer default packageNamed: aValue trim ifAbsent: [ nil ]) isNotNil ]
			labelled: 'Package does not exist'
]

{ #category : #accessing }
GtCopyClassForm >> packageName [

	^ packageName
]

{ #category : #accessing }
GtCopyClassForm >> packageName: anObject [

	packageName := anObject
]

{ #category : #magritte }
GtCopyClassForm >> superClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Superclass';
		priority: 2;
		accessor: #superClassName;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
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

{ #category : #magritte }
GtCopyClassForm >> tagDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Tag';
		priority: 4;
		accessor: #tagName;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: (GtPrefixTree withAll: (packageName asPackage classTags collect: #name)) ]
]

{ #category : #accessing }
GtCopyClassForm >> tagName [

	^ tagName
]

{ #category : #accessing }
GtCopyClassForm >> tagName: anObject [

	tagName := anObject
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
