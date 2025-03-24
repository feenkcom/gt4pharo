Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
ProtoObject >> gtAdviceActionFor: anAction [
	<gtAction>
	| actions actionStream |
	actions := GtAdvice adviceFor: self.
	actions isEmpty ifTrue: [ ^ anAction noAction ].
	actionStream := (actions asAsyncStream select: [ :each | each hasAdvice ])
			cached.
	^ anAction explicit
		priority: 0;
		stencil: [ | button dropDownAptitude promise |
			button := GtFixItButton new.
			button visibility: BlVisibility hidden.
			button label: 'Advice'.
			dropDownAptitude := BrGlamorousWithExplicitDropdownAptitude
					handle: [ | dropdownButton |
						dropdownButton := BrButton new.
						dropdownButton
							aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2
									- BrGlamorousButtonExteriorAptitude.
						dropdownButton icon: BrGlamorousVectorIcons repair.
						dropdownButton ]
					content: [ | element |
						element := BrSimpleList new.
						element padding: (BlInsets all: 3).
						element vFitContentLimited.
						element hExact: 300.
						element
							itemsProvider: (BrStreamItemsProvider new
									preloadAmount: 1;
									stream: actionStream asyncSimilarCopy);
							stencil: [ :eachImage | eachImage buildElementFor: button ].
						element ].
			button aptitude: BrGlamorousButtonWithIconAptitude + dropDownAptitude.
			button icon: BrGlamorousVectorIcons repair.
			promise := (actionStream asyncSimilarCopy hasNext
					then: [ :bool | 
						bool
							ifTrue: [ button
									enqueueTask: (BlTaskAction new action: [ button visibility: BlVisibility visible ]) ] ])
					await: GtSingleCoderViewModel methodAddOnsExecutionConfiguration.
			button enqueueTask: (BlPromiseTask new promise: promise).
			button ]
]
