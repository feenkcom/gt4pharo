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

	self
		addAptitude: (BrGlamorousWithExplicitDropdownAptitude new
				withoutMouseEventHandler;
				withVisibleWidgetBoundsRelocator;
				withContainerPermanentVisibilityUpdater;
				handle: [ BlElement new size: self extent ]
					content: [ self newSaveDestinationPickerElement ]).

	dropdownIndicatorFuture := (BrAsyncElementFuture on: self)
			whenError: [ :theElement :anError | 
				NonInteractiveTranscript stdout
					show: '[GtPharoMethodCoderSaveButton>>#initialize] ';
					show: anError;
					cr ];
			whenSuccess: [ :theElement :someCompilationMethodIndicators | 
				theElement
					aptitudeDo: [ :anAptitude | 
						| aCount isMustDisplay |
						aCount := someCompilationMethodIndicators isCollection
								ifTrue: [ someCompilationMethodIndicators size ]
								ifFalse: [ someCompilationMethodIndicators ].
						isMustDisplay := someCompilationMethodIndicators isCollection
								ifTrue: [ someCompilationMethodIndicators allSatisfy: #isChangeIndicationRequired ]
								ifFalse: [ false ].

						(aCount > 1 or: [ isMustDisplay ])
							ifTrue: [ (anAptitude hasActorOfKind: BrGlamorousButtonIconDropdownAptitude)
									ifFalse: [ anAptitude + BrGlamorousButtonIconDropdownAptitude ] ]
							ifFalse: [ anAptitude - BrGlamorousButtonIconDropdownAptitude ] ] ]
]

{ #category : #'private - instance creation' }
GtPharoMethodCoderSaveButton >> newSaveDestinationPickerElement [

	true ifTrue: [ ^ GtPharoMethodSaveConfirmationElement new 
		pharoMethodCoderViewModel: self pharoMethodCoderViewModel ].

	^ BrVerticalPane new
		fitContent;
		padding: (BlInsets
				top: 5
				left: 10
				bottom: 5
				right: 10);
		cellSpacing: 5;
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				padding: (BlInsets left: 7);
				text: 'Where should it be saved?');
		addChild: (BrSimpleList new
				fitContent;
				itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | anItemObject listItemElementClass ];
				itemStencil: [ :anElementClass :aListWidget | anElementClass new ];
				itemDataBinder: [ :eachElement :eachMethodIndicator | 
					eachElement
						pharoMethodCoderViewModel: pharoMethodCoderViewModel;
						methodModificationIndicator: eachMethodIndicator ];
				stream: pharoMethodCoderViewModel
						availableCompilationMethodIndicatorsWithBehaviorSources)
]

{ #category : #'api - pharo method coder view model' }
GtPharoMethodCoderSaveButton >> onPharoMethodCoderViewModelChanged [
	dropdownIndicatorFuture ifNotNil: [ :aFuture | 
		aFuture future: self pharoMethodCoderViewModel availableCompilationMethodIndicatorsWithBehaviorSources toArray ]
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
	aSavePromise := (aViewModel
			availableCompilationMethodIndicatorsWithBehaviorSources toArray
			map: [ :theMethodIndicators | 
				self
					enqueueTask: (BlTaskAction new
							action: [ (theMethodIndicators allSatisfy: #isChangeIndicationRequired)
									ifFalse: [ theMethodIndicators size = 1
											ifTrue: [ aViewModel saveIn: theMethodIndicators first behavior ]
											ifFalse: [ theMethodIndicators size > 1
													ifTrue: [ self showSaveBehaviors: theMethodIndicators ] ] ]
									ifTrue: [ self showSaveBehaviors: theMethodIndicators ] ]) ])
			asAsyncPromise.

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
