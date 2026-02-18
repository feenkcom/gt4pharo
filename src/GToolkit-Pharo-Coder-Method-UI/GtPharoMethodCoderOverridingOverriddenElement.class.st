Class {
	#name : #GtPharoMethodCoderOverridingOverriddenElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithPharoMethodCoderViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithPharoMethodCoderViewModel classTrait',
	#instVars : [
		'methodOrigin',
		'inheritanceButton',
		'currentIcon'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #'private - insance creation' }
GtPharoMethodCoderOverridingOverriddenElement >> createOverridenBySummaryElementFor: aMethodOrigin [
	^ BrHorizontalPane new
		fitContent;
		cellSpacing: 5;
		alignCenterLeft;
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'Overridden by');
		addChild: (self newMethodsCountButton
				id: GtMethodCoderOverriddenAmountId;
				action: [ self phlow
						spawnObject: (GtSearchOverridingMethodsFilter new method: aMethodOrigin method) ];
				withAsyncSinkDo: [ :anElementSink | anElementSink forwardStream: aMethodOrigin overridingMethods ])
]

{ #category : #'private - insance creation' }
GtPharoMethodCoderOverridingOverriddenElement >> createOverridesSummaryElementFor: aMethodOrigin [
	^ BrHorizontalPane new
		fitContent;
		cellSpacing: 5;
		alignCenterLeft;
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'Overrides');
		addChild: (self newMethodsCountButton
				id: GtMethodCoderOverridesAmountId;
				action: [ self phlow
						spawnObject: (GtSearchOverriddenMethodsFilter new method: aMethodOrigin method) ];
				withAsyncSinkDo: [ :anElementSink | anElementSink forwardStream: aMethodOrigin overriddenMethods ])
]

{ #category : #initialization }
GtPharoMethodCoderOverridingOverriddenElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
GtPharoMethodCoderOverridingOverriddenElement >> initialize [
	super initialize.

	self fitContent.
	self id: GtMethodCoderOverridingOverriddenId.
	inheritanceButton := nil.
	currentIcon := #none.

	self withAsyncFutureDo: [ :anElementFuture |
		anElementFuture
			executionConfiguration: (GtSingleCoderViewModel secondaryMethodAddOnsExecutionConfiguration);
			whenSuccess: [ :anElement :anOrigin |
				self updateFromOrigin:  anOrigin ];
			whenError: [ :anElement :anError |
				self removeChildren.
				self visibility: BlVisibility visible.
				anElement addChild: anError asDebuggableElement ];
			whenPending: [ 
				"Preserve the existing visibility while pending to avoid flickering while typing" ] ]
]

{ #category : #'private - insance creation' }
GtPharoMethodCoderOverridingOverriddenElement >> newInheritanceButton [
	^ BrButton new
		vFitContent;
		hExact: 16;
		aptitude: BrGlamorousButtonFlatExteriorAptitude 
			+ BrGlamorousButtonIconAptitude 
			+ (BrGlamorousButtonRectangularAptitude 
					paddingScale: 0
					heightScale: 0.7
					cornerRadius: 3);
		addAptitude: (BrGlamorousWithExplicitDropdownAptitude
			handle: [ BlElement new size: 16@16 ]
			content: [ self newInheritanceDropdownContent 
				withAsyncPromiseDo: [ :anElementPromise | 
					anElementPromise promise: self newMethodOriginFuture ]])
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
						ifTrue: [ aContainer addChild: (self 
							createOverridenBySummaryElementFor: aMethodOrigin) ].
					aMethodOrigin isOverriding
						ifTrue: [ aContainer addChild: (self 
							createOverridesSummaryElementFor: aMethodOrigin) ] ] ]
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
				whenSuccess: [ :aButton :aSink | 
					aButton label: aSink count asString, ' ', ('method' asPluralBasedOn: aSink count) ];
				whenPending: [ :aButton :aSink | 
					aButton label: aSink count asString, ' ', ('method' asPluralBasedOn: aSink count), '...' ] ]
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodCoderOverridingOverriddenElement >> onPharoMethodCoderViewModelChanged [
	"Is sent when a new pharoMethodCoderViewModel is assigned to the receiver.
	Note: #onPharoMethodCoderViewModelChanged is sent before #subscribeToPharoMethodCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoMethodCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	 
	self pharoMethodCoderViewModel coderModel
		attributeNamed: #cachedMethodOrigin
		ifPresent: [ :aMethodOrigin |
			self updateFromOrigin:  aMethodOrigin ] 
		ifAbsent: [ ].
			 
	self asyncFuture future: (self newMethodOriginFuture then: [ :anOrigin |
		| currentCoder |
		currentCoder := self pharoMethodCoderViewModel coderModel.
		currentCoder critical: [
			currentCoder attributeNamed: #cachedMethodOrigin put: anOrigin ].
		anOrigin ])
]

{ #category : #updating }
GtPharoMethodCoderOverridingOverriddenElement >> updateFromOrigin: anOrigin [
	anOrigin isSameOrigin
		ifFalse: [ ^ self visibility: BlVisibility gone ].
	
	(anOrigin isOverriding or: [ anOrigin isOverridden ])
		ifTrue: [			
			inheritanceButton ifNil: [
				inheritanceButton := self newInheritanceButton.
				self addChild: inheritanceButton.
				inheritanceButton ].

			self updateIconForButton: inheritanceButton usingOrigin: anOrigin.

			self visibility: BlVisibility visible ]
		ifFalse: [ 
			self visibility: BlVisibility gone ] 
]

{ #category : #updating }
GtPharoMethodCoderOverridingOverriddenElement >> updateIconForButton: aButton overriding: isOverriding overridden: isOverridden [
	(isOverriding and: [ isOverridden ])
		ifTrue: [		
			currentIcon = #both
				ifFalse: [
					aButton icon: BrGlamorousVectorIcons upwardsDownwards.
					currentIcon := #both ] ]
		ifFalse: [ 
			isOverriding 
				ifTrue: [
					currentIcon = #overriding
						ifFalse: [
							aButton icon: BrGlamorousVectorIcons upwards.
							currentIcon := #overriding ] ].
			isOverridden
				ifTrue: [
					currentIcon = #overridden
						ifFalse: [
							aButton icon: BrGlamorousVectorIcons downwards.
							currentIcon := #overridden ] ] ]
]

{ #category : #updating }
GtPharoMethodCoderOverridingOverriddenElement >> updateIconForButton: aButton usingOrigin: anOrigin [			
	self
		updateIconForButton: aButton
		overriding: anOrigin isOverriding
		overridden: anOrigin isOverridden
]
