"
! With selected package tag view model 
Is used to add support for ==selectedPackageTagViewModel== to a user class.
!! Implemented api:
The trait implements the following methods:
 - ${method:TGtPharoNavigationWithSelectedPackageTagViewModel>>#selectedPackageTagViewModel}$ to get the value of the selected package tag view model
 - ${method:TGtPharoNavigationWithSelectedPackageTagViewModel>>#selectPackageTagViewModel:}$ to set a new value of the selected package tag view model
 - ${method:TGtPharoNavigationWithSelectedPackageTagViewModel>>#deselectPackageTagViewModel}$ to unset the value of the selected package tag view model (set it to nil)
 - ${method:TGtPharoNavigationWithSelectedPackageTagViewModel>>#hasSelectedPackageTagViewModel}$ to check if the selected package tag view model has an assigned value (the default value is nil)
 - ${method:TGtPharoNavigationWithSelectedPackageTagViewModel>>#notifySelectedPackageTagViewModelChanged}$ to announce changes to the value of the selected package tag view model. By default does nothing and users are expected to provide a domain specific implementation with a domain specific event
 - ${method:TGtPharoNavigationWithSelectedPackageTagViewModel>>#onPreviousSelectedPackageTagViewModelUnset:}$ (advanced) - is a hook sent after a previous non-nil value of the selected package tag view model is unset. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a cleanup of the previous value or exlicitly notify the previous value that it is no longer in use.
 - ${method:TGtPharoNavigationWithSelectedPackageTagViewModel>>#onNewSelectedPackageTagViewModelSet:}$ (advanced) - is a hook sent after a new value of the selected package tag view model is set. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a set up of the new value or exlicitly notify the new value that it is now in use.
!! Generation
${class:TGtPharoNavigationWithSelectedPackageTagViewModel}$ was automatically generated with the following code:
[[[
GtWithPropertyTraitGenerator new
	propertyName: 'selectedPackageTagViewModel';
	propertySetter: 'selectPackageTagViewModel';
	propertyUnsetter: 'deselectPackageTagViewModel';
	propertyType: 'GtPharoPackageTagNavigationViewModel';
	propertyComparator: #=;
	projectPrefix: 'GtPharoNavigation';
	packageName: 'GToolkit-Pharo-Coder-UI-Navigation - View Models';
	generate
]]] 

"
Trait {
	#name : #TGtPharoNavigationWithSelectedPackageTagViewModel,
	#instVars : [
		'selectedPackageTagViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - selected package tag view model' }
TGtPharoNavigationWithSelectedPackageTagViewModel >> deselectPackageTagViewModel [
	| aPreviousSelectedPackageTagViewModel |

	selectedPackageTagViewModel
		ifNil: [ ^ self ].

	aPreviousSelectedPackageTagViewModel := selectedPackageTagViewModel.
	selectedPackageTagViewModel := nil.
	self onPreviousSelectedPackageTagViewModelUnset: aPreviousSelectedPackageTagViewModel.
	self notifySelectedPackageTagViewModelChanged
]

{ #category : #'api - selected package tag view model' }
TGtPharoNavigationWithSelectedPackageTagViewModel >> hasSelectedPackageTagViewModel [
	<return: #Boolean>

	^ selectedPackageTagViewModel notNil
]

{ #category : #'api - selected package tag view model' }
TGtPharoNavigationWithSelectedPackageTagViewModel >> notifySelectedPackageTagViewModelChanged [
	"Override this notify method to announce changes to the property"
]

{ #category : #'api - selected package tag view model' }
TGtPharoNavigationWithSelectedPackageTagViewModel >> onNewSelectedPackageTagViewModelSet: aNewSelectedPackageTagViewModel [
	"Is sent after a new value of the selectedPackageTagViewModel is assigned"
]

{ #category : #'api - selected package tag view model' }
TGtPharoNavigationWithSelectedPackageTagViewModel >> onPreviousSelectedPackageTagViewModelUnset: aPreviousSelectedPackageTagViewModel [
	"Is sent after a previous value of the selectedPackageTagViewModel is de-assigned"
]

{ #category : #'api - selected package tag view model' }
TGtPharoNavigationWithSelectedPackageTagViewModel >> selectPackageTagViewModel: aNewSelectedPackageTagViewModel [
	(self selectedPackageTagViewModel = aNewSelectedPackageTagViewModel)
		ifTrue: [ ^ self ].
	
	self hasSelectedPackageTagViewModel
		ifTrue: [
			| aPreviousSelectedPackageTagViewModel |
			aPreviousSelectedPackageTagViewModel := selectedPackageTagViewModel.
			selectedPackageTagViewModel := nil.
			self onPreviousSelectedPackageTagViewModelUnset: aPreviousSelectedPackageTagViewModel ].
	selectedPackageTagViewModel := aNewSelectedPackageTagViewModel.
	self onNewSelectedPackageTagViewModelSet: aNewSelectedPackageTagViewModel.
	self notifySelectedPackageTagViewModelChanged
]

{ #category : #'api - selected package tag view model' }
TGtPharoNavigationWithSelectedPackageTagViewModel >> selectedPackageTagViewModel [
	<return: #GtPharoPackageTagNavigationViewModel>

	^ selectedPackageTagViewModel
]
