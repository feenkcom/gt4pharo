Class {
	#name : #GtRefactoringsElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'activatableRefactorings',
		'changesElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsElement >> applyRefactorings [
	^ changesElement applyChanges
]

{ #category : #initialization }
GtRefactoringsElement >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self matchParent.
	self padding: (BlInsets all: 10).
	changesElement := GtChangesElement new.
	self addAptitude: (BrLayoutResizerAptitude inherit inherit: changesElement).
	self addChild: changesElement
]

{ #category : #accessing }
GtRefactoringsElement >> refactorings: aCollectionOfRBRefactorings [
	| changes |
	aCollectionOfRBRefactorings isEmpty ifTrue: [ ^ self ].
	aCollectionOfRBRefactorings
		do: [ :each | 
			each model name: each printString.
			each primitiveExecute ].
	changes := aCollectionOfRBRefactorings first model changes.
	changesElement changes: changes
]
