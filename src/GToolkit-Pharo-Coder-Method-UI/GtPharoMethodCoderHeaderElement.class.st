"
# Pharo Method Coder Header 


{{gtExample:GtMethodCoderHeaderElementExamples>>#headerForMethodFromClass|previewExpanded|previewShow=#gtLiveFor:|codeExpanded=false|previewHeight=60}}

"
Class {
	#name : #GtPharoMethodCoderHeaderElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithTextualCoderViewModel',
	#classTraits : 'TGtWithTextualCoderViewModel classTrait',
	#instVars : [
		'packageButton',
		'headerCoderModel',
		'methodBehaviourButton',
		'providerBehaviorButton',
		'methodBehaviourIconContainer',
		'methodBehaviourContainer',
		'providerBehaviorIconContainer'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #accessing }
GtPharoMethodCoderHeaderElement >> behaviorButton [
	^ providerBehaviorButton
]

{ #category : #initialization }
GtPharoMethodCoderHeaderElement >> buildSeparatorElement [
	^ BrLabel new
			aptitude: (BrGlamorousLabelAptitude new thin 
				padding: (BlInsets all:0 );
				foreground: self theme label metadataTextForeground);
			text: '>'.
]

{ #category : #initialization }
GtPharoMethodCoderHeaderElement >> initialize [
	super initialize.
	self initializeWidget
]

{ #category : #initialization }
GtPharoMethodCoderHeaderElement >> initializeWidget [
	self fitContent.
	self alignCenterLeft.
	packageButton := self newPackageButton.
	providerBehaviorButton := self newProviderBehaviorButton.
	providerBehaviorIconContainer := self newIconContainer.
	self addChild: packageButton as: GtPharoHeaderPackageId.
	self
		addChild: (self buildSeparatorElement margin: (BlInsets left: 5 right: 5))
		as: #separatorElement.
	self addChild: providerBehaviorButton as: GtPharoHeaderProviderBehaviorId.
	self addChild: providerBehaviorIconContainer as: #iconContainer.
	self addChild: (methodBehaviourContainer := (BrHorizontalPane new)
						fitContent;
						alignCenterLeft;
						addChild: (self buildSeparatorElement text: '(');
						addChild: (methodBehaviourButton := self newMethodBehaviorButton)
							as: GtPharoHeaderMethodBehaviorId;
						addChild: (methodBehaviourIconContainer := self newIconContainer);
						addChild: (self buildSeparatorElement text: ')'))
]

{ #category : #initialization }
GtPharoMethodCoderHeaderElement >> newIconContainer [
	^ BrFrame new
		fitContent;
		layout: BlFrameLayout new
]

{ #category : #'instance creation' }
GtPharoMethodCoderHeaderElement >> newMethodBehaviorButton [
	^ BrButton new
		fitContent;
		beSmallSize;
		aptitude: BrGlamorousMetadataLabelAptitude new
				+ (BrStyleCommonAptitude new
						default: [ :aStyle | 
							aStyle
								geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
								border: BlBorder empty ];
						hovered: [ :aStyle | aStyle border: self theme button hoveredBorderColor ]);
		action: [ self spawnMethodBehavior ]
]

{ #category : #'instance creation' }
GtPharoMethodCoderHeaderElement >> newPackageButton [
	^ BrButton new
		fitContent;
		beSmallSize;
		aptitude: BrGlamorousMetadataLabelAptitude new
				+ (BrStyleCommonAptitude new
						default: [ :aStyle | 
							aStyle
								geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
								border: BlBorder empty ];
						hovered: [ :aStyle | aStyle border: self theme button hoveredBorderColor ]);
		action: [ self spawnPackage ]
]

{ #category : #'instance creation' }
GtPharoMethodCoderHeaderElement >> newProviderBehaviorButton [
	^ BrButton new
		fitContent;
		beSmallSize;
		aptitude: BrGlamorousMetadataLabelAptitude new
				+ (BrStyleCommonAptitude new
						default: [ :aStyle | 
							aStyle
								geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
								border: BlBorder empty ];
						hovered: [ :aStyle | aStyle border: self theme button hoveredBorderColor ]);
		action: [ self spawnProviderBehavior ]
]

{ #category : #'event handling' }
GtPharoMethodCoderHeaderElement >> onCoderClassChanged: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateBreadcrumbElements ])
]

{ #category : #'api - textual coder view model' }
GtPharoMethodCoderHeaderElement >> onTextualCoderViewModelChanged [
	"Is sent when a new textualCoder view model is assigned to the element.
	Note: #onTextualCoderViewModelChanged is sent before #subscribeToTextualCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostTextualCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	[ BlFrameTelemetry
		time: [ 'Update package and behavior labels' ]
		during: [ self updateBreadcrumbElements ] ]
			on: Error
			do: [ :anError |
				self removeChildNamed: #error.
				self addChild: anError asDebuggableElement as: #error ]
]

{ #category : #accessing }
GtPharoMethodCoderHeaderElement >> packageButton [
	^ packageButton
]

{ #category : #'event handling' }
GtPharoMethodCoderHeaderElement >> resetBreadcrumbElements [
	methodBehaviourContainer visibility: BlVisibility gone.
	providerBehaviorIconContainer removeChildren.
	methodBehaviourIconContainer removeChildren
]

{ #category : #accessing }
GtPharoMethodCoderHeaderElement >> showIconNamed: anIconName in: anIconContainer [
	(anIconName isNil or:[ anIconName isEmpty ])
		ifTrue: [ ^ self ].
	((anIconName sameContentAs: Object systemIconName) or: [ 
		anIconName sameContentAs: AbstractLayout systemIconName ]) ifTrue: [ 
			"We only show the icon in case it is a custom one"
			^ self ].
	
	anIconContainer addChild: (self 
		gtSafeIconNamed: anIconName) asElement 
]

{ #category : #'instance creation' }
GtPharoMethodCoderHeaderElement >> spawnMethodBehavior [	
	headerCoderModel
		spawnMethodBehaviorFor: self textualCoderViewModel 
		from: self.
]

{ #category : #'private - actions' }
GtPharoMethodCoderHeaderElement >> spawnPackage [
	headerCoderModel
		spawnPackageFor: self textualCoderViewModel 
		from: self
]

{ #category : #'private - actions' }
GtPharoMethodCoderHeaderElement >> spawnProviderBehavior [	
	headerCoderModel
		spawnProviderBehaviorFor: self textualCoderViewModel 
		from: self.
]

{ #category : #'api - textual coder view model' }
GtPharoMethodCoderHeaderElement >> subscribeToTextualCoderViewModel [
	"Is sent after a new textualCoder view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromTextualCoderViewModel if elements subscribe to them"
	
	textualCoderViewModel coder weak
		when: GtCoderClassAdded, GtCoderClassRenamed, GtCoderClassRemoved
		send: #onCoderClassChanged:
		to: self.
	textualCoderViewModel weak
		when: GtTextualCoderViewModelBehaviorChanged
		send: #onCoderClassChanged:
		to: self.
]

{ #category : #'api - textual coder view model' }
GtPharoMethodCoderHeaderElement >> unsubscribeFromTextualCoderViewModel [
	"Is sent before a new textualCoder view model is assigned to the element.
	Elements that subscribe to textualCoder view model in domain model are required to implement this methods."
	
	textualCoderViewModel coderModel unsubscribe: self
]

{ #category : #'event handling' }
GtPharoMethodCoderHeaderElement >> updateBehaviorElements [
	self updateProviderBehaviorContent.

	headerCoderModel hasMethodBehaviourData 
		ifTrue: [ self updateMethodBehaviorContent ]
]

{ #category : #'event handling' }
GtPharoMethodCoderHeaderElement >> updateBreadcrumbElements [
	headerCoderModel := textualCoderViewModel computeHeaderBreadcrumbModel.
	
	self resetBreadcrumbElements.
	
	self updatePackageLabel.
	self updateBehaviorElements
]

{ #category : #'event handling' }
GtPharoMethodCoderHeaderElement >> updateMethodBehaviorContent [
	methodBehaviourContainer visibility: BlVisibility visible.
	
	methodBehaviourButton label: headerCoderModel methodBehaviourName.
	headerCoderModel methodBehaviourIconName
		ifNotNil: [ :anIconName | 
			self showIconNamed: anIconName in: methodBehaviourIconContainer ]
]

{ #category : #'event handling' }
GtPharoMethodCoderHeaderElement >> updatePackageLabel [
	packageButton label: headerCoderModel packageName
]

{ #category : #'event handling' }
GtPharoMethodCoderHeaderElement >> updateProviderBehaviorContent [
	providerBehaviorButton label: headerCoderModel providerBehaviourName.
	headerCoderModel providerBehaviourIconName
		ifNotNil: [ :anIconName | 
			self showIconNamed: anIconName in: providerBehaviorIconContainer ]
]
