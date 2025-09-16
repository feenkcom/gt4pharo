Class {
	#name : #GtBaselineCreationForm,
	#superclass : #GtPharoCreationForm,
	#instVars : [
		'baseline'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtBaselineCreationForm class >> componentName [
	^ 'Baseline'
]

{ #category : #accessing }
GtBaselineCreationForm class >> priority [
	^ 4
]

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
		accessor: #baselineRope;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocCompletion: [ GtPharoCodeModifier current
				critical: [ GtStringsCompletionStrategy new
						completions: (GtPrefixTree withAll: Smalltalk classNames) ] ];
		addCondition: [ :aValue | aValue asString trim isNotEmpty ]
			labelled: 'Baseline name must be set';
		addCondition: [ :aValue | (Smalltalk classNamed: aValue asString trim) isNil ]
			labelled: 'Baseline name is already taken';
		addCondition: [ :aValue | aValue beginsWith: 'BaselineOf' ]
			labelled: 'Baseline name must start with BaselineOf';
		addCondition: [ :aValue | aValue asString isAllAlphaNumerics ]
			labelled: 'Baseline name must be alphanumeric';
		beRequired
]

{ #category : #accessing }
GtBaselineCreationForm >> baselineRope [
	^ self baseline asRopedText
		ifEmpty: [ self baseline asRopedText
				attribute: (self ghostTextFor: self defaultBaselineName) ]
]

{ #category : #accessing }
GtBaselineCreationForm >> baselineRope: aRope [
	self baseline: aRope asString
]

{ #category : #callbacks }
GtBaselineCreationForm >> commit [
	^ Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: baseline trim;
				superclass: BaselineOf;
				category: baseline trim ]
]

{ #category : #accessing }
GtBaselineCreationForm >> defaultBaselineName [
	^ 'BaselineOfExample'
]

{ #category : #magritte }
GtBaselineCreationForm >> hasPackageAndTag [
	^ false
]

{ #category : #accessing }
GtBaselineCreationForm >> initialize [
	baseline := ''
]

{ #category : #magritte }
GtBaselineCreationForm >> packageAndTagDescription [
	"empty"
	^ nil
]
