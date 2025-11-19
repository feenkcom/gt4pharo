Extension { #name : #GtPharoClassGroup }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoClassGroup >> gtBrowseClassesReferencesFor: anAction [
	<gtAction>
	^ anAction button
		priority: 2;
		target: GtCoderClassesTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Browse references';
		menuItemPreview: ('{1} classes' format: {self size});
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | 
			| aFilter |
			aFilter := self allButFirst
					inject: self first gtReferences
					into: [ :aSumFilter :aClass | aSumFilter | aClass gtReferences ].

			aButton phlow spawnObject: aFilter ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoClassGroup >> gtCoderRemoveClassesFor: anAction [
	<gtAction>
	^ anAction dropdown
		priority: 5;
		target: GtCoderClassesTarget;
		icon: BrGlamorousVectorIcons empty;
		label: 'Remove classes';
		menuItemPreview: ('{1} classes' format: {self size});
		menuItemGroup: BrMenuItemGroupConfiguration removal;
		content: [ :anActionElement :aTargetElement :anExplicitMenu | 
			GtCoderRemoveClassesPreviewStencil new
				classesToRemove: self;
				menuModel: anExplicitMenu;
				asElement ]
]
