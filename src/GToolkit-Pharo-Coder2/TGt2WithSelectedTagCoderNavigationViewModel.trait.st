Trait {
	#name : #TGt2WithSelectedTagCoderNavigationViewModel,
	#instVars : [
		'selectedTagCoderNavigationViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Navigation - Support'
}

{ #category : #'api - selected tag coder navigation view model' }
TGt2WithSelectedTagCoderNavigationViewModel >> deselectTagCoderNavigationViewModel [
	<propertyUnsetter: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousSelectedTagCoderNavigationViewModel |

	self hasSelectedTagCoderNavigationViewModel
		ifFalse: [ ^ self ].

	aPreviousSelectedTagCoderNavigationViewModel := selectedTagCoderNavigationViewModel.
	selectedTagCoderNavigationViewModel := nil.
	self onPreviousSelectedTagCoderNavigationViewModelUnset: aPreviousSelectedTagCoderNavigationViewModel.
	self notifySelectedTagCoderNavigationViewModelChanged
]

{ #category : #'api - selected tag coder navigation view model' }
TGt2WithSelectedTagCoderNavigationViewModel >> hasSelectedTagCoderNavigationViewModel [
	<return: #Boolean>
	<propertyTester: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ selectedTagCoderNavigationViewModel notNil
]

{ #category : #'api - selected tag coder navigation view model' }
TGt2WithSelectedTagCoderNavigationViewModel >> notifySelectedTagCoderNavigationViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
]

{ #category : #'api - selected tag coder navigation view model' }
TGt2WithSelectedTagCoderNavigationViewModel >> onNewSelectedTagCoderNavigationViewModelSet: aNewSelectedTagCoderNavigationViewModel [
	"Is sent after a new value of the selectedTagCoderNavigationViewModel is assigned"
	<propertySetHook: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - selected tag coder navigation view model' }
TGt2WithSelectedTagCoderNavigationViewModel >> onPreviousSelectedTagCoderNavigationViewModelUnset: aPreviousSelectedTagCoderNavigationViewModel [
	"Is sent after a previous value of the selectedTagCoderNavigationViewModel is de-assigned"
	<propertyUnsetHook: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - selected tag coder navigation view model' }
TGt2WithSelectedTagCoderNavigationViewModel >> selectTagCoderNavigationViewModel: aNewSelectedTagCoderNavigationViewModel [
	<propertySetter: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasSelectedTagCoderNavigationViewModel
		and: [ self selectedTagCoderNavigationViewModel = aNewSelectedTagCoderNavigationViewModel ])
			ifTrue: [ ^ self ].
	
	self hasSelectedTagCoderNavigationViewModel
		ifTrue: [
			| aPreviousSelectedTagCoderNavigationViewModel |
			aPreviousSelectedTagCoderNavigationViewModel := selectedTagCoderNavigationViewModel.
			selectedTagCoderNavigationViewModel := nil.
			self onPreviousSelectedTagCoderNavigationViewModelUnset: aPreviousSelectedTagCoderNavigationViewModel ].
	selectedTagCoderNavigationViewModel := aNewSelectedTagCoderNavigationViewModel.
	self onNewSelectedTagCoderNavigationViewModelSet: aNewSelectedTagCoderNavigationViewModel.
	self notifySelectedTagCoderNavigationViewModelChanged
]

{ #category : #'api - selected tag coder navigation view model' }
TGt2WithSelectedTagCoderNavigationViewModel >> selectedTagCoderNavigationViewModel [
	<return: #Gt2PharoTagCoderNavigationViewModel>
	<propertyGetter: #selectedTagCoderNavigationViewModel>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ selectedTagCoderNavigationViewModel
]
