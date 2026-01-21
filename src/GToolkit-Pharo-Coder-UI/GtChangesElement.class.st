Class {
	#name : #GtChangesElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'changesTree',
		'changes'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #executing }
GtChangesElement >> applyChanges [
	^ self applyChangesWithProgress: [  ]
]

{ #category : #executing }
GtChangesElement >> applyChangesWithProgress: aBlock [
	<return: #TAsyncPromise>
	| changesToCompile disabledChanges |
	changesToCompile := RBCompositeRefactoryChange named: changes name.
	disabledChanges := (changesTree viewModel root value flatCollect: #allChanges)
			reject: [ :each | each isEnabled ].
	changesToCompile
		changes: (changesTree viewModel root value collect: [ :each | each change copy ])
				asOrderedCollection.
	disabledChanges
		do: [ :each | changesToCompile recursivelyRemoveChange: each change ].
	^ changesToCompile gtExecuteWithNotificationWithProgress: aBlock
]

{ #category : #accessing }
GtChangesElement >> changes [
	^ changes
]

{ #category : #accessing }
GtChangesElement >> changes: aRefactoryChange [
	changes := aRefactoryChange.
	changesTree
		items: {GtUserActivatableChange fromChange: changes}
		lazy: [ :each | each changes ];
		expandOneLevel
]

{ #category : #initialization }
GtChangesElement >> disableChange: activatableChange [
	activatableChange allChanges do: [ :each | each isEnabled: false ]
]

{ #category : #accessing }
GtChangesElement >> expandUpTo: anInteger [
	changesTree expandUpTo: anInteger
]

{ #category : #initialization }
GtChangesElement >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self matchParent.
	self padding: (BlInsets all: 10).
	changesTree := BrSimpleTree new
			nodeType: [ :aTypeFactory :aTreeNode | aTreeNode value elementClass ];
			nodeStencil: [ :aNodeType | 
				aNodeType new
					addAptitude: (BrGlamorousWithExplicitContextMenuAptitude new
							menu: [ :each | 
								| model |
								model := BrMenuItems new.
								model
									addItemId: #'disable-menu'
									label: 'Disable'
									action: [ model hide.
										self disableChange: each anchorElement activatableChange ] ]);
					yourself ];
			nodeDataBinder: [ :eachElement :eachUserActivatableChange | eachElement activatableChange: eachUserActivatableChange ];
			yourself.
	self addAptitude: (BrLayoutResizerAptitude new inherit: changesTree).
	self addChild: changesTree
]
