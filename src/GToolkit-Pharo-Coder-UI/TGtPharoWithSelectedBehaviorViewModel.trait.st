"
# With selected behavior view model 
Is used to add support for `selectedBehaviorViewModel` to a user class.
## Implemented api:
The trait implements the following methods:
 - {{gtMethod:TGtPharoWithSelectedBehaviorViewModel>>#selectedBehaviorViewModel}} to get the value of the selected behavior view model
 - {{gtMethod:TGtPharoWithSelectedBehaviorViewModel>>#selectBehaviorViewModel:}} to set a new value of the selected behavior view model
 - {{gtMethod:TGtPharoWithSelectedBehaviorViewModel>>#deselectBehaviorViewModel}} to unset the value of the selected behavior view model (set it to nil)
 - {{gtMethod:TGtPharoWithSelectedBehaviorViewModel>>#hasSelectedBehaviorViewModel}} to check if the selected behavior view model has an assigned value (the default value is nil)
 - {{gtMethod:TGtPharoWithSelectedBehaviorViewModel>>#notifySelectedBehaviorViewModelChanged}} to announce changes to the value of the selected behavior view model. By default does nothing and users are expected to provide a domain specific implementation with a domain specific event
 - {{gtMethod:TGtPharoWithSelectedBehaviorViewModel>>#onPreviousSelectedBehaviorViewModelUnset:}} (advanced) - is a hook sent after a previous non-nil value of the selected behavior view model is unset. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a cleanup of the previous value or exlicitly notify the previous value that it is no longer in use.
 - {{gtMethod:TGtPharoWithSelectedBehaviorViewModel>>#onNewSelectedBehaviorViewModelSet:}} (advanced) - is a hook sent after a new value of the selected behavior view model is set. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a set up of the new value or exlicitly notify the new value that it is now in use.
## Generation
{{gtClass:TGtPharoWithSelectedBehaviorViewModel}} was automatically generated with the following code:
```
GtWithPropertyTraitGenerator new
	propertyName: 'selectedBehaviorViewModel';
	propertySetter: 'selectBehaviorViewModel';
	propertyUnsetter: 'deselectBehaviorViewModel';
	propertyType: 'GtPharoBehaviorNavigationViewModel';
	propertyComparator: #=;
	projectPrefix: 'GtPharo';
	packageName: 'GToolkit-Pharo-Coder-UI';
	tagName: 'Navigation - Support';
	generate
]```

"
Trait {
	#name : #TGtPharoWithSelectedBehaviorViewModel,
	#instVars : [
		'selectedBehaviorViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> deselectBehaviorViewModel [
	<propertyUnsetter: #selectedBehaviorViewModel>
	| aPreviousSelectedBehaviorViewModel |

	selectedBehaviorViewModel
		ifNil: [ ^ self ].

	aPreviousSelectedBehaviorViewModel := selectedBehaviorViewModel.
	selectedBehaviorViewModel := nil.
	self onPreviousSelectedBehaviorViewModelUnset: aPreviousSelectedBehaviorViewModel.
	self notifySelectedBehaviorViewModelChanged
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> hasSelectedBehaviorViewModel [
	<return: #Boolean>
	<propertyTester: #selectedBehaviorViewModel>

	^ selectedBehaviorViewModel notNil
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> notifySelectedBehaviorViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedBehaviorViewModel>
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> onNewSelectedBehaviorViewModelSet: aNewSelectedBehaviorViewModel [
	"Is sent after a new value of the selectedBehaviorViewModel is assigned"
	<propertySetHook: #selectedBehaviorViewModel>
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> onPreviousSelectedBehaviorViewModelUnset: aPreviousSelectedBehaviorViewModel [
	"Is sent after a previous value of the selectedBehaviorViewModel is de-assigned"
	<propertyUnsetHook: #selectedBehaviorViewModel>
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> selectBehaviorViewModel: aNewSelectedBehaviorViewModel [
	<propertySetter: #selectedBehaviorViewModel>

	(self selectedBehaviorViewModel = aNewSelectedBehaviorViewModel)
		ifTrue: [ ^ self ].
	
	self hasSelectedBehaviorViewModel
		ifTrue: [
			| aPreviousSelectedBehaviorViewModel |
			aPreviousSelectedBehaviorViewModel := selectedBehaviorViewModel.
			selectedBehaviorViewModel := nil.
			self onPreviousSelectedBehaviorViewModelUnset: aPreviousSelectedBehaviorViewModel ].
	selectedBehaviorViewModel := aNewSelectedBehaviorViewModel.
	self onNewSelectedBehaviorViewModelSet: aNewSelectedBehaviorViewModel.
	self notifySelectedBehaviorViewModelChanged
]

{ #category : #'api - selected behavior view model' }
TGtPharoWithSelectedBehaviorViewModel >> selectedBehaviorViewModel [
	<return: #GtPharoBehaviorNavigationViewModel>
	<propertyGetter: #selectedBehaviorViewModel>

	^ selectedBehaviorViewModel
]
