Class {
	#name : #GtPharoMethodTestCaseStateElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'testCase',
		'styleLook'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'private - event handling' }
GtPharoMethodTestCaseStateElement >> debugTestCaseFrom: aButton [

	self testCaseDo: [ :aTestCase | aTestCase debug ]
]

{ #category : #initialization }
GtPharoMethodTestCaseStateElement >> initialize [
	super initialize.
	self initializeViewModels.

	self 
		layout: BlLinearLayout horizontal;
		geometry: BlRectangleGeometry new;
		margin: (BlInsets all: 1);
		exact: 12@12.
		
	self initializeInteractiveLook.
	"self initializeTooltipLook."
	self addAptitude: BrLayoutResizerAptitude inherit.
]

{ #category : #initialization }
GtPharoMethodTestCaseStateElement >> initializeInteractiveLook [
	self addAptitude: (styleLook := BrStyleCommonAptitude new).
	self updateStyleLook.
]

{ #category : #initialization }
GtPharoMethodTestCaseStateElement >> initializeViewModels [
	| aButtonModel |
	
	aButtonModel := BrButtonModel new
		action: [ :aButton | self onClick: aButton ].
	self viewModel: aButtonModel.
]

{ #category : #'private - event handling' }
GtPharoMethodTestCaseStateElement >> onClick: aButton [

	self testCaseDo: [ :aTestCase | 
		true ifTrue: [ ^ self spawnTestResultFrom: aButton ].
		aTestCase isPassed ifTrue: [ ^ self spawnTestResultFrom: aButton ].
		self debugTestCaseFrom: aButton ]
]

{ #category : #'private - hooks' }
GtPharoMethodTestCaseStateElement >> onTestCaseChanged [

	self updateElement
]

{ #category : #accessing }
GtPharoMethodTestCaseStateElement >> onTestCaseResultChanged: aGtPharoMethodTestResultChanged [

	BlUseAsyncFeatures
		ifEnabledDo: [ 
		self enqueueTask: (BlTaskAction new action: [ self updateElement ]) ]
		otherwise: [ self updateElement ]
]

{ #category : #'private - event handling' }
GtPharoMethodTestCaseStateElement >> spawnTestResultFrom: anElement [

	self testResultDo: [ :aTestResult | 
		anElement phlow spawnObject: aTestResult ]
]

{ #category : #'private - subscriptions' }
GtPharoMethodTestCaseStateElement >> subscribeToTestCase [
	self testCase weak 
		when: GtPharoMethodTestResultChanged
		send: #onTestCaseResultChanged:
		to: self
]

{ #category : #accessing }
GtPharoMethodTestCaseStateElement >> testCase [
	<return: #GtPharoMethodTestCase>
	^ testCase
]

{ #category : #accessing }
GtPharoMethodTestCaseStateElement >> testCase: aTestCase [

	self
		assert: [ aTestCase isNotNil ]
		description: [ 'Test case must be non-nil' ].
		
	self unsubscribeFromTestCase.
	testCase := aTestCase.
	
	self onTestCaseChanged.
	self subscribeToTestCase.
]

{ #category : #'private - accessing' }
GtPharoMethodTestCaseStateElement >> testCaseDo: aBlock [ 
	self testCase ifNotNil: aBlock
]

{ #category : #'private - accessing' }
GtPharoMethodTestCaseStateElement >> testCaseState [

	self testCaseDo: [ :aTestCase | ^ aTestCase state ].
	^ GtPharoMethodNotExecutedState default
]

{ #category : #accessing }
GtPharoMethodTestCaseStateElement >> testResult [
	<return: #TestResult>
	^ nil
]

{ #category : #'private - accessing' }
GtPharoMethodTestCaseStateElement >> testResultDo: aBlock [

	self testCaseDo: [ :aTestCase | 
		aTestCase result ifNotNil: aBlock ]
]

{ #category : #'private - subscriptions' }
GtPharoMethodTestCaseStateElement >> unsubscribeFromTestCase [
	testCase ifNotNil: [ :aTestCase | aTestCase unsubscribe: self ]
]

{ #category : #'private - updating' }
GtPharoMethodTestCaseStateElement >> updateElement [

	self background: self testCaseState color.
	self updateStyleLook
]

{ #category : #'private - updating' }
GtPharoMethodTestCaseStateElement >> updateStyleLook [
	
	styleLook
		default: [ :aStyle | aStyle background: self testCaseState color ];
		hovered: [ :aStyle | aStyle background: self testCaseState color darker ].
]
