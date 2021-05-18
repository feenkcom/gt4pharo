Class {
	#name : #Gt2PharoPackageNavigationElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGt2WithPharoPackageCoderNavigationViewModel',
	#classTraits : 'TGt2WithPharoPackageCoderNavigationViewModel classTrait',
	#instVars : [
		'packageNameLabel'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - Views'
}

{ #category : #initialization }
Gt2PharoPackageNavigationElement >> createPackageNameLabel [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize
]

{ #category : #initialization }
Gt2PharoPackageNavigationElement >> initialize [
	super initialize.
	
	self hMatchParent.
	self vFitContent.
	
	self addAptitude: BrGlamorousListItemAptitude.
	
	packageNameLabel := self createPackageNameLabel.
	self addChild: packageNameLabel.

	self
		when: BlClickEvent
		do: [ :anEvent |
			anEvent consumed: true.
			anEvent currentTarget pharoPackageCoderNavigationViewModel selectPackageWithoutOtherEntities ]
]

{ #category : #'api - pharo package coder navigation view model' }
Gt2PharoPackageNavigationElement >> onPharoPackageCoderNavigationViewModelChanged [
	"Is sent when a new pharoPackageCoderNavigationViewModel is assigned to the receiver.
	Note: #onPharoPackageCoderNavigationViewModelChanged is sent before #subscribeToPharoPackageCoderNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageCoderNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	packageNameLabel text: self pharoPackageCoderNavigationViewModel packageName.
	self updatePackageSelection
]

{ #category : #'api - pharo package coder navigation view model' }
Gt2PharoPackageNavigationElement >> subscribeToPharoPackageCoderNavigationViewModel [
	"Is sent after a new pharoPackageCoderNavigationViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromPharoPackageCoderNavigationViewModel if the receiver subscribes to them"
	<modelSubscriber: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	self pharoPackageCoderNavigationViewModel
		when: Gt2PharoPackageCoderNavigationViewModelViewModelSelected, Gt2PharoPackageCoderNavigationViewModelViewModelDeselected,
			Gt2PharoTagCoderNavigationViewModelViewModelSelected, Gt2PharoTagCoderNavigationViewModelViewModelDeselected
			send: #updatePackageSelection
			to: self
]

{ #category : #'api - pharo package coder navigation view model' }
Gt2PharoPackageNavigationElement >> unsubscribeFromPharoPackageCoderNavigationViewModel [
	"Is sent before a new pharoPackageCoderNavigationViewModel is assigned to the receiver.
	Objects that subscribe to pharoPackageCoderNavigationViewModel are required to implement this method."
	<modelUnsubscriber: #package>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	self pharoPackageCoderNavigationViewModel unsubscribe: self
]

{ #category : #'private - update' }
Gt2PharoPackageNavigationElement >> updatePackageSelection [
	"A package is rendered visually selected when a package is selected and none of its tags is selected"
	
	self pharoPackageCoderNavigationViewModel isOnlySelectedPackage
		ifTrue: [ self states addState: BlElementState selected ]
		ifFalse: [ self states removeState: BlElementState selected ]
]
