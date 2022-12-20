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

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderNavigationTabsStencil >> gtAddClassTab: look [
	<gtCreateComponentTab: 10>
	^ BrTab new
		aptitude: BrGlamorousTabAptitude new;
		label: 'Class';
		stencil: [ | element |
			element := GtPharoCreateBehaviorElement new.
			element
				behaviorBlock: [ :cls | 
					look fireEvent: BrDropdownHideWish new.
					navigationModel selectClass: cls ].
			element forClassDefinition.
			navigationModel selectedPackageDo: [ :package | element forPackage: package ].
			navigationModel selectedTagDo: [ :tag | element forPackageTag: tag ].
			element ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderNavigationTabsStencil >> gtAddPackageTab: look [
	<gtCreateComponentTab: 30>
	^ BrTab new
		aptitude: BrGlamorousTabAptitude new;
		label: 'Package';
		stencil: [ | element |
			element := GtPharoCreatePackageElement new.
			element
				packageBlock: [ :pkg :tag | 
					look fireEvent: BrDropdownHideWish new.
					tag isNil
						ifTrue: [ navigationModel selectPackage: pkg ]
						ifFalse: [ navigationModel selectPackageTag: tag ] ].
			navigationModel selectedPackageDo: [ :package | element forPackage: package ].
			element ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderNavigationTabsStencil >> gtAddTraitTab: look [
	<gtCreateComponentTab: 20>
	^ BrTab new
		aptitude: BrGlamorousTabAptitude new;
		label: 'Trait';
		stencil: [ | element |
			element := GtPharoCreateBehaviorElement new.
			element
				behaviorBlock: [ :cls | 
					look fireEvent: BrDropdownHideWish new.
					navigationModel selectClass: cls ].
			element forTraitDefinition.
			navigationModel selectedPackageDo: [ :package | element forPackage: package ].
			navigationModel selectedTagDo: [ :tag | element forPackageTag: tag ].
			element ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderNavigationTabsStencil >> gtBaselineComponent [
	<gtCreateComponent>
	^ GtBaselineCreationForm
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderNavigationTabsStencil >> gtClassComponent [
	<gtCreateComponent>
	^ GtClassCreationForm
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderNavigationTabsStencil >> gtPackageComponent [
	<gtCreateComponent>
	^ GtPackageCreationForm
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderNavigationTabsStencil >> gtParserComponent [
	<gtCreateComponent>
	^ GtParserCreationForm
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderNavigationTabsStencil >> gtTraitComponent [
	<gtCreateComponent>
	^ GtTraitCreationForm
]
