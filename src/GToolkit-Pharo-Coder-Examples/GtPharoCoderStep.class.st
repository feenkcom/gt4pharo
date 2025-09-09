"
I provide {{gtClass:BlScripter}} steps for {{gtClass:GtCoderElement}}. 
"
Class {
	#name : #GtPharoCoderStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-Pharo-Coder-Examples-Scripter'
}

{ #category : #'steps - interactions' }
GtPharoCoderStep >> openSidebarIndexContextMenuOnClass: aClass [
	^ self menuStep
		label: ('Open class context menu on {1}' format: {aClass});
		openContextMenu;
		// GtCoderClassesTreeItemElement;
		@ [ :each | each theClass = aClass ]
]

{ #category : #'steps - interactions' }
GtPharoCoderStep >> toggleHierarchies [
	^ self click
		label: 'Show hierarchies';
		// GtCoderClassHierarchyButtonId
]
