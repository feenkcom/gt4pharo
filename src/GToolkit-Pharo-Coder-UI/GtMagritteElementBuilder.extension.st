Extension { #name : #GtMagritteElementBuilder }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtMagritteElementBuilder >> newPackageNameWidget: aDescription [
	| aMemento packageEditor aCompletionStrategy aptitude |
	aMemento := self memento.
	packageEditor := BrEditor new.
	aptitude := BrGlamorousRegularEditorAptitude new glamorousRegularFontAndSize.
	aDescription textStyler ifNotNil: [ :aBlock | aBlock value: aptitude ].
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
		margin: (BlInsets bottom: 4);
		constraintsDo: [ :c | 
			c grid vertical alignCenter.
			c minWidth: 20 ];
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
			aMemento write: aNewValue using: aDescription ].
	^ packageEditor
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtMagritteElementBuilder >> newTagNameWidget: aDescription [
	| aMemento tagEditor aCompletionController aptitude |
	aMemento := self memento.
	tagEditor := BrEditor new.
	aptitude := BrGlamorousRegularEditorAptitude new glamorousRegularFontAndSize.
	aDescription textStyler ifNotNil: [ :aBlock | aBlock value: aptitude ].
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
		margin: (BlInsets bottom: 4);
		constraintsDo: [ :c | 
			c grid vertical alignCenter.
			c minWidth: 20 ];
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theEditor :aSink | 
					| aPackage aCompletionStrategy |
					aPackage := aSink value currentValue packageName asPackageIfAbsent: [ nil ].

					aPackage
						ifNotNil: [ aCompletionController ifNotNil: [ aCompletionController uninstall ].
							aCompletionStrategy := GtStringsCompletionStrategy new
									completions: (GtPrefixTree withAll: (aPackage classTags collect: #name)).

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
			aMemento write: aNewValue using: aDescription ].
	^ tagEditor
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtMagritteElementBuilder >> visitGtPackageAndTagDescription: aDescription [
	| packageEditor tagEditor aContainer aLabel aValidationElement aMemento |
	aMemento := self memento.
	aContainer := BrHorizontalPane new fitContent.
	packageEditor := self newPackageNameWidget: aDescription.
	tagEditor := self newTagNameWidget: aDescription.

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
