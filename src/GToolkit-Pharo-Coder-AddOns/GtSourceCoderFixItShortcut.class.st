Class {
	#name : #GtSourceCoderFixItShortcut,
	#superclass : #GtSourceCoderShortcut,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
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
GtSourceCoderFixItShortcut >> performOnEditor: aBrTextEditor element: aBrEditorElement coder: aGtSourceCoder dueTo: aShortcutEvent [
	| text |
	text := aBrTextEditor text.
	aBrTextEditor cursors
		do: [ :each | 
			(each position between: 1 and: text size)
				ifTrue: [ (text attributesAt: each position)
						do: [ :attr | 
							(attr isKindOf: GtFixItMarkerAttribute)
								ifTrue: [ attr togglePopup ifTrue: [ ^ self ] ] ] ] ]
]
