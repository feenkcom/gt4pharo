Class {
	#name : #Gt2PharoPackagesNavigationElement,
	#superclass : #BrSimpleTree,
	#traits : 'TGt2WithPharoPackagesNavigationViewModel',
	#classTraits : 'TGt2WithPharoPackagesNavigationViewModel classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
Gt2PharoPackagesNavigationElement >> initialize [
	super initialize.
	
	self withoutSelection.

	self nodeType: [ :aTypeFactory :aTreeNode |
		{
			#package -> Gt2PharoPackageNavigationElement.
			#tag -> Gt2PharoPackageTagNavigationElement.
			#class -> Gt2PharoPackageClassNavigationElement
		} asDictionary at: aTreeNode value viewModelName ].

	self nodeStencil: [ :anElementClass | anElementClass new ].

	self nodeDataBinder: [ :eachNodeElement :eachTreeNode |
		| aViewModelSetter |
		aViewModelSetter := {
			#package -> #pharoPackageNavigationViewModel:.
			#tag -> #pharoTagNavigationViewModel:.
			#class -> #pharoClassNavigationViewModel:
		} asDictionary at: eachTreeNode value viewModelName.
		eachNodeElement perform: aViewModelSetter with: eachTreeNode value ]
]

{ #category : #'api - pharo packages navigation view model' }
Gt2PharoPackagesNavigationElement >> onPharoPackagesNavigationViewModelChanged [
	"Is sent when a new pharoPackagesNavigation view model is assigned to the element.
	Note: #onPharoPackagesNavigationViewModelChanged is sent before #subscribeToPharoPackagesNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	| theItems |

	theItems := {
		#package -> [ :aViewModel | aViewModel pharoTagsNavigationViewModel pharoTagNavigationViewModels ].
		#tag -> [ :aViewModel | aViewModel pharoClassesNavigationViewModel pharoClassNavigationViewModels ].
		#class -> [ :aViewModel | #() ]
	} asDictionary.

	self
		items: self pharoPackagesNavigationViewModel pharoPackageNavigationViewModels
		lazy: [ :eachViewModel |
			| theItemsBlock |
			theItemsBlock := theItems at: eachViewModel viewModelName.
			theItemsBlock value: eachViewModel ]
]
