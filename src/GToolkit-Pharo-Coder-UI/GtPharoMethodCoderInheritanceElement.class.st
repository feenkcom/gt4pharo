Class {
	#name : #GtPharoMethodCoderInheritanceElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TGtWithPharoMethodCoderViewModel',
	#classTraits : 'TBrLayoutResizable classTrait + TGtWithPharoMethodCoderViewModel classTrait',
	#instVars : [
		'methodOrigin'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #initialization }
GtPharoMethodCoderInheritanceElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
GtPharoMethodCoderInheritanceElement >> initialize [
	super initialize.

	self fitContent.

	self withAsyncPromiseDo: [ :anElementPromise |
		anElementPromise
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
								self addChild: aButton ] ] ];
			whenError: [ :anElement :anError |
				self removeChildren.
				anElement addChild: anError asDebuggableElement ];
			whenPending: [  ] ]
]

{ #category : #'private - insance creation' }
GtPharoMethodCoderInheritanceElement >> newInheritanceButton [
	^ BrButton new
		vFitContent;
		hExact: 18;
		aptitude: BrGlamorousButtonFlatExteriorAptitude + BrGlamorousButtonIconAptitude + (BrGlamorousButtonRectangularAptitude cornerRadius: 3);
		addAptitude: (BrGlamorousWithDropdownAptitude
			handle: [ BlElement new size: 18@18 ]
			content: [ self newInheritanceDropdownContent withAsyncPromiseDo: [ :anElementPromise | anElementPromise promise: self newMethodOriginFuture ]])
]

{ #category : #'private - insance creation' }
GtPharoMethodCoderInheritanceElement >> newInheritanceDropdownContent [
	^ BrVerticalPane new
		fitContent;
		padding: (BlInsets all: 5);
		cellSpacing: 5;
		withAsyncPromiseDo: [ :anElementPromise |
			anElementPromise
				whenSuccess: [ :aContainer :aMethodOrigin |
					aMethodOrigin isOverridden
						ifTrue: [
							aContainer addChild: (BrHorizontalPane new
								fitContent;
								cellSpacing: 5;
								alignCenterLeft;
								addChild: (BrLabel new
									aptitude: BrGlamorousLabelAptitude;
									text: 'Overridden by');
								addChild: (self newMethodsCountButton
									action: [ self phlow spawnObject: (GtPharoMethodsCoderView new filter: (GtSearchOverridingMethodsFilter new method: aMethodOrigin method)) ];
									withAsyncSinkDo: [ :anElementSink | (aMethodOrigin overridingMethods forward: anElementSink) asAsyncPromise ])) ].

					aMethodOrigin isOverriding
						ifTrue: [
							aContainer addChild: (BrHorizontalPane new
								fitContent;
								cellSpacing: 5;
								alignCenterLeft;
								addChild: (BrLabel new
									aptitude: BrGlamorousLabelAptitude;
									text: 'Overrides');
								addChild: (self newMethodsCountButton
									action: [ self phlow spawnObject: (GtPharoMethodsCoderView new filter: (GtSearchOverriddenMethodsFilter new method: aMethodOrigin method)) ];
									withAsyncSinkDo: [ :anElementSink | (aMethodOrigin overriddenMethods forward: anElementSink) asAsyncPromise ])) ] ] ]
]

{ #category : #'private - insance creation' }
GtPharoMethodCoderInheritanceElement >> newMethodOriginFuture [
	^ pharoMethodCoderViewModel coderModel methodOrigin
		then: [ :anOrigin |
			anOrigin isSameOrigin
				ifTrue: [ anOrigin withInheritance ]
				ifFalse: [ anOrigin ] ]
]

{ #category : #'private - insance creation' }
GtPharoMethodCoderInheritanceElement >> newMethodsCountButton [
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
GtPharoMethodCoderInheritanceElement >> onPharoMethodCoderViewModelChanged [
	"Is sent when a new pharoMethodCoderViewModel is assigned to the receiver.
	Note: #onPharoMethodCoderViewModelChanged is sent before #subscribeToPharoMethodCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoMethodCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>

	self asyncPromise promise: self newMethodOriginFuture asAsyncPromise
]
