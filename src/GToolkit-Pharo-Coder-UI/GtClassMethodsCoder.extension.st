Extension { #name : #GtClassMethodsCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> categoryFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Categories';
		priority: 10;
		stencil: [
			|  categories anElement |
			categories := class protocolNames asSet.
			categories addAll: class class protocolNames.
			categories := categories asSortedCollection.
			
			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: categories 
				title: [ :aCategory | aCategory ]
				action: [ :aCategory | self 
					setFilters: { (GtSearchMethodCategoryFilter
						forCategory: aCategory) }
					source: anElement ] ].
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> classSlotFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Class Slots';
		priority: 40;
		stencil: [ | anElement |
			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: (class class allInstVarNames sorted: [ :a :b | a < b ])
					title: [ :aVariable | aVariable ]
					action: [ :aVariable | 
						self
							setFilters: {GtSearchClassSlotReferenceFilter
										forClass: self classOrMetaClass class
										andVariable: aVariable}
							source: anElement ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> classVariableFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Class Variables';
		priority: 30;
		stencil: [
			| anElement |
			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: (class allClassVarNames sorted: [ :a :b | a < b ])
				title: [ :aVariable | aVariable ]
				action: [ :aVariable | self 
					setFilters: { (GtSearchClassVariableReferenceFilter
						forClass: self classOrMetaClass
						andVariable: aVariable) }
					source: anElement ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> codeGeneratorsDropDown: anElement for: aMethodsCoderViewModel [
	^ BrHorizontalPane new
		exact: 300@300;
		addChild:
			(GtPhlowCompositeView new
				views: (self codeGeneratorsFor: aMethodsCoderViewModel);
				asElementDo: [ :aTabGroup | aTabGroup matchParent ])
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> filterDropDown: anElement [
	^ BlElement new
		size: 430 @ 430;
		addChild:
			(GtPhlowCompositeView new
				views: self filterTypes;
				asElementDo: [ :aTabGroup | aTabGroup matchParent ])
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> instanceSlotFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Slots';
		priority: 20;
		stencil: [
			| anElement |
			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: (class allInstVarNames sorted: [ :a :b | a < b ])
				title: [ :aVariable | aVariable ]
				action: [ :aVariable | self 
					setFilters: { GtSearchInstanceSlotReferenceFilter
						forClass: self classOrMetaClass
						andVariable: aVariable }
					source: anElement ] ]
]
