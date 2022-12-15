"
nil
"
Class {
	#name : #GtTraitCreationForm,
	#superclass : #GtCreationForm,
	#instVars : [
		'className',
		'traits',
		'slots'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtTraitCreationForm >> className [
	^ className
]

{ #category : #accessing }
GtTraitCreationForm >> className: anObject [
	className := anObject
]

{ #category : #accessing }
GtTraitCreationForm >> commit [
	| category |
	category := self commitPackage categoryName.
	^ Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: className;
				category: category;
				slots: slots;
				traitComposition: self traitComposition;
				beTrait ]
]

{ #category : #accessing }
GtTraitCreationForm >> defaultName [
	^ 'TNameOfTrait'
]

{ #category : #initialization }
GtTraitCreationForm >> initialize [
	super initialize.

	className := self defaultName.
	traits := OrderedCollection new.
	slots := OrderedCollection new
]

{ #category : #magritte }
GtTraitCreationForm >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Name';
		priority: 1;
		accessor: #className;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNil ]
			labelled: 'Name is already taken';
		addCondition: [ :aValue | aValue first isUppercase ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue isAllAlphaNumerics ]
			labelled: 'Name must be alphanumeric';
		addCondition: [ :aValue | (aValue = 'TNameOfTrait') not and: [ (aValue = 'NameOfSubclass') not ] ]
			labelled: 'Name cannot be example value'
]

{ #category : #accessing }
GtTraitCreationForm >> slots [

	^ slots
]

{ #category : #accessing }
GtTraitCreationForm >> slots: anObject [

	slots := anObject
]

{ #category : #accessing }
GtTraitCreationForm >> slotsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Slots';
		priority: 5;
		accessor: #slots;
		  classes: { String };
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
GtTraitCreationForm >> traitComposition [
	^ (self traits collect: #asClass) asArray asTraitComposition
]

{ #category : #accessing }
GtTraitCreationForm >> traits [

	^ traits
]

{ #category : #accessing }
GtTraitCreationForm >> traits: anObject [

	traits := anObject
]

{ #category : #accessing }
GtTraitCreationForm >> traitsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Traits';
		priority: 5;
		accessor: #traits;
		classes: {String};
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
							| aLabel |
							aLabel := BrEditableLabel new
									text: (aDescription displayStringFor: aTag name);
									aptitude: (BrGlamorousEditableLabelAptitude new
											glamorousCodeFont;
											defaultForeground: Color black;
											fontSize: 10);
									whenKey: BlKeyCombination primaryB
										labelDo: [ :aShortcutEvent :aShortcut | aTagger phlow spawnObject: aTag name ].

							(GtCompletionController
								on: aLabel
								strategy: GtClassesCompletionStrategy new) install.
							aLabel ]).
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
