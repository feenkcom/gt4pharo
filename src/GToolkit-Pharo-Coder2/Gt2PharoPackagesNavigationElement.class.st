Class {
	#name : #Gt2PharoPackagesNavigationElement,
	#superclass : #BrSimpleTree,
	#traits : 'TGt2WithPharoPackagesCoderNavigationViewModel',
	#classTraits : 'TGt2WithPharoPackagesCoderNavigationViewModel classTrait',
	#category : #'GToolkit-Pharo-Coder2-Navigation - Views'
}

{ #category : #initialization }
Gt2PharoPackagesNavigationElement >> initialize [
	super initialize.

	self withoutSelection.

	self nodeType: [ :aTypeFactory :aTreeNode |
		{
			#package -> Gt2PharoPackageNavigationElement.
			#tag -> Gt2PharoTagNavigationElement.
		} asDictionary at: aTreeNode value objectName ].

	self nodeStencil: [ :anElementClass | anElementClass new ].

	self nodeDataBinder: [ :eachNodeElement :eachTreeNode |
		| aViewModelSetter |
		aViewModelSetter := {
			#package -> #pharoPackageCoderNavigationViewModel:.
			#tag -> #pharoTagCoderNavigationViewModel:.
		} asDictionary at: eachTreeNode value objectName.
		eachNodeElement perform: aViewModelSetter with: eachTreeNode value ]
]

{ #category : #'api - pharo packages coder navigation view model' }
Gt2PharoPackagesNavigationElement >> onPharoPackagesCoderNavigationViewModelChanged [
	"Is sent when a new pharoPackagesCoderNavigationViewModel is assigned to the receiver.
	Note: #onPharoPackagesCoderNavigationViewModelChanged is sent before #subscribeToPharoPackagesCoderNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesCoderNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	| theItems |

	theItems := {
		#package -> [ :aViewModel |
			aViewModel pharoTagsCoderNavigationViewModel pharoTagCoderNavigationViewModels sorted: [ :a :b |
				a tagName < b tagName ] ].
		#tag -> [ :aViewModel | #() ].
	} asDictionary.

	self
		items: (self pharoPackagesCoderNavigationViewModel pharoPackageCoderNavigationViewModels sorted: [ :a :b | a packageName < b packageName ])
		lazy: [ :eachViewModel |
			| theItemsBlock |
			theItemsBlock := theItems at: eachViewModel objectName.
			theItemsBlock value: eachViewModel ]
]
