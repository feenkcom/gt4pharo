"
# With selected tag view model 
Is used to add support for `selectedTagViewModel` to a user class.
## Implemented api:
The trait implements the following methods:
 - {{gtMethod:TGtPharoWithSelectedTagViewModel>>#selectedTagViewModel}} to get the value of the selected tag view model
 - {{gtMethod:TGtPharoWithSelectedTagViewModel>>#selectTagViewModel:}} to set a new value of the selected tag view model
 - {{gtMethod:TGtPharoWithSelectedTagViewModel>>#deselectTagViewModel}} to unset the value of the selected tag view model (set it to nil)
 - {{gtMethod:TGtPharoWithSelectedTagViewModel>>#hasSelectedTagViewModel}} to check if the selected tag view model has an assigned value (the default value is nil)
 - {{gtMethod:TGtPharoWithSelectedTagViewModel>>#notifySelectedTagViewModelChanged}} to announce changes to the value of the selected tag view model. By default does nothing and users are expected to provide a domain specific implementation with a domain specific event
 - {{gtMethod:TGtPharoWithSelectedTagViewModel>>#onPreviousSelectedTagViewModelUnset:}} (advanced) - is a hook sent after a previous non-nil value of the selected tag view model is unset. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a cleanup of the previous value or exlicitly notify the previous value that it is no longer in use.
 - {{gtMethod:TGtPharoWithSelectedTagViewModel>>#onNewSelectedTagViewModelSet:}} (advanced) - is a hook sent after a new value of the selected tag view model is set. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a set up of the new value or exlicitly notify the new value that it is now in use.
## Generation
{{gtClass:TGtPharoWithSelectedTagViewModel}} was automatically generated with the following code:
```
GtWithPropertyTraitGenerator new
	propertyName: 'selectedTagViewModel';
	propertySetter: 'selectTagViewModel';
	propertyUnsetter: 'deselectTagViewModel';
	propertyType: 'GtPharoTagNavigationViewModel';
	propertyComparator: #=;
	projectPrefix: 'GtPharo';
	packageName: 'GToolkit-Pharo-Coder-UI';
	tagName: 'Navigation - Support';
	generate
]```

"
Trait {
	#name : #TGtPharoWithSelectedTagViewModel,
	#instVars : [
		'selectedTagViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Support'
}

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> deselectTagViewModel [
	<propertyUnsetter: #selectedTagViewModel>
	| aPreviousSelectedTagViewModel |

	selectedTagViewModel
		ifNil: [ ^ self ].

	aPreviousSelectedTagViewModel := selectedTagViewModel.
	selectedTagViewModel := nil.
	self onPreviousSelectedTagViewModelUnset: aPreviousSelectedTagViewModel.
	self notifySelectedTagViewModelChanged
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> hasSelectedTagViewModel [
	<return: #Boolean>
	<propertyTester: #selectedTagViewModel>

	^ selectedTagViewModel notNil
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> notifySelectedTagViewModelChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #selectedTagViewModel>
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> onNewSelectedTagViewModelSet: aNewSelectedTagViewModel [
	"Is sent after a new value of the selectedTagViewModel is assigned"
	<propertySetHook: #selectedTagViewModel>
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> onPreviousSelectedTagViewModelUnset: aPreviousSelectedTagViewModel [
	"Is sent after a previous value of the selectedTagViewModel is de-assigned"
	<propertyUnsetHook: #selectedTagViewModel>
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> selectTagViewModel: aNewSelectedTagViewModel [
	<propertySetter: #selectedTagViewModel>

	(self selectedTagViewModel = aNewSelectedTagViewModel)
		ifTrue: [ ^ self ].
	
	self hasSelectedTagViewModel
		ifTrue: [
			| aPreviousSelectedTagViewModel |
			aPreviousSelectedTagViewModel := selectedTagViewModel.
			selectedTagViewModel := nil.
			self onPreviousSelectedTagViewModelUnset: aPreviousSelectedTagViewModel ].
	selectedTagViewModel := aNewSelectedTagViewModel.
	self onNewSelectedTagViewModelSet: aNewSelectedTagViewModel.
	self notifySelectedTagViewModelChanged
]

{ #category : #'api - selected tag view model' }
TGtPharoWithSelectedTagViewModel >> selectedTagViewModel [
	<return: #GtPharoTagNavigationViewModel>
	<propertyGetter: #selectedTagViewModel>

	^ selectedTagViewModel
]
