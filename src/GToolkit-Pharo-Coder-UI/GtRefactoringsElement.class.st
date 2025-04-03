Class {
	#name : #GtRefactoringsElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'changesElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsElement >> applyRefactoringWithProgress: aBlock [
	^ changesElement applyChangesWithProgress: aBlock
]

{ #category : #accessing }
GtRefactoringsElement >> applyRefactorings [
	^ changesElement applyChanges
]

{ #category : #accessing }
GtRefactoringsElement >> changes: changes [
	changesElement changes: changes
]

{ #category : #accessing }
GtRefactoringsElement >> changesSize [
	^ changesElement changes changesSize
]

{ #category : #initialization }
GtRefactoringsElement >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self matchParent.
	self padding: (BlInsets all: 10).
	changesElement := GtChangesElement new.
	self addAptitude: (BrLayoutResizerAptitude new inherit: changesElement).
	self addChild: changesElement
]

{ #category : #accessing }
GtRefactoringsElement >> refactorings: aCollectionOfRBRefactorings [
	| changes |
	aCollectionOfRBRefactorings isEmpty ifTrue: [ ^ self ].
	changes := aCollectionOfRBRefactorings first model changes.
	self changes: changes
]
