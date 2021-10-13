Class {
	#name : #GtPharoMethodTestCaseTooltipBuilder,
	#superclass : #Object,
	#traits : 'TGtPharoMethodTestCaseVisitor',
	#classTraits : 'TGtPharoMethodTestCaseVisitor classTrait',
	#instVars : [
		'state',
		'result',
		'element'
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
GtPharoMethodTestCaseTooltipBuilder >> visitTestCaseState: aState [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude new;
		text: 'Test Result Indicator';
		fitContent
]
