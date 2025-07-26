Extension { #name : #GtCoderClassesTreeElement }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderClassesTreeElement >> convertToSiblingSubmenuFor: aClass siblings: aCollection [
	| submenu |
	submenu := BrMenuExplicit new.
	submenu
		stencil: [ GtRefactoringsWithInputPreviewElement
				elementForRefactoring: [ :each | 
					GtChildrenToSiblingsRefactoring
						name: each
						class: aClass
						subclasses: aCollection ]
				labeled: 'Superclass: '
				initialValue: 'NewClass'
				from: self
				beforeApplyingDo: [ submenu hideAll ] ].
	^ submenu
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
GtCoderClassesTreeElement >> copyClassOrTraitSubmenuFor: aClass [
	| submenu |
	submenu := BrMenuExplicit new.
	submenu
		stencil: [ aClass isTrait
				ifTrue: [ ((GtCopyTraitForm for: aClass)
						onAccept: [ :newClass | 
							self
								inUIProcessDo: [ self phlow spawnTool: (GtClassCoderTool forClass: newClass) ] ])
						asElement padding: (BlInsets all: 5) ]
				ifFalse: [ ((GtCopyClassForm for: aClass)
						onAccept: [ :newClass | 
							self
								inUIProcessDo: [ self phlow spawnTool: (GtClassCoderTool forClass: newClass) ] ])
						asElement padding: (BlInsets all: 5) ] ].
	^ submenu
]
