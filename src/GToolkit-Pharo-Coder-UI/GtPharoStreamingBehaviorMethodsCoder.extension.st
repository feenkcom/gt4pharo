Extension { #name : #GtPharoStreamingBehaviorMethodsCoder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoStreamingBehaviorMethodsCoder >> asCoderUIModel [
	^ GtPharoStreamingMethodsCoderViewModel new codersModel: self
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoStreamingBehaviorMethodsCoder >> categoryFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Categories';
		priority: 10;
		stencil: [
			|  categories anElement |
			categories := self behavior instanceSide organization categories asSet.
			categories addAll: self behavior classSide organization categories.
			categories := categories asSortedCollection.

			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: categories 
				title: [ :aCategory | aCategory ]
				action: [ :aCategory | self additionalFilters: { (GtSearchMethodCategoryFilter forCategory: aCategory) } ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoStreamingBehaviorMethodsCoder >> classSlotFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Class Slots';
		priority: 30;
		stencil: [
			| anElement |
			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: (self behavior instanceSide allClassVarNames sorted: [ :a :b | a < b ])
				title: [ :aVariable | aVariable ]
				action: [ :aVariable |
					self additionalFilters: {
						(GtSearchClassSlotReferenceFilter
							forClass: self behavior instanceSide
							andVariable: aVariable) } ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoStreamingBehaviorMethodsCoder >> filterDescriptors [
	| descriptors |
	descriptors := SortedCollection sortBlock: [ :a :b | a order < b order ].
	GtSearchMethodsFilter
		withAllSubclassesDo: [ :eachClass | 
			eachClass 
				filterDescriptorsFor: self 
				into: descriptors ].
	^ descriptors
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoStreamingBehaviorMethodsCoder >> filterDropDown: anElement [
	^ BlElement new
		size: 430 @ 430;
		addChild:
			(GtPhlowCompositeView new
				views: self filterTypes;
				asElementDo: [ :aTabGroup | aTabGroup matchParent ])
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoStreamingBehaviorMethodsCoder >> filterTypes [
	^ GtPhlowViewsCollector new
		fromObject: self;
		pragmaName: #gtFilterTypes;
		collect
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoStreamingBehaviorMethodsCoder >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live' translated;
		priority: 10;
		stencil: [
			| aStream |			

			aStream := self asAsyncStream map: [ :eachCoder |
				eachCoder asCoderViewModel expanded: false ].

			BrSimpleList new
				itemStencil: [ GtExpandableMethodCoderForBehaviorElement new ];
				itemDataBinder: [ :aCoderElement :aCoderViewModel | aCoderElement coderUIModel: aCoderViewModel ];
				stream: aStream ]
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtPharoStreamingBehaviorMethodsCoder >> instanceSlotFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Slots';
		priority: 20;
		stencil: [
			| anElement |
			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: self behavior instanceSide allInstVarNames
				title: [ :aVariable | aVariable ]
				action: [ :aVariable | self 
					additionalFilters: { GtSearchInstanceSlotReferenceFilter
						forClass: self behavior instanceSide
						andVariable: aVariable } ] ]
]
