Extension { #name : #GtCoderNavigationTabsStencil }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderNavigationTabsStencil >> gtAddBaselineTab: look [
	<gtCreateComponentTab: 40>
	^ BrTab new
		aptitude: BrGlamorousTabAptitude new;
		label: 'Baseline';
		stencil: [ | element |
			element := GtPharoCreateBaselineElement new.
			element
				behaviorBlock: [ :cls | 
					look fireEvent: BrDropdownHideWish new.
					navigationModel selectClass: cls ].
			element forBaselineDefinition.
			navigationModel
				selectedPackageDo: [ :package | element forPackageReference: package ].
			element ]
]
