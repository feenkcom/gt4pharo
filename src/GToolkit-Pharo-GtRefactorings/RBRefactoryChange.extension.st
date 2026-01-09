Extension { #name : #RBRefactoryChange }

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> attributeNamed: aSymbol [
	attributes isNil ifTrue: [ ^ nil ].
	^ attributes at: aSymbol ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> attributeNamed: aSymbol ifAbsent: aBlock [
	^ self attributes at: aSymbol ifAbsent: aBlock
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> attributeNamed: aSymbol ifAbsentPut: aBlock [
	^ self attributes at: aSymbol ifAbsentPut: aBlock
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> attributeNamed: aSymbol put: aValue [
	^ self attributes at: aSymbol put: aValue
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> attributes [
	^ attributes ifNil: [ attributes := IdentityDictionary new ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> gtAllChangesDo: aBlock [
	aBlock value: self
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> gtBasicChanges [
	| changes |
	changes := OrderedCollection new.
	self gtBasicChangesInto: changes.
	^ changes
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> gtBasicChangesInto: changes [
	self isBasicChange ifTrue: [ changes add: self ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeEmpty
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> gtClassFilter [
	<gtRefactoryChangeFilter>
	^ GtFilterTextModel new
		creator: [ :stream :model | 
			| value |
			value := model text asString.
			value isEmpty
				ifTrue: [ stream ]
				ifFalse: [ stream filter: [ :each | each gtIsForClassNamed: value ] ] ];
		named: 'In class';
		order: 10;
		completion: [ GtStringsCompletionStrategy new
				completions: [ GtPharoIndex current classNameTree ] ];
		beNotDefault
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> gtExecutedFilter [
	<gtRefactoryChangeFilter>
	^ GtFilterShortListModel new
		creator: [ :stream :model | 
			| selector |
			selector := model selectedItem itemValue = 'yes'
					ifTrue: [ #notNil ]
					ifFalse: [ #isNil ].
			stream
				filter: [ :each | (each attributeNamed: #timestamp) perform: selector ] ];
		named: 'Executed';
		order: 20;
		items: {'no' asFilterModelItem.
				'yes' asFilterModelItem};
		selectFirstItem;
		beNotDefault
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> gtIsForClassNamed: aSymbol [
	^ false
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> isBasicChange [
	^ true
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> postCopy [
	super postCopy.
	attributes := attributes ifNotNil: [ attributes copy ]
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> transformation [
	^ self attributeNamed: #transformations
]

{ #category : #'*GToolkit-Pharo-GtRefactorings' }
RBRefactoryChange >> transformation: aTransformation [
	self attributeNamed: #transformations put: aTransformation
]
