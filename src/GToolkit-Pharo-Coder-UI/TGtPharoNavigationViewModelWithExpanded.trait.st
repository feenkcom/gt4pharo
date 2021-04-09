Trait {
	#name : #TGtPharoNavigationViewModelWithExpanded,
	#instVars : [
		'expanded'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - View Models'
}

{ #category : #'api - expanded' }
TGtPharoNavigationViewModelWithExpanded >> expanded [
	<return: #Boolean>

	^ expanded
]

{ #category : #'api - expanded' }
TGtPharoNavigationViewModelWithExpanded >> expanded: aNewExpanded [
	(self expanded = aNewExpanded)
		ifTrue: [ ^ self ].

	expanded := aNewExpanded.
	self notifyExpandedChanged.
]

{ #category : #'api - expanded' }
TGtPharoNavigationViewModelWithExpanded >> hasExpanded [
	<return: #Boolean>

	^ expanded notNil
]

{ #category : #'api - expanded' }
TGtPharoNavigationViewModelWithExpanded >> notifyExpandedChanged [
	self explicitRequirement
]
