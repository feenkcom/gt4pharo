"
I represent a {{gtClass:GtPharoMethodTestCaseState}}   of {{gtClass:GtPharoMethodTestCase}}.
I render an icon that represents the state.
I use {{gtClass:GtPharoMethodTestCaseTooltipBuilder}} to build tooltips.
#Examples
##Not Executed Test Case Icon
{{gtExample:GtPharoMethodTestCaseStateElementExamples >> #stateElement_NotExecuted | codeExpanded=false | previewExpanded=true | previewHeight= 100 | previewShow=#gtLiveFor:}}
#Passes Test Case Icon
{{gtExample:GtPharoMethodTestCaseStateElementExamples >> #stateElement_Success | codeExpanded=false | previewExpanded=true | previewHeight= 100 | previewShow=#gtLiveFor:}}
"
Class {
	#name : #GtPharoMethodTestCaseStateElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'testCase',
		'styleLook'
	],
	#category : #'GToolkit-Pharo-TestSuite-UI-! Views'
}

{ #category : #'private - instance creation' }
GtPharoMethodTestCaseStateElement >> hasResult [
	self testResultDo: [ :aTestResult | ^ true ].
	^ false
]

{ #category : #initialization }
GtPharoMethodTestCaseStateElement >> initialize [
	super initialize.
	self initializeViewModels.

	self 
		layout: BlLinearLayout horizontal;
		geometry: BlSquareGeometry new;
		margin: (BlInsets all: 1);
		exact: 12@12.
		
	self initializeInteractiveLook.
	self initializeTooltipLook.
]

{ #category : #initialization }
GtPharoMethodTestCaseStateElement >> initializeInteractiveLook [
	self addAptitude: (styleLook := BrStyleCommonAptitude new).
	self updateStyleLook.
]

{ #category : #initialization }
GtPharoMethodTestCaseStateElement >> initializeTooltipLook [
	self addAptitude:
		(BrGlamorousWithExplicitTooltipAptitude content: [
			self newTooltipContent ])
]

{ #category : #initialization }
GtPharoMethodTestCaseStateElement >> initializeViewModels [
	| aButtonModel |
	
	aButtonModel := BrButtonModel new
		action: [ :aButton | self onClick: aButton ].
	self viewModel: aButtonModel.
]

{ #category : #'private - instance creation' }
GtPharoMethodTestCaseStateElement >> newTooltipContent [

	^ GtPharoMethodTestCaseTooltipBuilder new
		  element: self;
		  testCase: self testCase;
		  state: self testCaseState;
		  result: self testResult;
		  build
]

{ #category : #'private - event handling' }
GtPharoMethodTestCaseStateElement >> onClick: aButton [

	self spawnTestResultFrom: aButton
]

{ #category : #'private - hooks' }
GtPharoMethodTestCaseStateElement >> onTestCaseChanged [

	self updateElement
]

{ #category : #'private - event handling' }
GtPharoMethodTestCaseStateElement >> onTestCaseResultChanged: aGtPharoMethodTestResultChanged [

	BlUseAsyncFeatures
		ifEnabledDo: [ 
		self enqueueTask: (BlTaskAction new action: [ self updateResult ]) ]
		otherwise: [ self updateResult ]
]

{ #category : #'private - event handling' }
GtPharoMethodTestCaseStateElement >> onTestCaseStateChanged: aGtPharoMethodTestCaseStateChanged [
	
	BlUseAsyncFeatures
		ifEnabledDo: [ 
		self enqueueTask: (BlTaskAction new action: [ self updateState ]) ]
		otherwise: [ self updateState ]
]

{ #category : #'private - actions' }
GtPharoMethodTestCaseStateElement >> spawnTestResultFrom: anElement [

	self testResultDo: [ :aTestResult | 
		anElement phlow spawnObject: aTestResult ]
]

{ #category : #'private - subscriptions' }
GtPharoMethodTestCaseStateElement >> subscribeToTestCase [
	self testCase 
		when: GtPharoMethodTestResultChanged
			send: #onTestCaseResultChanged:
			to: self;
		when: GtPharoMethodTestCaseStateChanged
			send: #onTestCaseStateChanged:
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
	^ GtPharoMethodNotExecutedState
]

{ #category : #'private - accessing' }
GtPharoMethodTestCaseStateElement >> testResult [
	<return: #TestResult>
	self testResultDo: [ :aTestResult | ^ aTestResult ].
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

	self updateState.
	self updateResult.
]

{ #category : #'private - updating' }
GtPharoMethodTestCaseStateElement >> updateResult [
]

{ #category : #'private - updating' }
GtPharoMethodTestCaseStateElement >> updateState [

	self background: self testCaseState color.
	self updateStyleLook
]

{ #category : #'private - updating' }
GtPharoMethodTestCaseStateElement >> updateStyleLook [
	
	styleLook
		default: [ :aStyle | aStyle background: self testCaseState color ];
		hovered: [ :aStyle | aStyle background: self testCaseState color darker ].
]
