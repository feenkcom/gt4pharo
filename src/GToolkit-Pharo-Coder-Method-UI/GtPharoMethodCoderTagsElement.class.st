"
I display various tags in the method coder element such as protocol or instance/class side

"
Class {
	#name : #GtPharoMethodCoderTagsElement,
	#superclass : #BlElement,
	#traits : 'TGtWithPharoMethodCoderViewModel',
	#classTraits : 'TGtWithPharoMethodCoderViewModel classTrait',
	#instVars : [
		'protocolTag',
		'classTag'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #private }
GtPharoMethodCoderTagsElement >> behaviorOtherSideName [
	^ self classTagStringForMeta: pharoMethodCoderViewModel isMeta not
]

{ #category : #private }
GtPharoMethodCoderTagsElement >> behaviorProtocols [
	| allSubAndSuperclassProtocols excludedClasses |
	allSubAndSuperclassProtocols := Set new.
	excludedClasses := Set
			withAll: {ProtoObject.
					Object}.

	pharoMethodCoderViewModel coder behavior
		withAllSubAndSuperclassesDo: [ :eachBehavior | 
			(excludedClasses includes: eachBehavior)
				ifFalse: [ allSubAndSuperclassProtocols addAll: eachBehavior protocols ] ].
	self
		forPharo12: [ allSubAndSuperclassProtocols := allSubAndSuperclassProtocols collect: #name ]
		forPharo11AndPharo10: [  ].


	^ allSubAndSuperclassProtocols asArray sorted
]

{ #category : #private }
GtPharoMethodCoderTagsElement >> behaviorSideName [
	^ self classTagStringForMeta: pharoMethodCoderViewModel isMeta
]

{ #category : #initialization }
GtPharoMethodCoderTagsElement >> buildTags [	
	protocolTag := self newProtocolTag.
	classTag := self newClassTag.

	^ { protocolTag. classTag }
]

{ #category : #private }
GtPharoMethodCoderTagsElement >> classTagStringFor: aMethodCoderUIModel [
	<return: #String>

	^ self classTagStringForMeta: aMethodCoderUIModel isMeta
]

{ #category : #private }
GtPharoMethodCoderTagsElement >> classTagStringForMeta: aBoolean [
	<return: #String>

	^ aBoolean
		ifTrue: [ 'class' ]
		ifFalse: [ 'instance' ] 
]

{ #category : #'private - event handling' }
GtPharoMethodCoderTagsElement >> handleTraitMethodTagButtonClick: aButton [
	| aTraitElement aClass aSelector aMethod |

	aTraitElement := pharoMethodCoderViewModel coder traitSource.
	aTraitElement
		ifNil: [ ^ self ].

	(aTraitElement isKindOf: TaCompositionElement)
		ifFalse: [ ^ self ].
	
	aClass := aTraitElement innerClass.
	aSelector := pharoMethodCoderViewModel coder selector.
	aSelector
		ifNil: [ aButton phlow spawnTool: (GtClassCoderTool forClass: aClass).
			^ self ].
	aMethod := aClass compiledMethodAt: aSelector ifAbsent: [ ^ self ].
	aButton phlow spawnTool: (GtMethodCoderTool compiledMethod: aMethod)
]

{ #category : #initialization }
GtPharoMethodCoderTagsElement >> initialize [
	super initialize.
	
	self 
		layout: (BlLinearLayout horizontal cellSpacing: 4);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
		
	self addChildren: self buildTags
]

{ #category : #'instance creation' }
GtPharoMethodCoderTagsElement >> newClassTag [
	^ BrButton new
		id: GtPharoSideTagId;
		beTinySize;
		withAsyncPromiseDo: [ :anElementPromise | 
			anElementPromise
				whenSuccess: [ :aButton :isModified | aButton enabled: isModified not ] ];
		aptitude: BrGlamorousButtonWithLabelAptitude
				+ (BrGlamorousWithExplicitDropdownAptitude
						handle: [ BrButton new
								beSmallSize;
								disable;
								aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonLabelAptitude;
								label: self behaviorSideName ]
						content: [ BrButton new
								beSmallSize;
								aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonLabelAptitude;
								label: self behaviorOtherSideName;
								action: [ :aButton | 
									aButton fireEvent: BrDropdownHideWish new.
									pharoMethodCoderViewModel coder moveMethodToInstanceOrClass.
									classTag label: self behaviorSideName ] ])
]

{ #category : #'private - instance creation' }
GtPharoMethodCoderTagsElement >> newProtocolEditor [
	| anEditor |
	anEditor := BrEditableLabel new
			text: (self protocolStringFor: pharoMethodCoderViewModel);
			constraintsDo: [ :c | c minWidth: 100 ];
			aptitude: (BrGlamorousEditableLabelAptitude new
					glamorousCodeFont;
					defaultForeground: Color black;
					fontSize: 13);
			padding: (BlInsets all: 4);
			switchToEditor;
			requestFocus;
			when: BlKeyDownEvent
				do: [ :evt | 
					evt currentTarget
						fireEvent: (BrDropdownContentChanged new content: (BlElement new size: 0 @ 0)) ];
			when: BrEditorAcceptWish
				do: [ :aWish | 
					aWish currentTarget fireEvent: BrDropdownHideWish new.
					pharoMethodCoderViewModel coder renameProtocol: aWish text asString.
					self updateProtocolButton ];
			when: BrEditorCancelWish
				do: [ :aWish | aWish currentTarget fireEvent: BrDropdownHideWish new ];
			whenKey: BlKeyCombination primaryC
				labelDo: [ :aShortcutEvent :aShortcut | Clipboard clipboardText: aShortcutEvent currentTarget text asString ].
	(GtCompletionController
		on: anEditor
		strategy: GtMethodProtocolCompletionStrategy new) install.
	^ anEditor
]

{ #category : #'private - instance creation' }
GtPharoMethodCoderTagsElement >> newProtocolPickerList [
	^ BrSimpleList new
		vFitContentLimited;
		hExact: 250;
		itemStencil: [
			BrButton new
				beSmallSize;
				aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonLabelAptitude;
				action: [ :aButton :aButtonModel |
					aButton fireEvent: (BrDropdownHideWish new).
					pharoMethodCoderViewModel coder renameProtocol: aButtonModel model asString.
					self updateProtocolButton ] ];
		itemDataBinder: [ :eachButton :eachProtocol |
			eachButton viewModel model: eachProtocol.
			eachButton label: eachProtocol ];
		items: self behaviorProtocols
]

{ #category : #'private - instance creation' }
GtPharoMethodCoderTagsElement >> newProtocolTag [
	^ BrButton new
		beTinySize;
		aptitude: BrGlamorousButtonWithLabelAptitude
				+ (BrGlamorousWithExplicitDropdownAptitude
						handle: [ self newProtocolEditor ]
						content: [ self newProtocolPickerList ]
						do: [ :theAptitude | theAptitude withContainerDownUpDropdown ])
]

{ #category : #'private - event handling' }
GtPharoMethodCoderTagsElement >> onCoderMethodModified: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ self updateProtocolButtonLabel ])
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodCoderTagsElement >> onPharoMethodCoderViewModelChanged [
	"Is sent when a new pharoMethodCoderViewModel is assigned to the receiver.
	Note: #onPharoMethodCoderViewModelChanged is sent before #subscribeToPharoMethodCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoMethodCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self updateProtocolButton.
	self updateBehaviorSideButton
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodCoderTagsElement >> onProtocolChanged: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ self updateProtocolButtonLabel ])
]

{ #category : #'private - event handling' }
GtPharoMethodCoderTagsElement >> onViewModelTextChanged: anAnnouncement [
	self updateBehaviorSideButtonActivation
]

{ #category : #private }
GtPharoMethodCoderTagsElement >> protocolStringFor: aMethodCoderUIModel [
	<return: #String>

	^ aMethodCoderUIModel coder protocol
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodCoderTagsElement >> subscribeToPharoMethodCoderViewModel [
	"Is sent after a new pharoMethodCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoMethodCoderViewModel if the receiver subscribes to them"

	<modelSubscriber: #methodCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	pharoMethodCoderViewModel weak
		when: GtTextualCoderViewModelTextChanged
		send: #onViewModelTextChanged:
		to: self.

	pharoMethodCoderViewModel coder weak
		when: GtCoderMethodModified
		send: #onCoderMethodModified:
		to: self.

	pharoMethodCoderViewModel coder weak
		when: GtCoderProtocolChanged
		send: #onProtocolChanged:
		to: self
]

{ #category : #private }
GtPharoMethodCoderTagsElement >> traitMethodStringFor: aMethodCoderUIModel [
	<return: #String>
	^ aMethodCoderUIModel coder isFromTrait
		ifTrue: [ aMethodCoderUIModel coder traitSource printString ]
		ifFalse: [ '' ]
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodCoderTagsElement >> unsubscribeFromPharoMethodCoderViewModel [
	"Is sent before a new pharoMethodCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoMethodCoderViewModel are required to implement this method."
	<modelUnsubscriber: #methodCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	pharoMethodCoderViewModel coderModel unsubscribe: self.
	pharoMethodCoderViewModel unsubscribe: self
]

{ #category : #'private - update' }
GtPharoMethodCoderTagsElement >> updateBehaviorSideButton [
	classTag label: (self classTagStringFor: pharoMethodCoderViewModel)
]

{ #category : #'private - update' }
GtPharoMethodCoderTagsElement >> updateBehaviorSideButtonActivation [
	"classTag asyncPromise promise: pharoMethodCoderViewModel isTextModified"
]

{ #category : #'private - update' }
GtPharoMethodCoderTagsElement >> updateProtocolButton [
	self updateProtocolButtonLabel.
]

{ #category : #'private - update' }
GtPharoMethodCoderTagsElement >> updateProtocolButtonLabel [
	protocolTag label: (self protocolStringFor: pharoMethodCoderViewModel)
]
