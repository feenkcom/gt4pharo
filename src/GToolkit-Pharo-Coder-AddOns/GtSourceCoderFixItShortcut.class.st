Class {
	#name : #GtSourceCoderFixItShortcut,
	#superclass : #GtSourceCoderShortcut,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtSourceCoderFixItShortcut >> description [
	^ 'Opens the fix it actions at the current location'
]

{ #category : #initialization }
GtSourceCoderFixItShortcut >> initialize [
	super initialize.
	combination := BlKeyCombination primaryT
]

{ #category : #accessing }
GtSourceCoderFixItShortcut >> name [
	^ 'Open Fix Its'
]

{ #category : #evaluation }
GtSourceCoderFixItShortcut >> performOnEditor: aBrTextEditor element: aBrEditorElement coder: aGtSourceCoder dueTo: aShortcutEvent requesterObject: aRequester [
	| text |
	text := aBrTextEditor text.
	aBrTextEditor cursors
		do: [ :cursor | 
			(cursor position between: 1 and: text size)
				ifTrue: [ (text attributesAt: cursor position)
						do: [ :marker | 
							(marker isKindOf: GtFixItMarkerAttribute)
								ifTrue: [ aBrEditorElement
										allChildrenBreadthFirstDetect: [ :element | 
											(element isKindOf: GtFixItButton)
												and: [ (element userData at: #fixItAttribute ifAbsent: [  ]) = marker fixItAttribute ] ]
										ifFound: [ :element | 
											element userData
												at: #dropDownAptitude
												ifPresent: [ :attr | ^ attr canShow ifTrue: [ attr show ] ifFalse: [ attr hide ] ] ] ] ] ] ].
												
	"Since we use the same Primary+T shortcut for the world tool menu and this fix-it command, 
	we want to keep propagating the shortcut event in case there is no fix-it attribute.
	See https://github.com/feenkcom/gtoolkit/issues/4521"
	aShortcutEvent beNotConsumed
]
