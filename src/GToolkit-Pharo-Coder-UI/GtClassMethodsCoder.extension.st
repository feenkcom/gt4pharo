Extension { #name : #GtClassMethodsCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtClassMethodsCoder >> categoryFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Categories';
		priority: 10;
		stencil: [
			|  categories anElement |
			categories := class organization categories asSet.
			categories addAll: class class organization categories.
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
				items: class allClassVarNames 
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
GtClassMethodsCoder >> examplesFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Examples';
		priority: 40;
		stencil: [
			| anElement |
			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: GtFilterExampleState default allStates
				title: [ :aState | aState labelWithAmountFor: self exampler ]
				action: [ :aState | self 
					setFilters: { (GtSearchExamplesFilter new
						resultState: aState)
						coder: self }
					source: anElement ] ].
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
GtClassMethodsCoder >> instanceVariableFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Instance Variables';
		priority: 20;
		stencil: [
			| anElement |
			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: class allInstVarNames
				title: [ :aVariable | aVariable ]
				action: [ :aVariable | self 
					setFilters: { GtSearchInstanceVariableReferenceFilter
						forClass: self classOrMetaClass
						andVariable: aVariable }
					source: anElement ] ]
]
