Trait {
	#name : #TGt2WithSelectedBehaviorCoderNavigationViewModel,
	#instVars : [
		'selectedBehaviorCoderNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - Support'
}

{ #category : #'api - selected behavior coder navigation view model' }
TGt2WithSelectedBehaviorCoderNavigationViewModel >> deselectBehaviorCoderNavigationViewModel [
	<propertyUnsetter: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousSelectedBehaviorCoderNavigationViewModel |

	self hasSelectedBehaviorCoderNavigationViewModel
		ifFalse: [ ^ self ].

	aPreviousSelectedBehaviorCoderNavigationViewModel := selectedBehaviorCoderNavigationViewModel.
	selectedBehaviorCoderNavigationViewModel := nil.
	self onPreviousSelectedBehaviorCoderNavigationViewModelUnset: aPreviousSelectedBehaviorCoderNavigationViewModel.
	self notifySelectedBehaviorCoderNavigationViewModelChanged
]

{ #category : #'api - selected behavior coder navigation view model' }
TGt2WithSelectedBehaviorCoderNavigationViewModel >> hasSelectedBehaviorCoderNavigationViewModel [
	<return: #Boolean>
	<propertyTester: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ selectedBehaviorCoderNavigationViewModel notNil
]

{ #category : #'api - selected behavior coder navigation view model' }
TGt2WithSelectedBehaviorCoderNavigationViewModel >> notifySelectedBehaviorCoderNavigationViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
]

{ #category : #'api - selected behavior coder navigation view model' }
TGt2WithSelectedBehaviorCoderNavigationViewModel >> onNewSelectedBehaviorCoderNavigationViewModelSet: aNewSelectedBehaviorCoderNavigationViewModel [
	"Is sent after a new value of the selectedBehaviorCoderNavigationViewModel is assigned"
	<propertySetHook: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - selected behavior coder navigation view model' }
TGt2WithSelectedBehaviorCoderNavigationViewModel >> onPreviousSelectedBehaviorCoderNavigationViewModelUnset: aPreviousSelectedBehaviorCoderNavigationViewModel [
	"Is sent after a previous value of the selectedBehaviorCoderNavigationViewModel is de-assigned"
	<propertyUnsetHook: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - selected behavior coder navigation view model' }
TGt2WithSelectedBehaviorCoderNavigationViewModel >> selectBehaviorCoderNavigationViewModel: aNewSelectedBehaviorCoderNavigationViewModel [
	<propertySetter: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasSelectedBehaviorCoderNavigationViewModel
		and: [ self selectedBehaviorCoderNavigationViewModel = aNewSelectedBehaviorCoderNavigationViewModel ])
			ifTrue: [ ^ self ].
	
	self hasSelectedBehaviorCoderNavigationViewModel
		ifTrue: [
			| aPreviousSelectedBehaviorCoderNavigationViewModel |
			aPreviousSelectedBehaviorCoderNavigationViewModel := selectedBehaviorCoderNavigationViewModel.
			selectedBehaviorCoderNavigationViewModel := nil.
			self onPreviousSelectedBehaviorCoderNavigationViewModelUnset: aPreviousSelectedBehaviorCoderNavigationViewModel ].
	selectedBehaviorCoderNavigationViewModel := aNewSelectedBehaviorCoderNavigationViewModel.
	self onNewSelectedBehaviorCoderNavigationViewModelSet: aNewSelectedBehaviorCoderNavigationViewModel.
	self notifySelectedBehaviorCoderNavigationViewModelChanged
]

{ #category : #'api - selected behavior coder navigation view model' }
TGt2WithSelectedBehaviorCoderNavigationViewModel >> selectedBehaviorCoderNavigationViewModel [
	<return: #Gt2PharoBehaviorCoderNavigationViewModel>
	<propertyGetter: #selectedBehaviorCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ selectedBehaviorCoderNavigationViewModel
]
