Extension { #name : #Class }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Class >> gtCoderSidebarIndexConvertToSiblingClassFrom: aGtCoderClassesTreeElement [
	<gtCoderSidebarIndexOneSubjectContextMenuItem: 6>
	self subclasses notEmpty ifFalse: [ ^ nil ].

	^ BrMenuSubmenuItem new
		id: #'coder--context-menu-convert-to-sibling';
		icon: BrGlamorousVectorIcons empty
			label: 'Convert to sibling'
			preview: self name;
		submenu: (aGtCoderClassesTreeElement
				convertToSiblingSubmenuFor: self
				siblings: self subclasses
				title: 'Convert to sibling');
		bePinSubmenuAction;
		hideOnClick: true
]

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Class >> gtCoderSidebarIndexCopyClassOrTraitFrom: aGtCoderClassesTreeElement [
	<gtCoderSidebarIndexOneSubjectContextMenuItem: 8>
	self superclass ifNil: [ ^ nil ].
	
	^ BrMenuSubmenuItem new
		icon: BrGlamorousVectorIcons changes
			label: (self isTrait ifTrue: [ 'Copy trait' ] ifFalse: [ 'Copy class' ])
			preview: self name;
		submenu: (aGtCoderClassesTreeElement copyClassOrTraitSubmenuFor: self)
]
