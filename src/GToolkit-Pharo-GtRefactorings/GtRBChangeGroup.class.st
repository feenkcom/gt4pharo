Class {
	#name : #GtRBChangeGroup,
	#superclass : #Object,
	#instVars : [
		'name',
		'items'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes-Group'
}

{ #category : #accessing }
GtRBChangeGroup class >> buildFrom: aChange [
	| groups items |
	groups := Dictionary new.
	aChange
		gtAllChangesDo: [ :each | 
			(each perform: self buildSelector)
				ifNotNil: [ :group | (groups at: group ifAbsentPut: [ group ]) addItem: each ] ].
	items := groups keys asSortedCollection: [ :a :b | a name < b name ].
	^ GtRBCompositeChangeGroup named: aChange name items: items
]

{ #category : #private }
GtRBChangeGroup class >> buildSelector [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtRBChangeGroup class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #'instance creation' }
GtRBChangeGroup class >> named: aString items: aCollection [
	^ self new
		name: aString;
		items: aCollection;
		yourself
]

{ #category : #comparing }
GtRBChangeGroup >> = anObject [
	^ self class = anObject class and: [ self name = anObject name ]
]

{ #category : #adding }
GtRBChangeGroup >> addItem: anObject [
	items add: anObject
]

{ #category : #accessing }
GtRBChangeGroup >> gtAppliedText [
	| anyApplied allApplied error |
	anyApplied := false.
	allApplied := true.
	error := nil.
	items
		do: [ :each | 
			allApplied := allApplied and: [ each gtAllWereApplied ].
			anyApplied := anyApplied or: [ each gtSomeWereApplied ].
			each gtError ifNotNil: [ :err | error := err ] ].
	^ error
		ifNil: [ allApplied
				ifTrue: [ self gtTimestamp printToSeconds ]
				ifFalse: [ anyApplied ifTrue: [ 'Partial' ] ifFalse: [ '' ] ] ]
		ifNotNil: [ error messageText ]
]

{ #category : #accessing }
GtRBChangeGroup >> gtError [
	items do: [ :each | each gtError ifNotNil: [ :error | ^ error ] ].
	^ nil
]

{ #category : #accessing }
GtRBChangeGroup >> gtItemsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Items';
		priority: 10;
		items: [ items ];
		children: [ :each | (each isKindOf: RBRefactoryChange) ifTrue: [ #() ] ifFalse: [ each items ] ];
		column: 'Description'
			text: [ :each | each name asRopedText ]
			weight: 0.75;
		column: '# of changes'
			text: [ :each | 
				(each isKindOf: RBRefactoryChange)
					ifTrue: [ '' ]
					ifFalse: [ each gtNumberOfChanges printString ] ]
			weight: 0.12;
		column: 'Applied'
			text: [ :each | each gtAppliedText ]
			weight: 0.13
]

{ #category : #accessing }
GtRBChangeGroup >> gtNumberOfChanges [
	^ items sum: #gtNumberOfChanges
]

{ #category : #accessing }
GtRBChangeGroup >> gtTimestamp [
	| timestamp |
	timestamp := nil.
	items
		do: [ :each | 
			each gtTimestamp
				ifNotNil: [ :ts | timestamp := (timestamp ifNil: [ ts ]) max: ts ] ].
	^ timestamp
]

{ #category : #comparing }
GtRBChangeGroup >> hash [
	^ self name hash
]

{ #category : #initialization }
GtRBChangeGroup >> initialize [
	super initialize.
	items := OrderedCollection new
]

{ #category : #accessing }
GtRBChangeGroup >> items [
	^ items
]

{ #category : #accessing }
GtRBChangeGroup >> items: anObject [
	items := anObject
]

{ #category : #accessing }
GtRBChangeGroup >> name [
	^ name
]

{ #category : #accessing }
GtRBChangeGroup >> name: anObject [
	name := anObject
]
