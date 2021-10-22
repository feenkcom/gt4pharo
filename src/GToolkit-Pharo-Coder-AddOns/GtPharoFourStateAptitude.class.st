Class {
	#name : #GtPharoFourStateAptitude,
	#superclass : #GtPharoMethodsCoderAptitude,
	#instVars : [
		'fourIconElement',
		'neutralIconElement',
		'errorIconElement',
		'failureIconElement',
		'passedIconElement',
		'oneIconElement'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> errorIconElement [

	^ errorIconElement
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> failureIconElement [

	^ failureIconElement
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> fourIconElement [
	^ fourIconElement
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initialize [

	super initialize.

	self initializeOneStateIconElement.
	self initializeFourStateIconElement.
	self initializeNeutralIconElement.
	self initializeErrorIconElement.
	self initializeFailureIconElement.
	self initializePassedIconElement.

	self fourIconElement addChild: self passedIconElement as: #passed.
	self fourIconElement addChild: self failureIconElement as: #failure.
	self fourIconElement addChild: self errorIconElement as: #error.
	self fourIconElement addChild: self neutralIconElement as: #neutral.

	self
		addChangeAddChildAs: #( content oneState )
		with: [ self oneIconElement ].
	self
		addChangeAddChildAs: #( content fourState )
		with: [ self fourIconElement ].
	
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializeErrorIconElement [

	errorIconElement := self newColoredIcon:
		                    GtPharoMethodTestCaseErrorState color
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializeFailureIconElement [

	failureIconElement := self newColoredIcon:
		                      GtPharoMethodTestCaseFailureState
			                      color
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializeFourStateIconElement [

	fourIconElement := BlElement new
		                   layout: (BlGridLayout new
				                    columnCount: 2;
				                    cellSpacing: 0);
		                   background: BlBackground transparent;
		                   constraintsDo: [ :c | 
			                   c horizontal fitContent.
			                   c vertical fitContent ]
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializeNeutralIconElement [

	neutralIconElement := self newColoredIcon:
		                      GtPharoMethodNotExecutedState color
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializeOneStateIconElement [
	oneIconElement := BlElement new
		  geometry: BlSquare new;
		  margin: (BlInsets all: 1);
		  size: 16 @ 16
]

{ #category : #initialization }
GtPharoFourStateAptitude >> initializePassedIconElement [

	passedIconElement := self newColoredIcon:
		                     GtPharoMethodTestCasePassedState color
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> neutralIconElement [

	^ neutralIconElement
]

{ #category : #initialization }
GtPharoFourStateAptitude >> newColoredIcon: aColor [

	^ GtPharoTestCaseUtility newColoredIcon: aColor
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> oneIconElement [

	^ oneIconElement
]

{ #category : #'private - accessing' }
GtPharoFourStateAptitude >> passedIconElement [

	^ passedIconElement
]
