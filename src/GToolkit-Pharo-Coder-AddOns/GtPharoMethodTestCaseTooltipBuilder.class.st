"
I build a tooltip for {{gtClass:GtPharoMethodTestCaseStateElement}}.

"
Class {
	#name : #GtPharoMethodTestCaseTooltipBuilder,
	#superclass : #Object,
	#traits : 'TGtPharoMethodTestCaseVisitor',
	#classTraits : 'TGtPharoMethodTestCaseVisitor classTrait',
	#instVars : [
		'state',
		'result',
		'element',
		'testCase'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #building }
GtPharoMethodTestCaseTooltipBuilder >> build [
	^ self state accept: self
]

{ #category : #accessing }
GtPharoMethodTestCaseTooltipBuilder >> element [
	^ element
]

{ #category : #accessing }
GtPharoMethodTestCaseTooltipBuilder >> element: anElement [
	element := anElement
]

{ #category : #accessing }
GtPharoMethodTestCaseTooltipBuilder >> result [
	^ result
]

{ #category : #accessing }
GtPharoMethodTestCaseTooltipBuilder >> result: aTestResult [
	result := aTestResult
]

{ #category : #accessing }
GtPharoMethodTestCaseTooltipBuilder >> state [
	^ state
]

{ #category : #accessing }
GtPharoMethodTestCaseTooltipBuilder >> state: aTestCaseState [
	state := aTestCaseState
]

{ #category : #accessing }
GtPharoMethodTestCaseTooltipBuilder >> testCase [
	^ testCase
]

{ #category : #accessing }
GtPharoMethodTestCaseTooltipBuilder >> testCase: aTestCase [
	testCase := aTestCase
]

{ #category : #visiting }
GtPharoMethodTestCaseTooltipBuilder >> visitTestCaseNotExecutedState: aState [

	^ BrVerticalPane new
		  fitContent;
		  alignCenter;
		  padding: (BlInsets all: 5);
		  addChild: (BrLabel new
				   aptitude: BrGlamorousLabelAptitude new;
				   margin: (BlInsets bottom: 5);
				   text: 'Not Executed Test Case';
				   fitContent);
		addChild: (BrHorizontalPane new
			fitContent;
			addChild: (BrButton new 
				beTinySize;
				aptitude: BrGlamorousButtonWithIconAptitude;
				margin: (BlInsets right: 5);
				icon: BrGlamorousVectorIcons play;
				label: 'Play Unit Test';
				action: [ :aButton | self testCase play ]);
			addChild: (BrButton new 
				beTinySize; 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons debug;
				label: 'Debug Unit Test';
				action: [ :aButton | self testCase debug ]))
]

{ #category : #visiting }
GtPharoMethodTestCaseTooltipBuilder >> visitTestCaseResultState: aState [

	| aContainer |
	aContainer := BrFrame new
		              fitContent;
		              when: GtPhlowObjectToSpawn do: [ :anEvent | 
			              self element fireEvent: (GtPhlowObjectToSpawn new
						               object: anEvent object;
						               sourceElement: anEvent target) ].
	aContainer addChild:
		(((GtInspector forObject: self result) exact: 400 @ 400)
			 asScalableElement size: 200 @ 200).
	^ aContainer
]

{ #category : #visiting }
GtPharoMethodTestCaseTooltipBuilder >> visitTestCaseSkippedState: aState [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude new;
		text: 'Skipped Test Unit';
		fitContent
]

{ #category : #visiting }
GtPharoMethodTestCaseTooltipBuilder >> visitTestCaseState: aState [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude new;
		text: 'Test Result Indicator';
		fitContent
]
