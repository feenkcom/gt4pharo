"
# With selected package view model 
Is used to add support for `selectedPackageViewModel` to a user class.
## Implemented api:
The trait implements the following methods:
 - {{gtMethod:TGtPharoWithSelectedPackageViewModel>>#selectedPackageViewModel}} to get the value of the selected package view model
 - {{gtMethod:TGtPharoWithSelectedPackageViewModel>>#selectPackageViewModel:}} to set a new value of the selected package view model
 - {{gtMethod:TGtPharoWithSelectedPackageViewModel>>#deselectPackageViewModel}} to unset the value of the selected package view model (set it to nil)
 - {{gtMethod:TGtPharoWithSelectedPackageViewModel>>#hasSelectedPackageViewModel}} to check if the selected package view model has an assigned value (the default value is nil)
 - {{gtMethod:TGtPharoWithSelectedPackageViewModel>>#notifySelectedPackageViewModelChanged}} to announce changes to the value of the selected package view model. By default does nothing and users are expected to provide a domain specific implementation with a domain specific event
 - {{gtMethod:TGtPharoWithSelectedPackageViewModel>>#onPreviousSelectedPackageViewModelUnset:}} (advanced) - is a hook sent after a previous non-nil value of the selected package view model is unset. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a cleanup of the previous value or exlicitly notify the previous value that it is no longer in use.
 - {{gtMethod:TGtPharoWithSelectedPackageViewModel>>#onNewSelectedPackageViewModelSet:}} (advanced) - is a hook sent after a new value of the selected package view model is set. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a set up of the new value or exlicitly notify the new value that it is now in use.
## Generation
{{gtClass:TGtPharoWithSelectedPackageViewModel}} was automatically generated with the following code:
```
GtWithPropertyTraitGenerator new
	propertyName: 'selectedPackageViewModel';
	propertySetter: 'selectPackageViewModel';
	propertyUnsetter: 'deselectPackageViewModel';
	propertyType: 'GtPharoPackageNavigationViewModel';
	propertyComparator: #=;
	projectPrefix: 'GtPharo';
	packageName: 'GToolkit-Pharo-Coder-UI';
	tagName: 'Navigation - Support';
	generate
]```

"
Trait {
	#name : #TGtPharoWithSelectedPackageViewModel,
	#instVars : [
		'selectedPackageViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> deselectPackageViewModel [
	<propertyUnsetter: #selectedPackageViewModel>
	| aPreviousSelectedPackageViewModel |

	selectedPackageViewModel
		ifNil: [ ^ self ].

	aPreviousSelectedPackageViewModel := selectedPackageViewModel.
	selectedPackageViewModel := nil.
	self onPreviousSelectedPackageViewModelUnset: aPreviousSelectedPackageViewModel.
	self notifySelectedPackageViewModelChanged
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> hasSelectedPackageViewModel [
	<return: #Boolean>
	<propertyTester: #selectedPackageViewModel>

	^ selectedPackageViewModel notNil
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> notifySelectedPackageViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedPackageViewModel>
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> onNewSelectedPackageViewModelSet: aNewSelectedPackageViewModel [
	"Is sent after a new value of the selectedPackageViewModel is assigned"
	<propertySetHook: #selectedPackageViewModel>
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> onPreviousSelectedPackageViewModelUnset: aPreviousSelectedPackageViewModel [
	"Is sent after a previous value of the selectedPackageViewModel is de-assigned"
	<propertyUnsetHook: #selectedPackageViewModel>
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> selectPackageViewModel: aNewSelectedPackageViewModel [
	<propertySetter: #selectedPackageViewModel>

	(self selectedPackageViewModel = aNewSelectedPackageViewModel)
		ifTrue: [ ^ self ].
	
	self hasSelectedPackageViewModel
		ifTrue: [
			| aPreviousSelectedPackageViewModel |
			aPreviousSelectedPackageViewModel := selectedPackageViewModel.
			selectedPackageViewModel := nil.
			self onPreviousSelectedPackageViewModelUnset: aPreviousSelectedPackageViewModel ].
	selectedPackageViewModel := aNewSelectedPackageViewModel.
	self onNewSelectedPackageViewModelSet: aNewSelectedPackageViewModel.
	self notifySelectedPackageViewModelChanged
]

{ #category : #'api - selected package view model' }
TGtPharoWithSelectedPackageViewModel >> selectedPackageViewModel [
	<return: #GtPharoPackageNavigationViewModel>
	<propertyGetter: #selectedPackageViewModel>

	^ selectedPackageViewModel
]
