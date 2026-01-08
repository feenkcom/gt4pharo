Class {
	#name : #GtPharoMethodSaveExistingQuestionElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithPharoMethodCoderViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithPharoMethodCoderViewModel classTrait',
	#instVars : [
		'questionElement',
		'confirmElement',
		'abortElement',
		'methodModificationIndicator'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support - Modification UI'
}

{ #category : #initialization }
GtPharoMethodSaveExistingQuestionElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtPharoMethodSaveExistingQuestionElement >> initialize [
	super initialize.
	self initializeQuestionElement.
	self initializeConfirmElement.
	self initializeAbortElement.
	self initializeSink.

	self addChild: questionElement as: #question.
	self
		addChild: (BrVerticalPane new
				fitContent;
				alignCenterLeft;
				margin: (BlInsets top: 5);
				addChild: confirmElement as: #confirm;
				addChild: abortElement as: #abort).

	questionElement padding: (BlInsets left: 5 right: 5).
	confirmElement padding: (BlInsets left: 5 right: 5).
	abortElement padding: (BlInsets left: 5 right: 5).
	self padding: (BlInsets top: 5 bottom: 5).

	self fitContent
]

{ #category : #initialization }
GtPharoMethodSaveExistingQuestionElement >> initializeAbortElement [
	abortElement := self newBasicButtonElement
			icon: BrGlamorousVectorIcons cancel;
			label: 'Abort to continue editing';
			action: [ :aButton | self onAbortToContinueEditing ]
]

{ #category : #initialization }
GtPharoMethodSaveExistingQuestionElement >> initializeConfirmElement [
	confirmElement := self newBasicButtonElement
			icon: BrGlamorousVectorIcons accept;
			label: 'Continue compiling';
			action: [ :aButton | self onContinueCompiling ]
]

{ #category : #initialization }
GtPharoMethodSaveExistingQuestionElement >> initializeQuestionElement [
	questionElement := BrLabel new
			fitContent;
			aptitude: BrGlamorousLabelAptitude new;
			text: 'There already exists a method'
]

{ #category : #initialization }
GtPharoMethodSaveExistingQuestionElement >> initializeSink [
	self
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :anElement :aSink | 
					aSink peek 
						ifSome: [ :aValue |
							self visibility: BlVisibility visible.
							self updateElementForIndicator: aSink value ]
						ifNone: [ 
							self visibility: BlVisibility hidden ] ] ]
]

{ #category : #initialization }
GtPharoMethodSaveExistingQuestionElement >> newBasicButtonElement [
	^ BrButton new
		beFocusable;
		alignCenterLeft;
		hMatchParent;
		vFitContent;
		aptitude: BrGlamorousButtonIconAptitude + (BrGlamorousButtonLabelAptitude - BrLazyStyleCommonAptitude)
				+ BrGlamorousButtonLayoutAptitude + BrGlamorousButtonFlatExteriorAptitude
]

{ #category : #'private - event handling' }
GtPharoMethodSaveExistingQuestionElement >> onAbortToContinueEditing [
	self fireEvent: BrDropdownHideWish new
]

{ #category : #'private - event handling' }
GtPharoMethodSaveExistingQuestionElement >> onContinueCompiling [
	methodModificationIndicator ifNil: [ ^ self ].
	self hasPharoMethodCoderViewModel ifFalse: [ ^ self ].
	self pharoMethodCoderViewModel saveIn: methodModificationIndicator behavior.
	self dispatchEvent: BrDropdownHideWish new
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodSaveExistingQuestionElement >> onPharoMethodCoderViewModelChanged [
	self updateElement
]

{ #category : #'private - updating' }
GtPharoMethodSaveExistingQuestionElement >> updateElement [
	| aStream |
	aStream := self pharoMethodCoderViewModel
			availableCompilationMethodIndicatorsWithBehaviorSources.
	self asyncSink forwardStream: aStream
]

{ #category : #'private - updating' }
GtPharoMethodSaveExistingQuestionElement >> updateElementForIndicator: anIndicator [
	methodModificationIndicator := anIndicator.
	questionElement text: ('There already exists a method called {1}' format: { anIndicator prospectiveSelector }).
	
	confirmElement label: ('Continue compiling in {1}' format: { anIndicator behaviorName }).
]
