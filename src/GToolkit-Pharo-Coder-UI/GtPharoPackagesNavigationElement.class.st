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
	
	self withoutSelection.
	self nodeType: [ :aTypeFactory :aTreeNode | aTreeNode value isPackageViewModel ].

	self nodeStencil: [ :isPackage |
		isPackage
			ifTrue: [ GtPharoPackageNavigationElement new ]
			ifFalse: [ GtPharoPackageTagNavigationElement new ] ].

	self nodeDataBinder: [ :eachNodeElement :eachTreeNode |
		eachTreeNode value isPackageViewModel
			ifTrue: [ eachNodeElement pharoPackageNavigationViewModel: eachTreeNode value ]
			ifFalse: [ eachNodeElement pharoPackageTagNavigationViewModel: eachTreeNode value ] ]
]

{ #category : #'api - pharo packages navigation view model' }
GtPharoPackagesNavigationElement >> onPharoPackagesNavigationViewModelChanged [
	"Is sent when a new pharoPackagesNavigation view model is assigned to the element.
	Note: #onPharoPackagesNavigationViewModelChanged is sent before #subscribeToPharoPackagesNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self
		items: self pharoPackagesNavigationViewModel packageViewModels
		lazy: [ :eachPackageOrTagViewModel |
			eachPackageOrTagViewModel isPackageViewModel
				ifTrue: [ eachPackageOrTagViewModel packageTagViewModels ]
				ifFalse: [ #() ] ]
]
