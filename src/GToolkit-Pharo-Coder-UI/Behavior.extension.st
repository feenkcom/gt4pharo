Extension { #name : #Behavior }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Behavior >> gtAddBaselineTab: look [
	<gtCreateComponentTab: 40>
	^ BrTab new
		aptitude: BrGlamorousTabAptitude new;
		label: 'Baseline';
		stencil: [ | element navigationModel |
			element := GtPharoCreateBaselineElement new.
			navigationModel := look phlow firstParentWithView navigationModel.
			element
				behaviorBlock: [ :cls | 
					look fireEvent: BrDropdownHideWish new.
					navigationModel selectClass: cls ].
			element forBaselineDefinition.
			navigationModel
				selectedPackageDo: [ :package | element forPackageReference: package ].
			element ]
]
