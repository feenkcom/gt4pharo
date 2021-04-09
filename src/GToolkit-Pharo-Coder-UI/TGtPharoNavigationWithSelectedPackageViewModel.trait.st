"
! With selected package view model 
Is used to add support for ==selectedPackageViewModel== to a user class.
!! Implemented api:
The trait implements the following methods:
 - ${method:TGtPharoNavigationWithSelectedPackageViewModel>>#selectedPackageViewModel}$ to get the value of the selected package view model
 - ${method:TGtPharoNavigationWithSelectedPackageViewModel>>#selectPackageViewModel:}$ to set a new value of the selected package view model
 - ${method:TGtPharoNavigationWithSelectedPackageViewModel>>#deselectPackageViewModel}$ to unset the value of the selected package view model (set it to nil)
 - ${method:TGtPharoNavigationWithSelectedPackageViewModel>>#hasSelectedPackageViewModel}$ to check if the selected package view model has an assigned value (the default value is nil)
 - ${method:TGtPharoNavigationWithSelectedPackageViewModel>>#notifySelectedPackageViewModelChanged}$ to announce changes to the value of the selected package view model. By default does nothing and users are expected to provide a domain specific implementation with a domain specific event
 - ${method:TGtPharoNavigationWithSelectedPackageViewModel>>#onPreviousSelectedPackageViewModelUnset:}$ (advanced) - is a hook sent after a previous non-nil value of the selected package view model is unset. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a cleanup of the previous value or exlicitly notify the previous value that it is no longer in use.
 - ${method:TGtPharoNavigationWithSelectedPackageViewModel>>#onNewSelectedPackageViewModelSet:}$ (advanced) - is a hook sent after a new value of the selected package view model is set. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a set up of the new value or exlicitly notify the new value that it is now in use.
!! Generation
${class:TGtPharoNavigationWithSelectedPackageViewModel}$ was automatically generated with the following code:
[[[
GtWithPropertyTraitGenerator new
	propertyName: 'selectedPackageViewModel';
	propertySetter: 'selectPackageViewModel';
	propertyUnsetter: 'deselectPackageViewModel';
	propertyType: 'GtPharoPackageNavigationViewModel';
	propertyComparator: #=;
	projectPrefix: 'GtPharoNavigation';
	packageName: 'GToolkit-Pharo-Coder-UI-Navigation - View Models';
	generate
]]] 

"
Trait {
	#name : #TGtPharoNavigationWithSelectedPackageViewModel,
	#instVars : [
		'selectedPackageViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - selected package view model' }
TGtPharoNavigationWithSelectedPackageViewModel >> deselectPackageViewModel [
	| aPreviousSelectedPackageViewModel |

	selectedPackageViewModel
		ifNil: [ ^ self ].

	aPreviousSelectedPackageViewModel := selectedPackageViewModel.
	selectedPackageViewModel := nil.
	self onPreviousSelectedPackageViewModelUnset: aPreviousSelectedPackageViewModel.
	self notifySelectedPackageViewModelChanged
]

{ #category : #'api - selected package view model' }
TGtPharoNavigationWithSelectedPackageViewModel >> hasSelectedPackageViewModel [
	<return: #Boolean>

	^ selectedPackageViewModel notNil
]

{ #category : #'api - selected package view model' }
TGtPharoNavigationWithSelectedPackageViewModel >> notifySelectedPackageViewModelChanged [
	"Override this notify method to announce changes to the property"
]

{ #category : #'api - selected package view model' }
TGtPharoNavigationWithSelectedPackageViewModel >> onNewSelectedPackageViewModelSet: aNewSelectedPackageViewModel [
	"Is sent after a new value of the selectedPackageViewModel is assigned"
]

{ #category : #'api - selected package view model' }
TGtPharoNavigationWithSelectedPackageViewModel >> onPreviousSelectedPackageViewModelUnset: aPreviousSelectedPackageViewModel [
	"Is sent after a previous value of the selectedPackageViewModel is de-assigned"
]

{ #category : #'api - selected package view model' }
TGtPharoNavigationWithSelectedPackageViewModel >> selectPackageViewModel: aNewSelectedPackageViewModel [
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
TGtPharoNavigationWithSelectedPackageViewModel >> selectedPackageViewModel [
	<return: #GtPharoPackageNavigationViewModel>

	^ selectedPackageViewModel
]
