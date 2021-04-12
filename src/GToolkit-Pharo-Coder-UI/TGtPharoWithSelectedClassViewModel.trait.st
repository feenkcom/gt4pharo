"
! With selected class view model 
Is used to add support for ==selectedClassViewModel== to a user class.
!! Implemented api:
The trait implements the following methods:
 - ${method:TGtPharoWithSelectedClassViewModel>>#selectedClassViewModel}$ to get the value of the selected class view model
 - ${method:TGtPharoWithSelectedClassViewModel>>#selectClassViewModel:}$ to set a new value of the selected class view model
 - ${method:TGtPharoWithSelectedClassViewModel>>#deselectClassViewModel}$ to unset the value of the selected class view model (set it to nil)
 - ${method:TGtPharoWithSelectedClassViewModel>>#hasSelectedClassViewModel}$ to check if the selected class view model has an assigned value (the default value is nil)
 - ${method:TGtPharoWithSelectedClassViewModel>>#notifySelectedClassViewModelChanged}$ to announce changes to the value of the selected class view model. By default does nothing and users are expected to provide a domain specific implementation with a domain specific event
 - ${method:TGtPharoWithSelectedClassViewModel>>#onPreviousSelectedClassViewModelUnset:}$ (advanced) - is a hook sent after a previous non-nil value of the selected class view model is unset. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a cleanup of the previous value or exlicitly notify the previous value that it is no longer in use.
 - ${method:TGtPharoWithSelectedClassViewModel>>#onNewSelectedClassViewModelSet:}$ (advanced) - is a hook sent after a new value of the selected class view model is set. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a set up of the new value or exlicitly notify the new value that it is now in use.
!! Generation
${class:TGtPharoWithSelectedClassViewModel}$ was automatically generated with the following code:
[[[
GtWithPropertyTraitGenerator new
	propertyName: 'selectedClassViewModel';
	propertySetter: 'selectClassViewModel';
	propertyUnsetter: 'deselectClassViewModel';
	propertyType: 'GtPharoClassNavigationViewModel';
	propertyComparator: #=;
	projectPrefix: 'GtPharo';
	packageName: 'GToolkit-Pharo-Coder-UI';
	tagName: 'Navigation - Support';
	generate
]]] 

"
Trait {
	#name : #TGtPharoWithSelectedClassViewModel,
	#instVars : [
		'selectedClassViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - selected class view model' }
TGtPharoWithSelectedClassViewModel >> deselectClassViewModel [
	<propertyUnsetter: #selectedClassViewModel>
	| aPreviousSelectedClassViewModel |

	selectedClassViewModel
		ifNil: [ ^ self ].

	aPreviousSelectedClassViewModel := selectedClassViewModel.
	selectedClassViewModel := nil.
	self onPreviousSelectedClassViewModelUnset: aPreviousSelectedClassViewModel.
	self notifySelectedClassViewModelChanged
]

{ #category : #'api - selected class view model' }
TGtPharoWithSelectedClassViewModel >> hasSelectedClassViewModel [
	<return: #Boolean>
	<propertyTester: #selectedClassViewModel>

	^ selectedClassViewModel notNil
]

{ #category : #'api - selected class view model' }
TGtPharoWithSelectedClassViewModel >> notifySelectedClassViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedClassViewModel>
]

{ #category : #'api - selected class view model' }
TGtPharoWithSelectedClassViewModel >> onNewSelectedClassViewModelSet: aNewSelectedClassViewModel [
	"Is sent after a new value of the selectedClassViewModel is assigned"
	<propertySetHook: #selectedClassViewModel>
]

{ #category : #'api - selected class view model' }
TGtPharoWithSelectedClassViewModel >> onPreviousSelectedClassViewModelUnset: aPreviousSelectedClassViewModel [
	"Is sent after a previous value of the selectedClassViewModel is de-assigned"
	<propertyUnsetHook: #selectedClassViewModel>
]

{ #category : #'api - selected class view model' }
TGtPharoWithSelectedClassViewModel >> selectClassViewModel: aNewSelectedClassViewModel [
	<propertySetter: #selectedClassViewModel>

	(self selectedClassViewModel = aNewSelectedClassViewModel)
		ifTrue: [ ^ self ].
	
	self hasSelectedClassViewModel
		ifTrue: [
			| aPreviousSelectedClassViewModel |
			aPreviousSelectedClassViewModel := selectedClassViewModel.
			selectedClassViewModel := nil.
			self onPreviousSelectedClassViewModelUnset: aPreviousSelectedClassViewModel ].
	selectedClassViewModel := aNewSelectedClassViewModel.
	self onNewSelectedClassViewModelSet: aNewSelectedClassViewModel.
	self notifySelectedClassViewModelChanged
]

{ #category : #'api - selected class view model' }
TGtPharoWithSelectedClassViewModel >> selectedClassViewModel [
	<return: #GtPharoClassNavigationViewModel>
	<propertyGetter: #selectedClassViewModel>

	^ selectedClassViewModel
]
