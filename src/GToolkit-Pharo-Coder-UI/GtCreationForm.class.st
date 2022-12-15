"
nil
"
Class {
	#name : #GtCreationForm,
	#superclass : #Object,
	#instVars : [
		'onAccept',
		'packageAndTagName'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #magritte }
GtCreationForm >> acceptAction [
	<magritteActionDescription>
	^ MAActionDescription new
		label: 'Accept';
		action: [ :aModel :aButton | 
			[ | aValue |
			aValue := self commit.
			onAccept ifNotNil: [ onAccept value: aValue ] ] on: Error do: #inspect ];
		beCommitAction
]

{ #category : #callbacks }
GtCreationForm >> commit [
	^ self subclassResponsibility
]

{ #category : #callbacks }
GtCreationForm >> commitPackage [
	(RPackageOrganizer default includesPackageNamed: packageAndTagName packageName)
		ifTrue: [ | aPackage |
			aPackage := RPackageOrganizer default
					packageNamed: packageAndTagName packageName.
			packageAndTagName tagName
				ifEmpty: [ ^ aPackage ]
				ifNotEmpty: [ :aTagName | ^ aPackage classTagNamed: aTagName ifAbsent: [ aPackage addClassTag: aTagName ] ] ]
		ifFalse: [ ^ (RPackage named: packageAndTagName packageName) register
				addClassTag: packageAndTagName tagName ]
]

{ #category : #initialization }
GtCreationForm >> initialize [
	packageAndTagName := GtPackageAndTagName new
]

{ #category : #accessing }
GtCreationForm >> onAccept [

	^ onAccept
]

{ #category : #accessing }
GtCreationForm >> onAccept: anObject [

	onAccept := anObject
]

{ #category : #accessing }
GtCreationForm >> packageAndTagDescription [
	<magritteDescription>
	^ GtPackageAndTagDescription new
		label: 'Package';
		priority: 3;
		accessor: #packageAndTagName;
		addCondition: [ :aValue | aValue packageName trim isNotEmpty ]
			labelled: 'Package must be set'
]

{ #category : #accessing }
GtCreationForm >> packageAndTagName [

	^ packageAndTagName
]

{ #category : #accessing }
GtCreationForm >> packageAndTagName: anObject [

	packageAndTagName := anObject
]
