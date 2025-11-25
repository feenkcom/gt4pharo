Class {
	#name : #GtPharoSuiteFourStateElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithPharoSuiteViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithPharoSuiteViewModel classTrait',
	#instVars : [
		'fourIconElement',
		'passedIconElement',
		'failureIconElement',
		'errorIconElement',
		'neutralIconElement',
		'oneIconElement'
	],
	#category : 'GToolkit-Pharo-TestSuite-UI-! Views'
}

{ #category : #initialization }
GtPharoSuiteFourStateElement >> initialize [
	super initialize.
	
	self layout: BlFrameLayout new.
	self fitContent.
	
	passedIconElement := self newPassedIconElement.
	errorIconElement := self newErrorIconElement.
	failureIconElement := self newFailureIconElement.
	neutralIconElement := self newNeutralIconElement.

	oneIconElement := self newOneStateIconElement.
	fourIconElement := self newFourStateIconElement.
	
	fourIconElement addChild: passedIconElement.
	fourIconElement addChild: failureIconElement.
	fourIconElement addChild: errorIconElement.
	fourIconElement addChild: neutralIconElement.
	
	self addChildren: { 
		oneIconElement.
		fourIconElement
	}
]

{ #category : #'private - instance creation' }
GtPharoSuiteFourStateElement >> newColoredIcon: aColor [
	^ GtPharoTestCaseUtility newColoredIcon: aColor
]

{ #category : #'private - instance creation' }
GtPharoSuiteFourStateElement >> newErrorIconElement [
	^ self newColoredIcon: GtPharoMethodTestCaseErrorState color
]

{ #category : #'private - instance creation' }
GtPharoSuiteFourStateElement >> newFailureIconElement [
	^ self newColoredIcon: GtPharoMethodTestCaseFailureState color
]

{ #category : #'private - instance creation' }
GtPharoSuiteFourStateElement >> newFourStateIconElement [
	^ BlElement new
		layout: (BlGridLayout new
			columnCount: 2;
			cellSpacing: 0);
		background: BlBackground transparent;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ]
]

{ #category : #'private - instance creation' }
GtPharoSuiteFourStateElement >> newNeutralIconElement [
	^ self newColoredIcon: GtPharoMethodNotExecutedState color
]

{ #category : #'private - instance creation' }
GtPharoSuiteFourStateElement >> newOneStateIconElement [
	^ BlElement new
		  geometry: BlSquareGeometry new;
		  margin: (BlInsets all: 1);
		  size: 16 @ 16
]

{ #category : #'private - instance creation' }
GtPharoSuiteFourStateElement >> newPassedIconElement [
	^ self newColoredIcon: GtPharoMethodTestCasePassedState color
]
