Trait {
	#name : #TGt2WithSelectedPackageCoderNavigationViewModel,
	#instVars : [
		'selectedPackageCoderNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - Support'
}

{ #category : #'api - selected package coder navigation view model' }
TGt2WithSelectedPackageCoderNavigationViewModel >> deselectPackageCoderNavigationViewModel [
	<propertyUnsetter: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousSelectedPackageCoderNavigationViewModel |

	self hasSelectedPackageCoderNavigationViewModel
		ifFalse: [ ^ self ].

	aPreviousSelectedPackageCoderNavigationViewModel := selectedPackageCoderNavigationViewModel.
	selectedPackageCoderNavigationViewModel := nil.
	self onPreviousSelectedPackageCoderNavigationViewModelUnset: aPreviousSelectedPackageCoderNavigationViewModel.
	self notifySelectedPackageCoderNavigationViewModelChanged
]

{ #category : #'api - selected package coder navigation view model' }
TGt2WithSelectedPackageCoderNavigationViewModel >> hasSelectedPackageCoderNavigationViewModel [
	<return: #Boolean>
	<propertyTester: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ selectedPackageCoderNavigationViewModel notNil
]

{ #category : #'api - selected package coder navigation view model' }
TGt2WithSelectedPackageCoderNavigationViewModel >> notifySelectedPackageCoderNavigationViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
]

{ #category : #'api - selected package coder navigation view model' }
TGt2WithSelectedPackageCoderNavigationViewModel >> onNewSelectedPackageCoderNavigationViewModelSet: aNewSelectedPackageCoderNavigationViewModel [
	"Is sent after a new value of the selectedPackageCoderNavigationViewModel is assigned"
	<propertySetHook: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - selected package coder navigation view model' }
TGt2WithSelectedPackageCoderNavigationViewModel >> onPreviousSelectedPackageCoderNavigationViewModelUnset: aPreviousSelectedPackageCoderNavigationViewModel [
	"Is sent after a previous value of the selectedPackageCoderNavigationViewModel is de-assigned"
	<propertyUnsetHook: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - selected package coder navigation view model' }
TGt2WithSelectedPackageCoderNavigationViewModel >> selectPackageCoderNavigationViewModel: aNewSelectedPackageCoderNavigationViewModel [
	<propertySetter: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasSelectedPackageCoderNavigationViewModel
		and: [ self selectedPackageCoderNavigationViewModel = aNewSelectedPackageCoderNavigationViewModel ])
			ifTrue: [ ^ self ].
	
	self hasSelectedPackageCoderNavigationViewModel
		ifTrue: [
			| aPreviousSelectedPackageCoderNavigationViewModel |
			aPreviousSelectedPackageCoderNavigationViewModel := selectedPackageCoderNavigationViewModel.
			selectedPackageCoderNavigationViewModel := nil.
			self onPreviousSelectedPackageCoderNavigationViewModelUnset: aPreviousSelectedPackageCoderNavigationViewModel ].
	selectedPackageCoderNavigationViewModel := aNewSelectedPackageCoderNavigationViewModel.
	self onNewSelectedPackageCoderNavigationViewModelSet: aNewSelectedPackageCoderNavigationViewModel.
	self notifySelectedPackageCoderNavigationViewModelChanged
]

{ #category : #'api - selected package coder navigation view model' }
TGt2WithSelectedPackageCoderNavigationViewModel >> selectedPackageCoderNavigationViewModel [
	<return: #Gt2PharoPackageCoderNavigationViewModel>
	<propertyGetter: #selectedPackageCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ selectedPackageCoderNavigationViewModel
]
