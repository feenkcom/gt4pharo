Class {
	#name : #GtPharoPackagesNavigationElement,
	#superclass : #BrSimpleTree,
	#traits : 'TGtWithPharoPackagesNavigationViewModel',
	#classTraits : 'TGtWithPharoPackagesNavigationViewModel classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoPackagesNavigationElement >> initialize [
	super initialize.
	
	self nodeType: [ :aTypeFactory :aTreeNode |
		{
			#package -> GtPharoPackageNavigationElement.
			#tag -> GtPharoPackageTagNavigationElement.
		} asDictionary at: aTreeNode value viewModelName ].

	self nodeStencil: [ :anElementClass | anElementClass new ].

	self nodeDataBinder: [ :eachNodeElement :eachTreeNode |
		| aViewModelSetter |
		aViewModelSetter := {
			#package -> #pharoPackageNavigationViewModel:.
			#tag -> #pharoTagNavigationViewModel:.
		} asDictionary at: eachTreeNode value viewModelName.
		eachNodeElement perform: aViewModelSetter with: eachTreeNode value ]
]

{ #category : #initialization }
GtPharoPackagesNavigationElement >> initializeAptitude: aGroupedListAptitude [
	super initializeAptitude: aGroupedListAptitude.

	self withoutSelection
]

{ #category : #'api - pharo packages navigation view model' }
GtPharoPackagesNavigationElement >> onPharoPackagesNavigationViewModelChanged [
	"Is sent when a new pharoPackagesNavigation view model is assigned to the element.
	Note: #onPharoPackagesNavigationViewModelChanged is sent before #subscribeToPharoPackagesNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	| theItems |

	theItems := {
		#package -> [ :aViewModel | aViewModel pharoTagsNavigationViewModel pharoTagNavigationViewModels ].
		#tag -> [ :aViewModel | #() ].
	} asDictionary.

	self
		items: self pharoPackagesNavigationViewModel pharoPackageNavigationViewModels
		lazy: [ :eachViewModel |
			| theItemsBlock |
			theItemsBlock := theItems at: eachViewModel viewModelName.
			theItemsBlock value: eachViewModel ]
]
