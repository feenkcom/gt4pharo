Class {
	#name : #GtRefactoryChangeElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'changes'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes-View'
}

{ #category : #'instance creation' }
GtRefactoryChangeElement class >> forChanges: compositeChanges [
	^ self new
		changes: compositeChanges;
		yourself
]

{ #category : #accessing }
GtRefactoryChangeElement >> changes [
	^ changes
]

{ #category : #accessing }
GtRefactoryChangeElement >> changes: compositeChanges [
	| basicChanges |
	changes := compositeChanges.
	basicChanges := compositeChanges gtBasicChanges.
	(self childNamed: #changes) items: basicChanges
]

{ #category : #initialization }
GtRefactoryChangeElement >> initialize [
	super initialize.
	self matchParent.
	self initializeList
]

{ #category : #initialization }
GtRefactoryChangeElement >> initializeList [
	| list |
	list := BrColumnedList new.
	list matchParent.
	list aptitude: BrColumnedMultiListAptitude.
	list column
		title: 'Type';
		cellStencil: [ BlElement new
				layout: BlLinearLayout horizontal alignCenter;
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ] ];
		dataBinder: [ :element :change | 
			element
				removeChildren;
				addChild: change gtChangeIcon asElement ];
		width: 32.
	list column
		title: 'Description';
		matchParent;
		cellStencil: [ :each | BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :label :change | label text: change gtDescription ].
	list column
		width: 150;
		title: 'Performed';
		cellStencil: [ :each | BrLabel new aptitude: BrGlamorousLabelAptitude new ];
		dataBinder: [ :label :change | 
			label
				text: ((change attributeNamed: #timestamp)
						ifNil: [ '' asRopedText ]
						ifNotNil: [ :ts | ts printToSeconds ]) ].
	list addEventHandler: GtPhlowListToSelectHandler new.
	self addChild: list as: #changes.
	list addAptitude: (BrColumnedListHeaderAptitude new cellSpacing: 10)
]
