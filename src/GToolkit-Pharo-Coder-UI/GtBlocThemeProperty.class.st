Class {
	#name : #GtBlocThemeProperty,
	#superclass : #Object,
	#instVars : [
		'subThemeModel',
		'valueAssignments',
		'constantAssignments',
		'propertyName',
		'propertyValue'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeProperty >> amountOfValueAssignments [
	^ valueAssignments size
]

{ #category : #accessing }
GtBlocThemeProperty >> constantAssignments [
	^ constantAssignments
]

{ #category : #accessing }
GtBlocThemeProperty >> constantAssignments: anObject [
	constantAssignments := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemeProperty >> copyAndTransformAssignmentsWith: aBlock [
	1
		to: valueAssignments size
		do: [ :index |
			| newAssignment |
			
			newAssignment := (valueAssignments at: index) copy.
			aBlock value: newAssignment.
			valueAssignments at: index put: newAssignment ]
]

{ #category : #'ast  - analysis' }
GtBlocThemeProperty >> doesAstUseConstantGetter: anAst [

	anAst nodesDo: [ :eachNode |
		(eachNode isMessage and: [ eachNode selector = #constantAt: ])
			ifTrue: [ ^ true ] ].
			
	^ false
]

{ #category : #'as yet unclassified' }
GtBlocThemeProperty >> gtDisplayOn: aStream [
	aStream nextPutAll: self propertyName
]

{ #category : #views }
GtBlocThemeProperty >> gtValueAssignmentsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Assignments';
		priority: 5;
		items: [ valueAssignments ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #'ast  - analysis' }
GtBlocThemeProperty >> hardcodedValueAssignments [
	^ self valueAssignments reject: [ :eachAssignment |
		self doesAstUseConstantGetter: eachAssignment valueAst ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeProperty >> postCopy [
	valueAssignments := valueAssignments copy
]

{ #category : #accessing }
GtBlocThemeProperty >> printShortThemeableValue [
	| article className |
	
	className := self propertyValue class name.
	article := className first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ].
	
	^ '{1} {2}' format: { article . className }
]

{ #category : #accessing }
GtBlocThemeProperty >> propertyName [
	^ propertyName
]

{ #category : #accessing }
GtBlocThemeProperty >> propertyName: aSymbol [
	propertyName := aSymbol
]

{ #category : #accessing }
GtBlocThemeProperty >> propertyValue [
	^ propertyValue
]

{ #category : #accessing }
GtBlocThemeProperty >> propertyValue: anObject [
	propertyValue := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemeProperty >> replaceValueAssignment: anAssignment with: anotherAssignment [
	| index |
	index:= self valueAssignments indexOf: anAssignment.
	self valueAssignments at: index put: anotherAssignment.
]

{ #category : #accessing }
GtBlocThemeProperty >> subThemeModel [
	^ subThemeModel
]

{ #category : #accessing }
GtBlocThemeProperty >> subThemeModel: anObject [
	subThemeModel := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemeProperty >> theme [
	^ self subThemeModel subTheme theme
]

{ #category : #accessing }
GtBlocThemeProperty >> valueAssignments [
	<return: #Collecton of: #GtBlocThemeValueAssignment>
	
	^ valueAssignments
]

{ #category : #accessing }
GtBlocThemeProperty >> valueAssignments: anObject [
	valueAssignments := anObject asOrderedCollection
]

{ #category : #'as yet unclassified' }
GtBlocThemeProperty >> valueType [
	^ GtBlocThemeTypedProperty detectTypeOf: self
]
