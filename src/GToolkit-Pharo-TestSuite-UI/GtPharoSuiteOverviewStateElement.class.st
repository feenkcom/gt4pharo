Class {
	#name : #GtPharoSuiteOverviewStateElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'icon',
		'name',
		'amount',
		'state'
	],
	#category : 'GToolkit-Pharo-TestSuite-UI-! Views'
}

{ #category : #initialization }
GtPharoSuiteOverviewStateElement >> initialize [
	super initialize.
	
	self
		hMatchParent;
		vFitContent;
		alignCenterLeft.

	icon := GtPharoTestCaseUtility newColoredIconWithMargin: BlBackground transparent.
	name := BrLabel new
		aptitude: BrGlamorousLabelAptitude.

	amount := BrLabel new
		id: GtPharoSuiteStateAmountLabelId;
		aptitude: BrGlamorousLabelAptitude;
		text: '0';
		withAsyncSinkDo: [ :anElementSink |
			anElementSink
				sink: AsyncCounterSink new;
				whenPending: [ :aLabel :aSink | aLabel text: aSink count ] ].

	self asyncSink sink: amount asyncSink.

	self addChildren: { icon . name . amount }
]

{ #category : #'api - accessing' }
GtPharoSuiteOverviewStateElement >> state [
	^ state
]

{ #category : #'api - accessing' }
GtPharoSuiteOverviewStateElement >> state: aState [
	state := aState.

	icon background: aState color.
	name text: (aState label, ':')
]
