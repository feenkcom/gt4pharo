Extension { #name : #GtFilterStep }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtFilterStep >> assertMethodProtocolFilterModel [
	^ self assertFilterModelLabeled: GtSearchMethodCategoryFilter filterName
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtFilterStep >> assertMethodsUpToFilterModel [
	^ self assertFilterModelLabeled: GtSearchMethodCategoryFilter filterName
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtFilterStep >> clickOnDropdownMethodProtocolItem [
	^ self
		clickOnDropdownFilterItemLabeled: GtSearchMethodCategoryFilter filterName
]
