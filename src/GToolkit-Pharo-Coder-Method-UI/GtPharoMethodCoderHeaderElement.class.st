"
# Source coder breadcrumb
{{gtExample:GtMethodCoderHeaderElementExamples>>#headerForMethodCoder}}

"
Class {
	#name : #GtPharoMethodCoderHeaderElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithTextualCoderViewModel',
	#classTraits : 'TGtWithTextualCoderViewModel classTrait',
	#instVars : [
		'packageButton',
		'targetBehaviorButton',
		'providerBehaviourButton',
		'targetBehaviorIconContainer',
		'providerBehaviourIconContainer',
		'providerBehaviourContainer'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #accessing }
GtPharoMethodCoderHeaderElement >> behaviorButton [
	^ targetBehaviorButton
]

{ #category : #initialization }
GtPharoMethodCoderHeaderElement >> buildSeparatorElement [
	^ BrLabel new
			aptitude: (BrGlamorousLabelAptitude new thin 
				padding: (BlInsets all:0 );
				foreground: self theme button defaultTextColor);
			text: '>'.
]

{ #category : #initialization }
GtPharoMethodCoderHeaderElement >> initialize [
	super initialize.

	self fitContent.
	self alignCenterLeft.
	
	packageButton := self newPackageButton.
	targetBehaviorButton := self newBehaviorButton.
	targetBehaviorIconContainer := self newIconContainer.
	
	self addChild: packageButton as: #packageButton.
	self addChild: (self buildSeparatorElement
		margin: (BlInsets left: 5 right: 5)) as: #separatorElement.
	self addChild: targetBehaviorButton as: #behaviorButton.
	self addChild: targetBehaviorIconContainer as: #iconContainer.
	
	self addChild: (providerBehaviourContainer := BrHorizontalPane new 
		fitContent;
		alignCenterLeft;
		addChild: (self buildSeparatorElement 
			text: '(');
		addChild: (providerBehaviourButton := self newBehaviorButton) 
			as: #secondBehaviorButton;
		addChild: (providerBehaviourIconContainer := self newIconContainer);
		addChild: (self buildSeparatorElement text: ')'))
]

{ #category : #'instance creation' }
GtPharoMethodCoderHeaderElement >> newBehaviorButton [
	^ BrButton new
		fitContent;
		aptitude: (BrGlamorousLabelAptitude new
			foreground: BrGlamorousColors defaultButtonTextColor;
			fontSize: 12);
		action: [ self spawnBehavior ]
]

{ #category : #initialization }
GtPharoMethodCoderHeaderElement >> newIconContainer [
	^ BrFrame new
		fitContent;
		layout: BlFrameLayout new
]

{ #category : #'instance creation' }
GtPharoMethodCoderHeaderElement >> newPackageButton [
	^ BrButton new
		fitContent;
		aptitude: (BrGlamorousLabelAptitude new
			foreground: BrGlamorousColors defaultButtonTextColor;
			fontSize: 12);
		action: [ self spawnPackage ]
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
GtPharoMethodCoderHeaderElement >> showIconFor: aBehavior in: anIconContainer [
	| iconName |
	iconName := aBehavior gtCustomSystemIconNameOrNil.
	iconName ifNil: [ 
		"We only show the icon in case it is a custom one"
		^ self ].
	
	anIconContainer addChild: (self 
		gtSafeIconNamed: iconName) asElement 
]

{ #category : #'private - actions' }
GtPharoMethodCoderHeaderElement >> spawnBehavior [	
	targetBehaviorButton model behaviorDo: [ :aBehavior |
		self phlow spawnTool: (GtMethodCoderTool 
			compiledMethod: self textualCoderViewModel compiledMethod) ]
]

{ #category : #'private - actions' }
GtPharoMethodCoderHeaderElement >> spawnPackage [
	packageButton model behaviorDo: [ :aBehavior |
		self phlow spawnTool: (GtPackageCoderTool package: aBehavior package) ]
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
GtPharoMethodCoderHeaderElement >> updateBreadcrumbElements [	
	| currentMethodOrigin headerData |
	
	currentMethodOrigin := textualCoderViewModel methodOrigin.
	headerData := textualCoderViewModel computeHeaderBreadcrumbData.
		
	packageButton model: currentMethodOrigin.
	
	targetBehaviorButton model: currentMethodOrigin.
	providerBehaviourButton model: currentMethodOrigin.

	packageButton label: headerData packageName.
	
	providerBehaviourContainer visibility: BlVisibility gone.
	targetBehaviorIconContainer removeChildren.
	providerBehaviourIconContainer removeChildren.
	
	targetBehaviorButton label: headerData targetBehaviourName.
	headerData targetBehaviourIconName ifNotNil: [ :anIconName |
		targetBehaviorIconContainer addChild: (self 
			gtSafeIconNamed: anIconName) asElement ].
	
	headerData hasProviderBehaviourData ifTrue: [
		providerBehaviourContainer visibility: BlVisibility visible.
		
		providerBehaviourButton label: headerData providerBehaviourName.
		headerData providerBehaviourIconName ifNotNil: [ :anIconName |
			providerBehaviourIconContainer addChild: (self 
				gtSafeIconNamed: anIconName) asElement ] ]
]
