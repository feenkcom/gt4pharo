Class {
	#name : #Gt2PharoTagNavigationElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGt2WithPharoTagCoderNavigationViewModel',
	#classTraits : 'TGt2WithPharoTagCoderNavigationViewModel classTrait',
	#instVars : [
		'packageTagNameLabel'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - Views'
}

{ #category : #initialization }
Gt2PharoTagNavigationElement >> createPackageTagNameLabel [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize
]

{ #category : #initialization }
Gt2PharoTagNavigationElement >> initialize [
	super initialize.

	self hMatchParent.
	self vFitContent.

	self addAptitude: BrGlamorousListItemAptitude.

	packageTagNameLabel := self createPackageTagNameLabel.
	self addChild: packageTagNameLabel.

	self
		when: BlClickEvent
		do: [ :anEvent |
			anEvent consumed: true.
			anEvent currentTarget pharoTagCoderNavigationViewModel selectTagWithoutOtherEntities ]
]

{ #category : #'api - pharo tag coder navigation view model' }
Gt2PharoTagNavigationElement >> onPharoTagCoderNavigationViewModelChanged [
	"Is sent when a new pharoTagCoderNavigationViewModel is assigned to the receiver.
	Note: #onPharoTagCoderNavigationViewModelChanged is sent before #subscribeToPharoTagCoderNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoTagCoderNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	packageTagNameLabel text: self pharoTagCoderNavigationViewModel tagName.
	self updateTagSelection
]

{ #category : #'api - pharo tag coder navigation view model' }
Gt2PharoTagNavigationElement >> subscribeToPharoTagCoderNavigationViewModel [
	"Is sent after a new pharoTagCoderNavigationViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoTagCoderNavigationViewModel if the receiver subscribes to them"
	<modelSubscriber: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	self pharoTagCoderNavigationViewModel
		when: Gt2PharoPackageCoderNavigationViewModelViewModelSelected, Gt2PharoPackageCoderNavigationViewModelViewModelDeselected,
			Gt2PharoTagCoderNavigationViewModelViewModelSelected, Gt2PharoTagCoderNavigationViewModelViewModelDeselected
			send: #updateTagSelection
			to: self
]

{ #category : #'api - pharo tag coder navigation view model' }
Gt2PharoTagNavigationElement >> unsubscribeFromPharoTagCoderNavigationViewModel [
	"Is sent before a new pharoTagCoderNavigationViewModel is assigned to the receiver.
	Objects that subscribe to pharoTagCoderNavigationViewModel are required to implement this method."
	<modelUnsubscriber: #tag>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	self pharoTagCoderNavigationViewModel unsubscribe: self
]

{ #category : #'private - update' }
Gt2PharoTagNavigationElement >> updateTagSelection [
	"A tag is rendered visually selected when a tag is selected and none of its child entities is selected"

	self pharoTagCoderNavigationViewModel isOnlySelectedTag
		ifTrue: [ self states addState: BlElementState selected ]
		ifFalse: [ self states removeState: BlElementState selected ]
]
