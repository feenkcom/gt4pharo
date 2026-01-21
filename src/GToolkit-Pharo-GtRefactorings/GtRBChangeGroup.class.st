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
	^ (GtRBCompositeChangeGroup named: aChange name items: items)
		changes: aChange;
		yourself
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

{ #category : #'as yet unclassified' }
GtRBChangeGroup >> allChanges [
	^ items
		flatCollectAsSet: [ :each | (each isKindOf: GtRBChangeGroup) ifTrue: [ each allChanges ] ifFalse: [ {each} ] ]
]

{ #category : #filtering }
GtRBChangeGroup >> filter: aBlock [
	| result newItems |
	result := self copy.
	newItems := OrderedCollection new.
	items
		do: [ :each | 
			| newItem |
			(each isKindOf: GtRBChangeGroup)
				ifTrue: [ newItem := each filter: aBlock.
					newItem items notEmpty ifTrue: [ newItems add: newItem ] ]
				ifFalse: [ each gtIsComposite
						ifTrue: [ newItem := each gtFilter: aBlock.
							(newItem changes notEmpty or: [ aBlock value: each ])
								ifTrue: [ newItems add: newItem ] ]
						ifFalse: [ (aBlock value: each) ifTrue: [ newItems add: each ] ] ] ].
	result items: newItems.
	^ result
]

{ #category : #accessing }
GtRBChangeGroup >> gtAppliedText [
	| anyApplied allApplied changeWithError |
	anyApplied := false.
	allApplied := true.
	changeWithError := nil.
	items
		do: [ :each | 
			allApplied := allApplied and: [ each gtAllWereApplied ].
			anyApplied := anyApplied or: [ each gtSomeWereApplied ].
			each gtError ifNotNil: [ :err | changeWithError := each ] ].
	^ changeWithError
		ifNil: [ allApplied
				ifTrue: [ self gtTimestamp printToSeconds ]
				ifFalse: [ anyApplied ifTrue: [ 'Partial' ] ifFalse: [ '' ] ] ]
		ifNotNil: [ changeWithError gtAppliedText ]
]

{ #category : #accessing }
GtRBChangeGroup >> gtChangeIcon [
	^ nil
]

{ #category : #accessing }
GtRBChangeGroup >> gtError [
	items do: [ :each | each gtError ifNotNil: [ :error | ^ error ] ].
	^ nil
]

{ #category : #accessing }
GtRBChangeGroup >> gtItemsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Items';
		priority: 10;
		stencil: [ GtRBChangeGroupElement new group: self ]
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
