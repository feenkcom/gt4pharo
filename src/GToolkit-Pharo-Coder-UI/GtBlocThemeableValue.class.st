Class {
	#name : #GtBlocThemeableValue,
	#superclass : #Object,
	#instVars : [
		'subThemeModel',
		'valueName',
		'valueAssignments',
		'themeableValue',
		'issues'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'ast  - analysis' }
GtBlocThemeableValue >> doesAstUseConstantGetter: anAst [
	anAst nodesDo: [ :eachNode |
		(eachNode isMessageSend and: [ eachNode receiver isSelf and: [ eachNode selector = #constantAt: ] ])
			ifTrue: [ ^ true ] ].
			
	^ false
]

{ #category : #'ast  - analysis' }
GtBlocThemeableValue >> hardcodedValueAssignments [
	| valueType |
	
	valueType := self valueType.
	^ self valueAssignments reject: [ :eachAssignment |
		| anAst |
		anAst := valueType simplifiedAssignmentAst: eachAssignment.
		self doesAstUseConstantGetter: anAst ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeableValue >> issues [
	issues ifNotNil: [ :theIssues | ^ theIssues ].
	
	issues := Array streamContents: [ :s | self issuesOn: s ].
	^ issues
]

{ #category : #'as yet unclassified' }
GtBlocThemeableValue >> issuesOn: aStream [
	self valueAssignments
		ifEmpty: [ aStream nextPut: (GtBlocThemeValueNotAssignedIssue new themeableValue: self) ].

	self valueType isUnknownType
		ifTrue: [ aStream nextPut: (GtBlocThemeValueNotThemeableIssue new themeableValue: self) ].
		
	self hardcodedValueAssignments do: [ :eachAssignment |
		aStream nextPut: (GtBlocThemeValueHardcodedIssue new themeableValue: self; valueAssignment: eachAssignment) ]
]

{ #category : #accessing }
GtBlocThemeableValue >> printShortThemeableValue [
	| article className |
	
	className := self themeableValue class name.
	article := className first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ].
	
	^ '{1} {2}' format: { article . className }
]

{ #category : #accessing }
GtBlocThemeableValue >> subThemeModel [
	^ subThemeModel
]

{ #category : #accessing }
GtBlocThemeableValue >> subThemeModel: anObject [
	subThemeModel := anObject
]

{ #category : #accessing }
GtBlocThemeableValue >> themeableValue [
	^ themeableValue
]

{ #category : #accessing }
GtBlocThemeableValue >> themeableValue: anObject [
	themeableValue := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemeableValue >> validateSourceCode [
	
]

{ #category : #'as yet unclassified' }
GtBlocThemeableValue >> valueAssignmentSourceCodeOf: aValueAssignment [
	^ (self valueType simplifiedAssignmentAst: aValueAssignment) source
]

{ #category : #accessing }
GtBlocThemeableValue >> valueAssignments [
	<return: #Collecton of: #GtBlocThemeableValueAssignment>
	
	^ valueAssignments
]

{ #category : #accessing }
GtBlocThemeableValue >> valueAssignments: anObject [
	valueAssignments := anObject asOrderedCollection
]

{ #category : #accessing }
GtBlocThemeableValue >> valueName [
	^ valueName
]

{ #category : #accessing }
GtBlocThemeableValue >> valueName: anObject [
	valueName := anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemeableValue >> valueType [
	^ GtBlocThemeableValueType detectTypeOf: self
]
