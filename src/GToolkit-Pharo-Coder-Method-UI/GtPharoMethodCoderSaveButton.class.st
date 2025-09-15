Class {
	#name : #GtPharoMethodCoderSaveButton,
	#superclass : #BrButton,
	#traits : 'TGtWithPharoMethodCoderViewModel',
	#classTraits : 'TGtWithPharoMethodCoderViewModel classTrait',
	#instVars : [
		'dropdownIndicatorFuture'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! Views'
}

{ #category : #initialization }
GtPharoMethodCoderSaveButton >> initialize [
	super initialize.
	
	self
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons accept;
		id: GtMethodCoderSaveActionId;
		label: 'Save';
		beTinySize;
		action: [ self pharoMethodCoderViewModel requestSave ].
		
	self addAptitude: (BrGlamorousWithExplicitDropdownAptitude new
		withVisibleWidgetBoundsRelocator;
		withContainerPermanentVisibilityUpdater;
		handle: [ BlElement new size: self extent ]
		content: [ self newSaveDestinationPickerElement ]) doNotShowOnClick.
	
	dropdownIndicatorFuture := (BrAsyncElementFuture on: self)
		whenError: [ :theElement :anError | NonInteractiveTranscript stdout 
			show: '[GtPharoMethodCoderSaveButton>>#initialize] ';
			show: anError; 
			cr ];
		whenSuccess: [ :theElement :aCount | 
			theElement
				aptitudeDo: [ :anAptitude | 
					aCount > 1
						ifTrue: [ (anAptitude hasActorOfKind: BrGlamorousButtonIconDropdownAptitude)
								ifFalse: [ anAptitude + BrGlamorousButtonIconDropdownAptitude ] ]
						ifFalse: [ anAptitude - BrGlamorousButtonIconDropdownAptitude ] ] ]
]

{ #category : #'private - instance creation' }
GtPharoMethodCoderSaveButton >> newSaveDestinationPickerElement [
	^ BrVerticalPane new
		fitContent;
		padding: (BlInsets top: 5 left: 10 bottom: 5 right: 10);
		cellSpacing: 5;
		addChild: (BrLabel new
			aptitude: BrGlamorousLabelAptitude new;
			padding: (BlInsets left: 7);
			text: 'Where should it be saved?');
		addChild: (BrSimpleList new
			fitContent;
			itemStencil: [
				BrButton new
					hMatchParent;
					alignCenterLeft;
					aptitude: (BrGlamorousButtonFlatExteriorAptitude + (BrGlamorousLabelAptitude new glamorousCodeFont) + BrGlamorousButtonRectangularAptitude);
					action: [ :aButton |
						pharoMethodCoderViewModel saveIn: aButton model.
						self dispatchEvent: BrDropdownHideWish new ] ];
			itemDataBinder: [ :eachLabel :eachBehavior |
				eachLabel
					model: eachBehavior;
					label: eachBehavior name ];
			stream: pharoMethodCoderViewModel availableCompilationBehaviors)
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodCoderSaveButton >> onPharoMethodCoderViewModelChanged [
	dropdownIndicatorFuture ifNotNil: [ :aFuture | 
		aFuture future: self pharoMethodCoderViewModel availableCompilationBehaviors size ]
]

{ #category : #'private - event handling' }
GtPharoMethodCoderSaveButton >> onSaveAbilityChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self updateSaveAbility ]
]

{ #category : #'private - event handling' }
GtPharoMethodCoderSaveButton >> onSaveRequested: anAnnouncement [
	| aViewModel aSavePromise |
	anAnnouncement consumed: true.
	
	aViewModel := pharoMethodCoderViewModel.
	aSavePromise := (aViewModel availableCompilationBehaviors toArray map: [ :theBehaviors |
		self enqueueTask: (BlTaskAction new action: [
			theBehaviors size = 1
				ifTrue: [ aViewModel saveIn: theBehaviors first ]
				ifFalse: [
					theBehaviors size > 1 
						ifTrue: [ self showSaveBehaviors: theBehaviors ] ]
		]) ]) asAsyncPromise.

	self enqueueTask: (BlPromiseTask new promise: aSavePromise)
]

{ #category : #'private - updating' }
GtPharoMethodCoderSaveButton >> showSaveBehaviors: aCollectionOfBehaviors [
	self dispatchEvent: BrDropdownShowWish new
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodCoderSaveButton >> subscribeToPharoMethodCoderViewModel [
	"Is sent after a new pharoMethodCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoMethodCoderViewModel if the receiver subscribes to them"

	<modelSubscriber: #methodCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	pharoMethodCoderViewModel weak
		when: GtMethodCoderSaveAbilityChanged
				, GtMethodCoderSaveDisabled
				, GtMethodCoderSaveEnabled
			send: #onSaveAbilityChanged:
			to: self;
		when: GtSourceCoderViewModelSaveRequested
			send: #onSaveRequested:
			to: self
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodCoderSaveButton >> unsubscribeFromPharoMethodCoderViewModel [
	"Is sent before a new pharoMethodCoderViewModel is assigned to the receiver.
	Objects that subscribe to pharoMethodCoderViewModel are required to implement this method."
	<modelUnsubscriber: #methodCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	pharoMethodCoderViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtPharoMethodCoderSaveButton >> updateSaveAbility [
	self enabled: pharoMethodCoderViewModel isSaveEnabled
]
