Extension { #name : #GtSearchDefinedMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchDefinedMethodsFilter >> filterDescriptor2For: aMethodsCoder [
	^ (GtSearchSubclassResponsibilityMethodsFilter filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel selectedItem: GtFilterModelDefinedMethodItem default ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchDefinedMethodsFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self new ];
		named: 'Non abstract methods';
		order: 18;
		valueNotRequired;
		beNotDefault;
		yourself
]
