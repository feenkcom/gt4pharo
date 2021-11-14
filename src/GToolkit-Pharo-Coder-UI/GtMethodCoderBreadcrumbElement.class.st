"
# Source coder breadcrumb
{{gtExample:GtMethodCoderBreadcrumbElementExamples>>#breadcrumbForSourceCoder}}

"
Class {
	#name : #GtMethodCoderBreadcrumbElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithTextualCoderViewModel',
	#classTraits : 'TGtWithTextualCoderViewModel classTrait',
	#instVars : [
		'package',
		'behavior'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #initialization }
GtMethodCoderBreadcrumbElement >> initialize [
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
GtMethodCoderBreadcrumbElement >> newBehaviorButton [
	^ BrButton new
		fitContent;
		aptitude: (BrGlamorousLabelAptitude new
			foreground: BrGlamorousColors defaultButtonTextColor;
			fontSize: 12);
		action: [ self spawnBehavior ]
]

{ #category : #'instance creation' }
GtMethodCoderBreadcrumbElement >> newPackageButton [
	^ BrButton new
		fitContent;
		aptitude: (BrGlamorousLabelAptitude new
			foreground: BrGlamorousColors defaultButtonTextColor;
			fontSize: 12);
		action: [ self spawnPackage ]
]

{ #category : #'event handling' }
GtMethodCoderBreadcrumbElement >> onCoderClassChanged: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ self updateBreadcrumbElements ])
]

{ #category : #'event handling' }
GtMethodCoderBreadcrumbElement >> onCoderMethodModified: anAnnouncement [
	anAnnouncement coder isModified
		ifTrue: [ self background: self theme status errorBackgroundColor ]
		ifFalse: [ self background: Color white ]
]

{ #category : #'event handling' }
GtMethodCoderBreadcrumbElement >> onCoderSourceTextModified: anAnnouncement [
	anAnnouncement coder isModified
		ifTrue: [ self background: self theme status failureBackgroundColor ]
		ifFalse: [ self background: Color white ]
]

{ #category : #'api - textual coder view model' }
GtMethodCoderBreadcrumbElement >> onTextualCoderViewModelChanged [
	"Is sent when a new textualCoder view model is assigned to the element.
	Note: #onTextualCoderViewModelChanged is sent before #subscribeToTextualCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostTextualCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self updateBreadcrumbElements
]

{ #category : #'private - actions' }
GtMethodCoderBreadcrumbElement >> spawnBehavior [
	| aMethodBehavior |
	
	aMethodBehavior := textualCoderViewModel coderModel methodBehavior.
	
	aMethodBehavior realBehaviorDo: [ :aBehavior |
		self phlow spawnTool: (GtClassCoderTool observedClass: aBehavior).
		^ self ].

	self phlow spawnTool: (GtInspectorTool forObject: aMethodBehavior)
]

{ #category : #'private - actions' }
GtMethodCoderBreadcrumbElement >> spawnPackage [
	self phlow spawnTool: (GtPackageCoderTool package: textualCoderViewModel coderModel package)
]

{ #category : #'api - textual coder view model' }
GtMethodCoderBreadcrumbElement >> subscribeToTextualCoderViewModel [
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
GtMethodCoderBreadcrumbElement >> unsubscribeFromTextualCoderViewModel [
	"Is sent before a new textualCoder view model is assigned to the element.
	Elements that subscribe to textualCoder view model in domain model are required to implement this methods."
	
	textualCoderViewModel coderModel unsubscribe: self
]

{ #category : #'event handling' }
GtMethodCoderBreadcrumbElement >> updateBreadcrumbElements [
	package label: textualCoderViewModel coderModel package name.
	behavior label: (textualCoderViewModel coderModel methodBehavior
		behaviorNameDo: [ :aName |
			textualCoderViewModel coderModel methodBehavior exists
				ifTrue: [ aName ]
				ifFalse: [ aName, ' (Deleted)' ] ]
		ifAbsent: [ '(Unspecified)' ])
]
