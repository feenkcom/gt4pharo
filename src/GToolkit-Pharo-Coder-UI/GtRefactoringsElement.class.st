Class {
	#name : #GtRefactoringsElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'activatableRefactorings',
		'refactoringsList'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsElement >> activatableRefactoring: aRefactoring [
	^ aRefactoring options
		at: #activatableRefactoring
		ifAbsent: [ | activatableRefactoring |
			activatableRefactoring := GtUserActivatableRefactoring
				fromRefactoring: aRefactoring.
			aRefactoring
				setOption: #activatableRefactoring
				toUse: activatableRefactoring.
			activatableRefactoring ]
]

{ #category : #initialization }
GtRefactoringsElement >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self matchParent.
	self padding: (BlInsets all: 10).
	refactoringsList := (BrSimpleTree new)
		nodeStencil: [ BrLabel new aptitude: BrGlamorousLabelAptitude ];
		nodeDataBinder: [ :aNodeElement :aRef | aNodeElement text: aRef gtDescription ];
		yourself.
	self addAptitude: (BrLayoutResizerAptitude inherit inherit: refactoringsList).
	self addChild: refactoringsList
]

{ #category : #accessing }
GtRefactoringsElement >> refactorings: aCollectionOfRBRefactorings [
	| changes |
	aCollectionOfRBRefactorings
		do:
			[ :each | 
			each model name: each printString.
			each primitiveExecute ].
	changes := aCollectionOfRBRefactorings first model changes.
	refactoringsList items: {changes} lazy: [ :each | each gtChildren ]
]
