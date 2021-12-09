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
		'package',
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #accessing }
GtPharoMethodCoderHeaderElement >> behaviorButton [
	^ behavior
]

{ #category : #initialization }
GtPharoMethodCoderHeaderElement >> initialize [
	super initialize.

	self fitContent.
	self alignCenterLeft.
	
	package := self newPackageButton.
	behavior := self newBehaviorButton.
	
	self addChildren: {
		package.
		BrLabel new
			aptitude: (BrGlamorousLabelAptitude new thin foreground: self theme button defaultTextColor);
			text: '>';
			margin: (BlInsets left: 5 right: 5).
		behavior }
]

{ #category : #'instance creation' }
GtPharoMethodCoderHeaderElement >> newBehaviorButton [
	^ BrButton new
		fitContent;
		aptitude: (BrGlamorousLabelAptitude new
			foreground: BrGlamorousColors defaultButtonTextColor;
			fontSize: 12);
		action: [ self spawnBehavior ];
		withAsyncPromiseDo: [ :anElementPromise |
			anElementPromise
				whenSuccess: [ :aButton :aMethodOrigin |
					aButton
						model: aMethodOrigin;
						label: (aMethodOrigin
							behaviorDo: [ :aBehavior | aBehavior name ]
							ifUnknown: 'Unknown') ];
				whenError: [ :aButton :anError |
					aButton
						model: GtPharoMethodUnknownOrigin new;
						label: anError description ];
				whenPending: [ :aButton | aButton label: '' ] ]
]

{ #category : #'instance creation' }
GtPharoMethodCoderHeaderElement >> newPackageButton [
	^ BrButton new
		fitContent;
		aptitude: (BrGlamorousLabelAptitude new
			foreground: BrGlamorousColors defaultButtonTextColor;
			fontSize: 12);
		action: [ self spawnPackage ];
		withAsyncPromiseDo: [ :anElementPromise |
			anElementPromise
				whenSuccess: [ :aButton :aMethodOrigin |
					aButton
						model: aMethodOrigin;
						label: (aMethodOrigin
							behaviorDo: [ :aBehavior | aBehavior package name ]
							ifUnknown: 'Unknown') ];
				whenError: [ :aButton :anError |
					aButton
						model: GtPharoMethodUnknownOrigin new;
						label: anError description ];
				whenPending: [ :aButton | aButton label: '' ] ]
]

{ #category : #'event handling' }
GtPharoMethodCoderHeaderElement >> onCoderClassChanged: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ self updateBreadcrumbElements ])
]

{ #category : #'event handling' }
GtPharoMethodCoderHeaderElement >> onCoderMethodModified: anAnnouncement [
	anAnnouncement coder isModified
		ifTrue: [ self background: self theme status errorBackgroundColor ]
		ifFalse: [ self background: Color white ]
]

{ #category : #'event handling' }
GtPharoMethodCoderHeaderElement >> onCoderSourceTextModified: anAnnouncement [
	anAnnouncement coder isModified
		ifTrue: [ self background: self theme status failureBackgroundColor ]
		ifFalse: [ self background: Color white ]
]

{ #category : #'api - textual coder view model' }
GtPharoMethodCoderHeaderElement >> onTextualCoderViewModelChanged [
	"Is sent when a new textualCoder view model is assigned to the element.
	Note: #onTextualCoderViewModelChanged is sent before #subscribeToTextualCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostTextualCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	[ self updateBreadcrumbElements ]
		on: Error
		do: [ :anError |
			self removeChildNamed: #error.
			self addChild: anError asDebuggableElement as: #error ]
]

{ #category : #accessing }
GtPharoMethodCoderHeaderElement >> packageButton [
	^ package
]

{ #category : #'private - actions' }
GtPharoMethodCoderHeaderElement >> spawnBehavior [	
	behavior model behaviorDo: [ :aBehavior |
		self phlow spawnTool: (GtClassCoderTool observedClass: aBehavior) ]
]

{ #category : #'private - actions' }
GtPharoMethodCoderHeaderElement >> spawnPackage [
	package model behaviorDo: [ :aBehavior |
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

	textualCoderViewModel coder weak
		when: GtCoderMethodModified
		send: #onCoderMethodModified:
		to: self.
		
	textualCoderViewModel coder weak
		when: GtCoderSourceCodeChanged
		send: #onCoderSourceTextModified:
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
	| aMethodOriginPromise |
	
	aMethodOriginPromise := textualCoderViewModel methodOrigin asAsyncPromise.

	package asyncPromise promise: aMethodOriginPromise.
	behavior asyncPromise promise: aMethodOriginPromise
]
