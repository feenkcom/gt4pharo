Class {
	#name : #GtSmalltalkSourceCoder,
	#superclass : #GtSourceCoder,
	#traits : 'TGtPharoSourceCoderAstNodesDetection',
	#classTraits : 'TGtPharoSourceCoderAstNodesDetection classTrait',
	#classVars : [
		'DoubleClickClassifier',
		'NodeHighlight',
		'WordMovementClassifier'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #accessing }
GtSmalltalkSourceCoder class >> doubleClickClassifier [
	^ DoubleClickClassifier
]

{ #category : #accessing }
GtSmalltalkSourceCoder class >> doubleClickClassifier: anObject [
	DoubleClickClassifier := anObject
]

{ #category : #initialization }
GtSmalltalkSourceCoder class >> initialize [
	WordMovementClassifier := BrCamelCaseWordClassifier new.
	DoubleClickClassifier := BrSmalltalkWordClassifier new
]

{ #category : #accessing }
GtSmalltalkSourceCoder class >> wordMovementClassifier [
	^ WordMovementClassifier
]

{ #category : #accessing }
GtSmalltalkSourceCoder class >> wordMovementClassifier: anObject [
	WordMovementClassifier := anObject
]

{ #category : #'add-ons - header' }
GtSmalltalkSourceCoder >> addHierarchyImplementorsHeaderContextMenuAddOnsSelector: aSelector to: coderAddOns requester: aCoderViewModel [
	<gtCoderHeaderContextMenuAddOns>
	^ (coderAddOns
		addContextMenuItem: (self
				createLabel: 'Browse hierarchy implementors'
				description: aCoderViewModel coder selector)
		group: BrMenuItemGroupConfiguration navigation
		action: [ :coderViewModel :anEditorElement | 
			anEditorElement phlow
				spawnObject: coderViewModel coder selector gtImplementors
						& ((GtSearchInheritedMethodsFilter
								forClass: coderViewModel compiledMethod methodClass instanceSide)
								withSuperclasses;
								withSubclasses) ]
		id: #'context-menu--hierarchy-implementers'
		shortcutKey: nil) ifNotNil: [ :anAction | anAction priority: 11 ]
]

{ #category : #'add-ons - header' }
GtSmalltalkSourceCoder >> addHierarchyReferencesHeaderContextMenuAddOnsSelector: aSelector to: coderAddOns requester: aCoderViewModel [
	<gtCoderHeaderContextMenuAddOns>
	^ (coderAddOns
		addContextMenuItem: (self
				createLabel: 'Browse hierarchy references'
				description: aCoderViewModel coder selector)
		group: BrMenuItemGroupConfiguration navigation
		action: [ :coderViewModel :anEditorElement | 
			anEditorElement phlow
				spawnObject: coderViewModel coder selector gtReferences
						& ((GtSearchInheritedMethodsFilter
								forClass: coderViewModel compiledMethod methodClass instanceSide)
								withSuperclasses;
								withSubclasses) ]
		id: #'context-menu--hierarchy-references'
		shortcutKey: nil) ifNotNil: [ :anAction | anAction priority: 16 ]
]

{ #category : #'add-ons - header' }
GtSmalltalkSourceCoder >> addImplementorsHeaderContextMenuAddOnsSelector: aSelector to: coderAddOns requester: aCoderViewModel [
	<gtCoderHeaderContextMenuAddOns>
	^ (coderAddOns
		addContextMenuItem: (self
				createLabel: GtSourceCoderBrowseImplementorsShortcut new name
				description: aCoderViewModel coder selector)
		group: BrMenuItemGroupConfiguration navigation
		action: [ :coderViewModel :anEditorElement | anEditorElement phlow spawnObject: coderViewModel coder selector gtImplementors ]
		id: #'context-menu--implementers'
		shortcutKey: nil) ifNotNil: [ :anAction | anAction priority: 10 ]
]

{ #category : #'add-ons - header' }
GtSmalltalkSourceCoder >> addReferencesHeaderContextMenuAddOnsSelector: aSelector to: coderAddOns requester: aCoderViewModel [
	<gtCoderHeaderContextMenuAddOns>
	^ (coderAddOns
		addContextMenuItem: (self
				createLabel: GtSourceCoderBrowseReferencesShortcut new name
				description: aCoderViewModel coder selector)
		group: BrMenuItemGroupConfiguration navigation
		action: [ :coderViewModel :anEditorElement | anEditorElement phlow spawnObject: coderViewModel coder selector gtReferences ]
		id: #'context-menu--references'
		shortcutKey: nil) ifNotNil: [ :anAction | anAction priority: 15 ]
]

{ #category : #'private - ast' }
GtSmalltalkSourceCoder >> cascadedMessagesWithin: anInterval [
	"Return a collection of cascaded messages nodes that intersect a given interval"

	<return: #Collection of: #GtPharoProgramNode>
	^ self
		nodeWithin: anInterval
		ifFound: [ :aNode | 
			aNode cascadeNode notNil
				ifTrue: [ aNode cascadeNode messages
						select: [ :eachNode | eachNode intersectsInterval: anInterval ] ]
				ifFalse: [ #() ] ]
		ifNone: [ #() ]
]
