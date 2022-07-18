Class {
	#name : #GtPharoMethodCoderOverridingOverriddenElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithPharoMethodCoderViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithPharoMethodCoderViewModel classTrait',
	#instVars : [
		'methodOrigin'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #initialization }
GtPharoMethodCoderOverridingOverriddenElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
GtPharoMethodCoderOverridingOverriddenElement >> initialize [
	super initialize.

	self fitContent.
	self id: GtMethodCoderOverridingOverriddenId.

	self withAsyncFutureDo: [ :anElementFuture |
		anElementFuture
			executionConfiguration: (AsyncFutureExecutionConfiguration new customGroup: #CoderAddOn; lowPriority);
			whenSuccess: [ :anElement :anOrigin |
				self removeChildren.

				anOrigin isSameOrigin
					ifTrue: [
						(anOrigin isOverriding or: [ anOrigin isOverridden ])
							ifTrue: [
								| aButton |
								
								aButton := self newInheritanceButton.
								
								(anOrigin isOverriding and: [ anOrigin isOverridden ])
									ifTrue: [ aButton icon: BrGlamorousVectorIcons upwardsDownwards ]
									ifFalse: [
										anOrigin isOverriding
											ifTrue: [ aButton icon: BrGlamorousVectorIcons upwards ].
										anOrigin isOverridden
											ifTrue: [ aButton icon: BrGlamorousVectorIcons downwards ] ].
								self addChild: aButton.
								self visibility: BlVisibility visible ]
							ifFalse: [ self visibility: BlVisibility gone ] ] ];
			whenError: [ :anElement :anError |
				self removeChildren.
				self visibility: BlVisibility visible.
				anElement addChild: anError asDebuggableElement ];
			whenPending: [ self visibility: BlVisibility gone ] ]
]

{ #category : #'private - insance creation' }
GtPharoMethodCoderOverridingOverriddenElement >> newInheritanceButton [
	^ BrButton new
		vFitContent;
		hExact: 18;
		aptitude: BrGlamorousButtonFlatExteriorAptitude + BrGlamorousButtonIconAptitude + (BrGlamorousButtonRectangularAptitude cornerRadius: 3);
		addAptitude: (BrGlamorousWithDropdownAptitude
			handle: [ BlElement new size: 18@18 ]
			content: [ self newInheritanceDropdownContent withAsyncPromiseDo: [ :anElementPromise | anElementPromise promise: self newMethodOriginFuture ]])
]

{ #category : #'private - insance creation' }
GtPharoMethodCoderOverridingOverriddenElement >> newInheritanceDropdownContent [
	^ BrVerticalPane new
		fitContent;
		padding: (BlInsets all: 5);
		cellSpacing: 5;
		withAsyncPromiseDo: [ :anElementPromise | 
			anElementPromise
				whenSuccess: [ :aContainer :aMethodOrigin | 
					aMethodOrigin isOverridden
						ifTrue: [ aContainer
								addChild: (BrHorizontalPane new
										fitContent;
										cellSpacing: 5;
										alignCenterLeft;
										addChild: (BrLabel new text: 'Overridden by');
										addChild: (self newMethodsCountButton
												id: GtMethodCoderOverriddenAmountId;
												action: [ self phlow
														spawnObject: (GtPharoMethodsCoderView new
																filter: (GtSearchOverridingMethodsFilter new method: aMethodOrigin method)) ];
												withAsyncSinkDo: [ :anElementSink | anElementSink forwardStream: aMethodOrigin overridingMethods ])) ].

					aMethodOrigin isOverriding
						ifTrue: [ aContainer
								addChild: (BrHorizontalPane new
										fitContent;
										cellSpacing: 5;
										alignCenterLeft;
										addChild: (BrLabel new text: 'Overrides');
										addChild: (self newMethodsCountButton
												id: GtMethodCoderOverridesAmountId;
												action: [ self phlow
														spawnObject: (GtPharoMethodsCoderView new
																filter: (GtSearchOverriddenMethodsFilter new method: aMethodOrigin method)) ];
												withAsyncSinkDo: [ :anElementSink | anElementSink forwardStream: aMethodOrigin overriddenMethods ])) ] ] ]
]

{ #category : #'private - insance creation' }
GtPharoMethodCoderOverridingOverriddenElement >> newMethodOriginFuture [
	| aMethodOrigin |
	
	aMethodOrigin := pharoMethodCoderViewModel methodOrigin.
	
	^ aMethodOrigin isSameOrigin
		ifTrue: [ aMethodOrigin withInheritance ]
		ifFalse: [ aMethodOrigin asAsyncFuture ]
]

{ #category : #'private - insance creation' }
GtPharoMethodCoderOverridingOverriddenElement >> newMethodsCountButton [
	^ BrButton new
		aptitude: BrGlamorousLinkButtonWithLabelAptitude;
		label: '0 methods...';
		beSmallSize;
		withAsyncSinkDo: [ :anElementSink |
			anElementSink
				sink: AsyncCounterSink new;
				whenSuccess: [ :aButton :aSink | aButton label: aSink count asString, ' ', ('method' asPluralBasedOn: aSink count) ];
				whenPending: [ :aButton :aSink | aButton label: aSink count asString, ' ', ('method' asPluralBasedOn: aSink count), '...' ] ]
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodCoderOverridingOverriddenElement >> onPharoMethodCoderViewModelChanged [
	"Is sent when a new pharoMethodCoderViewModel is assigned to the receiver.
	Note: #onPharoMethodCoderViewModelChanged is sent before #subscribeToPharoMethodCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoMethodCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>

	self asyncFuture future: self newMethodOriginFuture
]
