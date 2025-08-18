Class {
	#name : #GtPharoBehaviorsNavigationElement,
	#superclass : #BrSimpleTree,
	#traits : 'TGtWithPharoBehaviorsNavigationViewModel',
	#classTraits : 'TGtWithPharoBehaviorsNavigationViewModel classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoBehaviorsNavigationElement >> initialize [
	super initialize.
	
	self withoutSelection.

	self nodeType: [ :aTypeFactory :aTreeNode | GtPharoBehaviorNavigationElement ].

	self nodeStencil: [ :anElementClass | anElementClass new ].

	self nodeDataBinder: [ :eachNodeElement :eachTreeNode |
		eachNodeElement pharoBehaviorNavigationViewModel: eachTreeNode value ]
]

{ #category : #'api - pharo behaviors navigation view model' }
GtPharoBehaviorsNavigationElement >> onPharoBehaviorsNavigationViewModelChanged [
	"Is sent when a new pharoBehaviorsNavigation view model is assigned to the element.
	Note: #onPharoBehaviorsNavigationViewModelChanged is sent before #subscribeToPharoBehaviorsNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoBehaviorsNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self
		items: self pharoBehaviorsNavigationViewModel pharoBehaviorNavigationViewModels
		lazy: [ :eachBehaviorViewModel | #() ]
]
