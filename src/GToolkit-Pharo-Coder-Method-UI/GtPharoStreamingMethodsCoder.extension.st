Extension { #name : #GtPharoStreamingMethodsCoder }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoStreamingMethodsCoder >> categoryFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Categories';
		priority: 10;
		stencil: [
			|  categories anElement |
			categories := self behavior instanceSide protocolNames asSet.
			categories addAll: self behavior classSide protocolNames.
			categories := categories asSortedCollection.

			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: categories 
				title: [ :aCategory | aCategory ]
				action: [ :aCategory | 
					self 
						addOrReplaceFilter: (GtSearchMethodCategoryFilter 
							forCategory: aCategory) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoStreamingMethodsCoder >> classSlotFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Class Slots';
		priority: 40;
		stencil: [ | anElement |
			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: (self behavior classSide allInstVarNames sorted: [ :a :b | a < b ])
					title: [ :aVariable | aVariable ]
					action: [ :aVariable | 
						self addOrReplaceFilter: (GtSearchClassSlotReferenceFilter
										forClass: self behavior classSide
										andVariable: aVariable) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoStreamingMethodsCoder >> classVariableFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Class Variables';
		priority: 30;
		stencil: [
			| anElement |
			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: (self behavior instanceSide allClassVarNames sorted: [ :a :b | a < b ])
				title: [ :aVariable | aVariable ]
				action: [ :aVariable |
					self addOrReplaceFilter: (GtSearchClassVariableReferenceFilter
							forClass: self behavior instanceSide
							andVariable: aVariable) ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoStreamingMethodsCoder >> codeGeneratorsDropDown: anElement for: aMethodsCoderViewModel [
	^ BrHorizontalPane new
		exact: 300@300;
		addChild:
			(GtPhlowCompositeView new
				views: (self codeGeneratorsFor: aMethodsCoderViewModel);
				asElementDo: [ :aTabGroup | aTabGroup matchParent ])
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoStreamingMethodsCoder >> codeGeneratorsFor: aMethodsCoderViewModel [
	^ GtPhlowViewsCollector new
		fromObject: self;
		pragmaName: #gtCodeGenerator;
		context: aMethodsCoderViewModel;
		collect
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoStreamingMethodsCoder >> filterDescriptors [
	<return: #TAsyncStream>
	| descriptors |
	descriptors := SortedCollection sortBlock: [ :a :b | a order < b order ].

	BlFrameTelemetry
		time: [ 'Create filter descriptors' ]
		during: [ GtSearchMethodsFilter
				withAllSubclassesDo: [ :eachClass | eachClass filterDescriptorsFor: self into: descriptors ] ].

	^ descriptors
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoStreamingMethodsCoder >> filterDropDown: anElement [
	^ BlElement new
		size: 430 @ 430;
		addChild:
			(GtPhlowCompositeView new
				views: self filterTypes;
				asElementDo: [ :aTabGroup | aTabGroup matchParent ])
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoStreamingMethodsCoder >> filterTypes [
	^ GtPhlowViewsCollector new
		fromObject: self;
		pragmaName: #gtFilterTypes;
		collect
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoStreamingMethodsCoder >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live' translated;
		priority: 10;
		stencil: [
			| aStream |			

			aStream := self asAsyncStream map: [ :eachCoder |
				eachCoder asCoderViewModel expanded: false ].

			BrSimpleList new
				itemStencil: [ GtExpandableMethodCoderElement new ];
				itemDataBinder: [ :aCoderElement :aCoderViewModel | aCoderElement coderViewModel: aCoderViewModel ];
				stream: aStream ]
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoStreamingMethodsCoder >> instanceSlotFilter: aView [
	<gtFilterTypes>
	^ aView explicit
		title: 'Slots';
		priority: 20;
		stencil: [
			| anElement |
			anElement := GtCoderFilterList new.
			anElement
				matchParent;
				items: (self behavior instanceSide allInstVarNames sorted: [ :a :b | a < b ])
				title: [ :aVariable | aVariable ]
				action: [ :aVariable | self 
					addOrReplaceFilter: (GtSearchInstanceSlotReferenceFilter
						forClass: self behavior instanceSide
						andVariable: aVariable) ] ]
]
