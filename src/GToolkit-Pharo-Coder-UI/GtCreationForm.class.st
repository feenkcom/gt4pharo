Class {
	#name : #GtCreationForm,
	#superclass : #Object,
	#instVars : [
		'onAccept',
		'packageAndTagName'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtCreationForm class >> componentName [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtCreationForm class >> priority [
	^ self subclassResponsibility
]

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
	| aPackage |
	(RPackageOrganizer default includesPackageNamed: packageAndTagName packageName)
		ifTrue: [ aPackage := RPackageOrganizer default
					packageNamed: packageAndTagName packageName.
			^ packageAndTagName tagName
				ifEmpty: [ aPackage ]
				ifNotEmpty: [ :aTagName | aPackage classTagNamed: aTagName ifAbsent: [ aPackage addClassTag: aTagName ] ] ]
		ifFalse: [ aPackage := (RPackage named: packageAndTagName packageName)
					register.
			^ packageAndTagName tagName
				ifEmpty: [ aPackage ]
				ifNotEmpty: [ :aTagName | aPackage addClassTag: aTagName ] ]
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
		beRequired
]

{ #category : #accessing }
GtCreationForm >> packageAndTagName [

	^ packageAndTagName
]

{ #category : #accessing }
GtCreationForm >> packageAndTagName: anObject [

	packageAndTagName := anObject
]

{ #category : #accessing }
GtCreationForm >> taggerStencil [
	^ [ :aMemento :aDescription :aForm | 
	| aTagger aTaggerAptitude |
	aTagger := BrTagger new.
	aTagger
		fitContent.
	aForm hMatchParent.
	aTagger
		aptitude: (aTaggerAptitude := BrGlamorousTaggerEditableAptitude new
					margin: (BlInsets right: 5);
					tagLabel: [ :aTag | 
						BrEditableLabel new
							text: (aDescription displayStringFor: aTag name);
							aptitude: (BrGlamorousEditableLabelAptitude new
									glamorousCodeFont;
									defaultForeground: Color black;
									fontSize: 10);
							whenKey: BlKeyCombination space
								editorDo: [ :anEvent | 
									anEvent target acceptEdition.
									aTaggerAptitude addTagCreatorElement ] ]).
	aTagger
		when: BrTaggerAddTagRequest
		do: [ :aRequest | 
			aMemento
				write: ((aTagger tags collect: #name)
						add: aRequest tag name;
						yourself)
				using: aDescription ].
	aTagger
		when: BrTaggerRemoveTagRequest
		do: [ :aRequest | 
			aMemento
				write: ((aTagger tags collect: #name)
						remove: aRequest tag name;
						yourself)
				using: aDescription ].
	aTagger
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theTagger :aSink | 
					| theValues |
					theValues := aSink value currentValue.
					theTagger namedTags: theValues ].
			(aMemento readObservableValueUsing: aDescription) observe: anElementSink ].
	GtMagritteBuilderUtility
		newValidationContainerWith: aTagger
		memento: aMemento
		using: aDescription ]
]

{ #category : #accessing }
GtCreationForm >> toolFor: anInstance [
	^ GtClassCoderTool forClass: anInstance
]
