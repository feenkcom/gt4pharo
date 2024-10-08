Extension { #name : #GtSearchInstanceMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInstanceMethodsFilter >> filterDescriptor2For: aMethodsCoder [
	^ (GtSearchClassMethodsFilter filterDescriptor2For: aMethodsCoder)
		selectedItem: GtFilterModelInstanceSideItem default
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInstanceMethodsFilter class >> globalFilterDescriptor [
	^ GtFilterDescriptor new
		creator: [ :value | self new ];
		named: 'Instance methods';
		order: 16;
		valueNotRequired;
		beNotDefault;
		yourself
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchInstanceMethodsFilter class >> globalFilterDescriptor2 [
	"See GtSearchClassMethodsFilter class>>#globalFilterDescriptor"
	^ nil
]
