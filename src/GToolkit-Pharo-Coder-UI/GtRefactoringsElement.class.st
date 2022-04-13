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
GtRefactoringsElement >> applyRefactorings [
	| aCompositeChange theChanges |
	aCompositeChange := RBCompositeRefactoryChange new.

			"theChanges := (refactoringsList viewModel root value flatCollect: #allChanges)
		select: [ :eachChange | eachChange isEnabled ]
		thenCollect: [ :eachChange | eachChange change gtWithoutChanges ]."
		
	theChanges := refactoringsList viewModel root value collect: [ :each | each change copy ].
	aCompositeChange changes: theChanges.
	GtPharoCodeModifier current performRefactoryChange: aCompositeChange andAddUndoPointer: 1
]

{ #category : #initialization }
GtRefactoringsElement >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self matchParent.
	self padding: (BlInsets all: 10).
	refactoringsList := (BrSimpleTree new)
		nodeType: [ :aTypeFactory :aTreeNode | aTreeNode value elementClass ];
		nodeStencil: [ :aNodeType | aNodeType new ];
		nodeDataBinder: [ :eachElement :eachUserActivatableChange | eachElement activatableChange: eachUserActivatableChange ];
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
	refactoringsList items: {GtUserActivatableChange fromChange: changes} lazy: [ :each | each changes ]
]
