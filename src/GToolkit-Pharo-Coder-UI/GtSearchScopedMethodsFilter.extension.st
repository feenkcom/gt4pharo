Extension { #name : #GtSearchScopedMethodsFilter }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchScopedMethodsFilter class >> filterDescriptor2For: aMethodsCoder [
	aMethodsCoder
		requesterContextDo: [ :aContext | 
			^ GtFilterShortListModel new
				creator: [ :anItem | anItem 
					ifSome: [ :aScope | self new scope: aScope ] 
					ifNone: [ self new ] ];
				named: 'Scope';
				order: 11;
				beDefault;
				displayAllItems;
				items: aContext scopedMethodsItems;
				selectFirstItem ].

	^ nil
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtSearchScopedMethodsFilter >> filterDescriptor2For: aMethodsCoder [
	^ (super filterDescriptor2For: aMethodsCoder)
		ifNotNil: [ :aFilterModel | aFilterModel selectedItem: scope ]
]
