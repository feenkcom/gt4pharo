Extension { #name : #GtFilterStep }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtFilterStep >> assertMethodProtocolFilterModel [
	^ self assertFilterModelNamed: GtSearchMethodCategoryFilter filterName
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtFilterStep >> assertMethodsUpToFilterModel [
	^ self assertFilterModelNamed: GtSearchInheritedMethodsFilter filterName
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtFilterStep >> clickOnDropdownMethodProtocolItem [
	^ self
		clickOnDropdownFilterItemLabeled: GtSearchMethodCategoryFilter filterName
]
