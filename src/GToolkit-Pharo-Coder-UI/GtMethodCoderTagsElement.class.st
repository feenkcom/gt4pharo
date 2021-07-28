"
I display various tags in the method coder element such as protocol or instance/class side

"
Class {
	#name : #GtMethodCoderTagsElement,
	#superclass : #BlElement,
	#instVars : [
		'protocolTag',
		'methodCoderUIModel',
		'traitMethodTag'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #private }
GtMethodCoderTagsElement >> behaviorProtocols [
	| allSubAndSuperclassProtocols excludedClasses |
	
	allSubAndSuperclassProtocols := Set new.
	excludedClasses := Set withAll: { ProtoObject . Object }.
	
	self methodCoderUIModel coder behavior withAllSubAndSuperclassesDo: [ :eachBehavior |
		(excludedClasses includes: eachBehavior)
			ifFalse: [ allSubAndSuperclassProtocols addAll: eachBehavior protocols ] ].

	^ allSubAndSuperclassProtocols asArray sorted
]

{ #category : #initialization }
GtMethodCoderTagsElement >> buildTags [	
	protocolTag := self newProtocolTag.
	traitMethodTag := self newTraitMethodTag.

	^ { traitMethodTag. protocolTag }
]

{ #category : #'event handling' }
GtMethodCoderTagsElement >> handleTraitMethodTagButtonClick: aButton [
	| aTraitElement aClass |
	aTraitElement := self methodCoderUIModel coder traitSource.
	aTraitElement ifNil: [ ^ self ].
	(aTraitElement isKindOf: TaCompositionElement) ifFalse: [ ^ self ].
	aClass := aTraitElement innerClass.
	
	aButton phlow
		spawnTool: (GtClassCoderTool forClass: aClass)
]

{ #category : #initialization }
GtMethodCoderTagsElement >> initialize [
	super initialize.
	
	self 
		layout: (BlLinearLayout horizontal cellSpacing: 4);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
		
	self addChildren: self buildTags
]

{ #category : #accessing }
GtMethodCoderTagsElement >> methodCoderUIModel [
	^ methodCoderUIModel
]

{ #category : #accessing }
GtMethodCoderTagsElement >> methodCoderUIModel: aMethodCoderUIModel [
	self
		assert: [ aMethodCoderUIModel isKindOf: GtPharoMethodCoderViewModel ]
		description: [ 'Must be method coder''s UI Model' ].

	methodCoderUIModel == aMethodCoderUIModel
		ifTrue: [ ^ self ].

	"do not forget to unsubscribe from the previous coder"
	self unsubscribeFromCoder.

	methodCoderUIModel := aMethodCoderUIModel.
	
	aMethodCoderUIModel coder weak
		when: GtCoderSourceCodeChanged
		send: #onCoderSourceTextModified:
		to: self.

	aMethodCoderUIModel coder weak
		when: GtCoderMethodModified
		send: #onCoderMethodModified:
		to: self.	

	self updateProtocolButton.
	self updateTraitMethodButton.
]

{ #category : #'private - instance creation' }
GtMethodCoderTagsElement >> newProtocolEditor [
	| anEditor |

	anEditor := BrEditableLabel new
		text: (self protocolStringFor: self methodCoderUIModel);
		constraintsDo: [ :c | c minWidth: 100 ];
		aptitude:
			(BrGlamorousEditableLabelAptitude new
				glamorousCodeFont;
				defaultForeground: Color black;
				fontSize: 13);
		padding: (BlInsets all: 4);
		switchToEditor;
		requestFocus;
		when: BrEditorAcceptWish
			do: [ :aWish | 
				aWish currentTarget fireEvent: (BrDropdownHideWish new).
				self methodCoderUIModel coder renameProtocol: aWish text asString.
				self updateProtocolButton ];
		when: BrEditorCancelWish
			do: [ :aWish | aWish currentTarget fireEvent: (BrDropdownHideWish new) ];
		whenKey: BlKeyCombination primaryC
			labelDo: [ :aShortcutEvent :aShortcut | 
				Clipboard clipboardText: aShortcutEvent currentTarget text asString ].
	(GtCompletionController
		on: anEditor
		strategy: GtMethodProtocolCompletionStrategy new) install.

	^ anEditor
]

{ #category : #'private - instance creation' }
GtMethodCoderTagsElement >> newProtocolPickerList [
	^ BrSimpleList new
		vFitContentLimited;
		hExact: 250;
		itemStencil: [
			BrButton new
				beSmallSize;
				aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonLabelAptitude;
				action: [ :aButton :aButtonModel |
					aButton fireEvent: (BrDropdownHideWish new).
					self methodCoderUIModel coder renameProtocol: aButtonModel model asString.
					self updateProtocolButton ] ];
		itemDataBinder: [ :eachButton :eachProtocol |
			eachButton viewModel model: eachProtocol.
			eachButton label: eachProtocol ];
		items: self behaviorProtocols
]

{ #category : #'private - instance creation' }
GtMethodCoderTagsElement >> newProtocolTag [
	^ BrButton new
		beTinySize;
		aptitude: BrGlamorousButtonWithLabelAptitude + (BrGlamorousWithDropdownAptitude
			handle: [ self newProtocolEditor ]
			content: [ self newProtocolPickerList ])
]

{ #category : #'private - instance creation' }
GtMethodCoderTagsElement >> newTraitMethodTag [
	^ BrButton new
		beTinySize;
		disable;
		aptitude:
			(BrGlamorousLabelAptitude new
				foreground: BrGlamorousColors disabledButtonTextColor);
		action:
				[ :aButton | self handleTraitMethodTagButtonClick: aButton ];
		label: '';
		fitContent
]

{ #category : #'event handling' }
GtMethodCoderTagsElement >> onCoderMethodModified: anAnnouncement [
	self updateTraitMethodButton.
]

{ #category : #'event handling' }
GtMethodCoderTagsElement >> onCoderSourceTextModified: anAnnouncement [
	protocolTag disabled: anAnnouncement coder isModified
]

{ #category : #private }
GtMethodCoderTagsElement >> protocolStringFor: aMethodCoderUIModel [
	<return: #String>

	^ aMethodCoderUIModel coder protocol
]

{ #category : #private }
GtMethodCoderTagsElement >> traitMethodStringFor: aMethodCoderUIModel [
	<return: #String>
	^ aMethodCoderUIModel coder isFromTrait
		ifTrue: [ aMethodCoderUIModel coder traitSource printString ]
		ifFalse: [ '' ]
]

{ #category : #private }
GtMethodCoderTagsElement >> unsubscribeFromCoder [
	methodCoderUIModel
		ifNil: [ ^ self ].

	methodCoderUIModel coder unsubscribe: self
]

{ #category : #private }
GtMethodCoderTagsElement >> updateProtocolButton [
	protocolTag label: (self protocolStringFor: self methodCoderUIModel)
]

{ #category : #private }
GtMethodCoderTagsElement >> updateTraitMethodButton [
	traitMethodTag label: (self traitMethodStringFor: self methodCoderUIModel).
	self methodCoderUIModel coder isFromTrait
		ifTrue: [ traitMethodTag enable ]
		ifFalse: [ traitMethodTag disable ]
]
