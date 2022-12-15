"
nil
"
Class {
	#name : #GtClassCreationForm,
	#superclass : #GtTraitCreationForm,
	#instVars : [
		'superclassName',
		'classVars',
		'pools'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtClassCreationForm >> classVars [

	^ classVars
]

{ #category : #accessing }
GtClassCreationForm >> classVars: anObject [

	classVars := anObject
]

{ #category : #accessing }
GtClassCreationForm >> classVarsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Class vars';
		priority: 7;
		accessor: #classVars;
		blocListStencil: [ :aMemento :aDescription :aForm | 
			| aTagger |
			aTagger := BrTagger new.
			aTagger
				margin: ((BlInsets left: 7) withBottom: 4);
				hMatchParent;
				vFitContent.
			aForm hMatchParent.
			aTagger
				aptitude: (BrGlamorousTaggerEditableAptitude new
						margin: (BlInsets right: 5);
						tagLabel: [ :aTag | 
							BrEditableLabel new
								text: (aDescription displayStringFor: aTag name);
								aptitude: (BrGlamorousEditableLabelAptitude new
										glamorousCodeFont;
										defaultForeground: Color black;
										fontSize: 10);
								whenKey: BlKeyCombination primaryB
									labelDo: [ :aShortcutEvent :aShortcut | aTagger phlow spawnObject: aTag name ] ]).
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
						sink: AsyncPeakSink new;
						whenUpdate: [ :theTagger :aSink | 
							| theValues |
							theValues := aSink value currentValue.
							theTagger namedTags: theValues ].
					(aMemento readObservableValueUsing: aDescription) observe: anElementSink ] ]
]

{ #category : #accessing }
GtClassCreationForm >> commit [
	Smalltalk compiler evaluate: self definitionString.
	^ Smalltalk classNamed: self className
]

{ #category : #accessing }
GtClassCreationForm >> definitionString [
	| aStream aPackage |
	aStream := (String new: 800) writeStream.
	aStream nextPutAll: self superclassName.

	aStream
		nextPutAll: ' subclass: ';
		store: self className asSymbol.

	self traits isEmpty
		ifFalse: [ aStream
				cr;
				tab;
				nextPutAll: 'uses: ';
				nextPutAll: (' + ' join: self traits) ].
	aStream
		cr;
		tab;
		nextPutAll: 'instanceVariableNames: ';
		store: (' ' join: self slots).	"Class vars"
	aStream
		cr;
		tab;
		nextPutAll: 'classVariableNames: ';
		store: (' ' join: self classVars).	"Pool Dictionaries"
	aStream
		cr;
		tab;
		nextPutAll: 'poolDictionaries: ';
		store: (' ' join: self pools).

	aPackage := self commitPackage.

	aStream
		cr;
		tab;
		nextPutAll: 'package: ';
		store: aPackage categoryName asString.

	^ aStream contents
]

{ #category : #accessing }
GtClassCreationForm >> initialize [
	super initialize.

	self className: 'NameOfSubclass'.
	self superclassName: 'Object'.

	classVars := OrderedCollection new.
	pools := OrderedCollection new
]

{ #category : #accessing }
GtClassCreationForm >> pools [

	^ pools
]

{ #category : #accessing }
GtClassCreationForm >> pools: anObject [

	pools := anObject
]

{ #category : #accessing }
GtClassCreationForm >> poolsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Pools';
		priority: 7;
		accessor: #pools;
		blocListStencil: [ :aMemento :aDescription :aForm | 
			| aTagger |
			aTagger := BrTagger new.
			aTagger
				margin: ((BlInsets left: 7) withBottom: 4);
				hMatchParent;
				vFitContent.
			aForm hMatchParent.
			aTagger
				aptitude: (BrGlamorousTaggerEditableAptitude new
						margin: (BlInsets right: 5);
						tagLabel: [ :aTag | 
							BrEditableLabel new
								text: (aDescription displayStringFor: aTag name);
								aptitude: (BrGlamorousEditableLabelAptitude new
										glamorousCodeFont;
										defaultForeground: Color black;
										fontSize: 10);
								whenKey: BlKeyCombination primaryB
									labelDo: [ :aShortcutEvent :aShortcut | aTagger phlow spawnObject: aTag name ] ]).
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
						sink: AsyncPeakSink new;
						whenUpdate: [ :theTagger :aSink | 
							| theValues |
							theValues := aSink value currentValue.
							theTagger namedTags: theValues ].
					(aMemento readObservableValueUsing: aDescription) observe: anElementSink ] ]
]

{ #category : #accessing }
GtClassCreationForm >> superclassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Superclass';
		priority: 2;
		accessor: #superclassName;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNotNil ]
			labelled: 'Unknown class'
]

{ #category : #accessing }
GtClassCreationForm >> superclassName [

	^ superclassName
]

{ #category : #accessing }
GtClassCreationForm >> superclassName: anObject [

	superclassName := anObject
]
