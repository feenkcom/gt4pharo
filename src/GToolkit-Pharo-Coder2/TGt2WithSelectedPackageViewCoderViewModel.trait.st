Trait {
	#name : #TGt2WithSelectedPackageViewCoderViewModel,
	#instVars : [
		'selectedPackageViewCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Support'
}

{ #category : #'api - selected package view coder view model' }
TGt2WithSelectedPackageViewCoderViewModel >> deselectPackageViewCoderViewModel [
	<propertyUnsetter: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousSelectedPackageViewCoderViewModel |

	self hasSelectedPackageViewCoderViewModel
		ifFalse: [ ^ self ].

	aPreviousSelectedPackageViewCoderViewModel := selectedPackageViewCoderViewModel.
	selectedPackageViewCoderViewModel := nil.
	self onPreviousSelectedPackageViewCoderViewModelUnset: aPreviousSelectedPackageViewCoderViewModel.
	self notifySelectedPackageViewCoderViewModelChanged
]

{ #category : #'api - selected package view coder view model' }
TGt2WithSelectedPackageViewCoderViewModel >> hasSelectedPackageViewCoderViewModel [
	<return: #Boolean>
	<propertyTester: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ selectedPackageViewCoderViewModel notNil
]

{ #category : #'api - selected package view coder view model' }
TGt2WithSelectedPackageViewCoderViewModel >> notifySelectedPackageViewCoderViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
]

{ #category : #'api - selected package view coder view model' }
TGt2WithSelectedPackageViewCoderViewModel >> onNewSelectedPackageViewCoderViewModelSet: aNewSelectedPackageViewCoderViewModel [
	"Is sent after a new value of the selectedPackageViewCoderViewModel is assigned"
	<propertySetHook: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - selected package view coder view model' }
TGt2WithSelectedPackageViewCoderViewModel >> onPreviousSelectedPackageViewCoderViewModelUnset: aPreviousSelectedPackageViewCoderViewModel [
	"Is sent after a previous value of the selectedPackageViewCoderViewModel is de-assigned"
	<propertyUnsetHook: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - selected package view coder view model' }
TGt2WithSelectedPackageViewCoderViewModel >> selectPackageViewCoderViewModel: aNewSelectedPackageViewCoderViewModel [
	<propertySetter: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasSelectedPackageViewCoderViewModel
		and: [ self selectedPackageViewCoderViewModel = aNewSelectedPackageViewCoderViewModel ])
			ifTrue: [ ^ self ].
	
	self hasSelectedPackageViewCoderViewModel
		ifTrue: [
			| aPreviousSelectedPackageViewCoderViewModel |
			aPreviousSelectedPackageViewCoderViewModel := selectedPackageViewCoderViewModel.
			selectedPackageViewCoderViewModel := nil.
			self onPreviousSelectedPackageViewCoderViewModelUnset: aPreviousSelectedPackageViewCoderViewModel ].
	selectedPackageViewCoderViewModel := aNewSelectedPackageViewCoderViewModel.
	self onNewSelectedPackageViewCoderViewModelSet: aNewSelectedPackageViewCoderViewModel.
	self notifySelectedPackageViewCoderViewModelChanged
]

{ #category : #'api - selected package view coder view model' }
TGt2WithSelectedPackageViewCoderViewModel >> selectedPackageViewCoderViewModel [
	<return: #Gt2PharoPackageViewCoderViewModel>
	<propertyGetter: #selectedPackageViewCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ selectedPackageViewCoderViewModel
]
