Extension { #name : #GtMagritteElementBuilder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtMagritteElementBuilder >> newPackageNameWidget: aDescription [
	| aMemento packageEditor aCompletionStrategy aptitude |
	aMemento := self memento.
	packageEditor := BrEditor new.
	aptitude := aDescription editorAptitude
			ifNil: [ BrGlamorousRegularEditorAptitude new glamorousRegularFontAndSize ]
			ifNotNil: #value.

	packageEditor
		inputFilter: BrPackageNameInputFilter new;
		aptitude: aptitude;
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle border: BlBorder empty ];
				hovered: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors disabledButtonBorderColor width: 1) ];
				focused: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors focusedEditorBorderColor width: 1) ]);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		vFitContent;
		hFitContentLimited;
		margin: (BlInsets top: 2 bottom: 4);
		constraintsDo: [ :c | 
			c grid vertical alignCenter.
			c minWidth: 20 ];
		when: BlFocusInEvent do: [ :anEvent | packageEditor selecter all select ];
		when: BlFocusOutEvent
			do: [ :anEvent | packageEditor deselecter all deselect ];
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theEditor :aSink | theEditor text: aSink value currentValue packageRope ].
			(aMemento readObservableValueUsing: aDescription) observe: anElementSink ].

	aCompletionStrategy := GtStringsCompletionStrategy new
			completions: (GtPrefixTree withAll: RPackageOrganizer default packageNames).

	(GtCompletionController on: packageEditor strategy: aCompletionStrategy)
		install.

	packageEditor editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | 
			| aValue aNewValue |
			aValue := aMemento readUsing: aDescription.
			aNewValue := aValue copyWithNewPackageName: anEvent text asString.
			GtMagritteBuilderUtility
				write: aNewValue 
				using: aDescription 
				memento: aMemento 
				element: packageEditor ].
	^ packageEditor
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtMagritteElementBuilder >> newTagNameWidget: aDescription [
	| aMemento tagEditor aCompletionController aptitude |
	aMemento := self memento.
	tagEditor := BrEditor new.
	aptitude := aDescription editorAptitude
			ifNil: [ BrGlamorousRegularEditorAptitude new glamorousRegularFontAndSize ]
			ifNotNil: #value.

	tagEditor
		inputFilter: BrPackageTagNameInputFilter new;
		aptitude: aptitude;
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle border: BlBorder empty ];
				hovered: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors disabledButtonBorderColor width: 1) ];
				focused: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors focusedEditorBorderColor width: 1) ]);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		vFitContent;
		hFitContentLimited;
		margin: (BlInsets top: 2 bottom: 4);
		constraintsDo: [ :c | 
			c grid vertical alignCenter.
			c minWidth: 20 ];
		when: BlFocusInEvent do: [ :anEvent | tagEditor selecter all select ];
		when: BlFocusOutEvent do: [ :anEvent | tagEditor deselecter all deselect ];
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theEditor :aSink | 
					| aPackage aCompletionStrategy |
					aPackage := aSink value currentValue packageName asPackageIfAbsent: [ nil ].

					aPackage
						ifNotNil: [ aCompletionController ifNotNil: [ aCompletionController uninstall ].
							aCompletionStrategy := GtStringsCompletionStrategy new
									completions: (GtPrefixTree withAll: (aPackage tags collect: #name)).

							aCompletionController := (GtCompletionController
									on: tagEditor
									strategy: aCompletionStrategy) install ].

					theEditor text: aSink value currentValue tagRope ].
			(aMemento readObservableValueUsing: aDescription) observe: anElementSink ].



	tagEditor editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | 
			| aValue aNewValue |
			aValue := aMemento readUsing: aDescription.
			aNewValue := aValue copyWithNewTagName: anEvent text asString.
			
			GtMagritteBuilderUtility 
				write: aNewValue 
				using: aDescription 
				memento: aMemento 
				element: tagEditor. ].
	^ tagEditor
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtMagritteElementBuilder >> visitGtPackageAndTagDescription: aDescription [
	| packageEditor tagEditor aContainer aLabel aValidationElement aMemento |
	aMemento := self memento.
	aContainer := BrHorizontalPane new fitContent.
	packageEditor := self newPackageNameWidget: aDescription.
	tagEditor := self newTagNameWidget: aDescription.

	self addShortcutsTo: packageEditor using: aDescription.
	self addShortcutsTo: tagEditor using: aDescription.
	
	aContainer
		addChild: packageEditor as: #package;
		addChild: ((GtMagritteBuilderUtility
				newFieldLabelWithSpace: self defaultSpacing
				using: aDescription)
				text: 'Tag:';
				constraintsDo: [ :c | c linear vertical alignCenter ]);
		addChild: tagEditor as: #tag.

	aDescription isWithChangeIndicator
		ifTrue: [ aValidationElement := GtMagritteBuilderUtility
					newValidationContainerWith: aContainer
					memento: aMemento
					using: aDescription ]
		ifFalse: [ aValidationElement := aContainer ].

	aLabel := self addFieldElement: aValidationElement using: aDescription.

	aLabel padding: aLabel padding + (BlInsets top: self defaultSpacing)
]
