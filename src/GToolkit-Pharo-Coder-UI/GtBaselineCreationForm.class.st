"
nil
"
Class {
	#name : #GtBaselineCreationForm,
	#superclass : #GtCreationForm,
	#instVars : [
		'baseline'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtBaselineCreationForm >> baseline [

	^ baseline
]

{ #category : #accessing }
GtBaselineCreationForm >> baseline: anObject [

	baseline := anObject
]

{ #category : #magritte }
GtBaselineCreationForm >> baselineDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Baseline';
		priority: 1;
		accessor: #baseline;
		blocCompletion: [ GtStringsCompletionStrategy new
				completions: (GtPrefixTree withAll: (Smalltalk allClasses collect: #name)) ];
		addCondition: [ :aValue | aValue trim isNotEmpty ]
			labelled: 'Baseline name must be set';
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNil ]
			labelled: 'Baseline name is already taken';
		addCondition: [ :aValue | aValue ifEmpty: [ true ] ifNotEmpty: [ aValue first isUppercase ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue isAllAlphaNumerics ]
			labelled: 'Class name must be alphanumeric'
]

{ #category : #accessing }
GtBaselineCreationForm >> commit [
	^ Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: baseline trim;
				superclass: BaselineOf;
				category: baseline trim ]
]

{ #category : #accessing }
GtBaselineCreationForm >> initialize [
	baseline := ''
]

{ #category : #accessing }
GtBaselineCreationForm >> packageAndTagDescription [
	"empty"
	^ nil
]
