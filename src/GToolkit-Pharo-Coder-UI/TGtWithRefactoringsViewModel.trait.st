Trait {
	#name : #TGtWithRefactoringsViewModel,
	#instVars : [
		'refactoringsViewModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New - Rest'
}

{ #category : #'accessing - refactorings view model' }
TGtWithRefactoringsViewModel >> hasRefactoringsViewModel [
	<return: #Boolean>
	^ refactoringsViewModel isNotNil
]

{ #category : #'accessing - refactorings view model' }
TGtWithRefactoringsViewModel >> onRefactoringsViewModelChanged [
]

{ #category : #'accessing - refactorings view model' }
TGtWithRefactoringsViewModel >> refactoringsViewModel [
	<return: #GtRefactoringsViewModel>
	^ refactoringsViewModel
]

{ #category : #'accessing - refactorings view model' }
TGtWithRefactoringsViewModel >> refactoringsViewModel: aViewModel [
	refactoringsViewModel = aViewModel ifTrue: [ ^ self ].

	refactoringsViewModel ifNotNil: [ self unsubscribeFromRefactoringsViewModel ].
	refactoringsViewModel := aViewModel.
	self onRefactoringsViewModelChanged.
	self subscribeToRefactoringsViewModel
]

{ #category : #'accessing - refactorings view model' }
TGtWithRefactoringsViewModel >> subscribeToRefactoringsViewModel [
]

{ #category : #'accessing - refactorings view model' }
TGtWithRefactoringsViewModel >> unsubscribeFromRefactoringsViewModel [
]
