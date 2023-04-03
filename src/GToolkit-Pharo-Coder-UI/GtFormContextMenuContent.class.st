Class {
	#name : #GtFormContextMenuContent,
	#superclass : #GtAbstractCoderContextMenuContent,
	#instVars : [
		'editorElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms'
}

{ #category : #accessing }
GtFormContextMenuContent >> editorElement [
	^editorElement
]

{ #category : #accessing }
GtFormContextMenuContent >> editorElement: aForm [
	editorElement := aForm
]

{ #category : #initialization }
GtFormContextMenuContent >> menuItemStencil [
	^ [ :eachGtCoderContextMenuAction :aRowIndex | 
	| element |
	element := BrHorizontalPane new
			id: (GtCoderContextMenuItemId indexed: aRowIndex);
			hMatchParent;
			vFitContent;
			alignCenter;
			addAptitude: self selectionAptitude;
			padding: self itemPadding;
			addChild: (self itemLabelFor: eachGtCoderContextMenuAction title asRopedText);
			when: BlClickEvent
				do: [ :anEvent | 
					anEvent consumed: true.
					eachGtCoderContextMenuAction action
						cull: self editorElement editor
						cull: self editorElement
						cull: anEvent.
					self fireEvent: BrDropdownHideWish new.
					self fireEvent: BrContextMenuHideWish new ].
	((eachGtCoderContextMenuAction shortcutKey respondsTo: #isEmpty)
		and: [ eachGtCoderContextMenuAction shortcutKey isEmpty not ])
		ifTrue: [ element
				addChild: (BrHorizontalPane new
						fitContent;
						geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
						border: (BlBorder paint: Color gray width: 1);
						padding: (BlInsets all: 1);
						margin: (BlInsets left: 10);
						addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								text: (eachGtCoderContextMenuAction shortcutKey asRopedText
										fontName: 'Source Code Pro';
										foreground: Color gray;
										fontSize: 10);
								hFitContent;
								yourself);
						yourself) ].
	eachGtCoderContextMenuAction hoverAction
		ifNotNil: [ :hover | 
			element
				when: BlMouseEnterEvent
				do: [ :anEvent | hover cull: self editorElement textualCoderViewModel cull: anEvent ] ].
	eachGtCoderContextMenuAction leaveAction
		ifNotNil: [ :leave | 
			element
				when: BlMouseLeaveEvent
				do: [ :anEvent | leave cull: self editorElement textualCoderViewModel cull: anEvent ] ].
	eachGtCoderContextMenuAction name
		ifNotNil: [ :anActionName | element containerName: anActionName ].
	element ]
]
