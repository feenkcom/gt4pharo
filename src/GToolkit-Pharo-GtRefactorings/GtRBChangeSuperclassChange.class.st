Class {
	#name : #GtRBChangeSuperclassChange,
	#superclass : #RBRefactoryClassChange,
	#instVars : [
		'newSuperclassName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #'instance creation' }
GtRBChangeSuperclassChange class >> change: aClassName toBeUnder: superclassName [
	^ self new
		changeClassName: aClassName;
		newSuperclassName: superclassName;
		yourself
]

{ #category : #comparing }
GtRBChangeSuperclassChange >> = aRefactoryClassChange [
	^ super = aRefactoryClassChange
		and: [ self newSuperclassName = aRefactoryClassChange newSuperclassName ]
]

{ #category : #converting }
GtRBChangeSuperclassChange >> asUndoOperation [
	| class |
	class := onSystemEnvironment classNamed: self changeClassName.
	^ self copy
		newSuperclassName: (class superclass ifNil: [ nil ] ifNotNil: [ :superClass | superClass name ])
]

{ #category : #printing }
GtRBChangeSuperclassChange >> changeString [
	^ 'Change superclass of ' , self displayClassName , ' to '
		, (newSuperclassName ifNil: [ 'nil' ])
]

{ #category : #private }
GtRBChangeSuperclassChange >> generateChanges [
	| class superclass |
	class := onSystemEnvironment classNamed: self changeClassName.
	superclass := newSuperclassName
			ifNil: [ nil ]
			ifNotNil: [ onSystemEnvironment classNamed: newSuperclassName ].
	class superclass: superclass
]

{ #category : #views }
GtRBChangeSuperclassChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeUpdate
]

{ #category : #views }
GtRBChangeSuperclassChange >> gtDiffChange [
	"Show the definition of the class before and after the change.
	The class does not exist yet if it is defined by a previous change"

	| aClass aDefinition oldSource newSource |
	aClass := onSystemEnvironment classNamed: self changeClassName.
	aClass isBehavior
		ifFalse: [ ^ GtDiffBuilder
				computeDifferencesFrom: ''
				to: self changeString
				using: GtSmaCCDiffSplitter forPharo ].

	aDefinition := GtBehaviorDefinition targetDefinitionForBehavior: aClass.
	oldSource := aDefinition asDefinitionString.
	aDefinition superclass name: (newSuperclassName ifNil: [ 'nil' ]).
	newSource := aDefinition asDefinitionString.

	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: GtSmaCCDiffSplitter forPharo
]

{ #category : #comparing }
GtRBChangeSuperclassChange >> hash [
	^ self newSuperclassName hash hashMultiply bitXor: super hash
]

{ #category : #accessing }
GtRBChangeSuperclassChange >> newSuperclassName [
	^ newSuperclassName
]

{ #category : #accessing }
GtRBChangeSuperclassChange >> newSuperclassName: anObject [
	newSuperclassName := anObject
]
