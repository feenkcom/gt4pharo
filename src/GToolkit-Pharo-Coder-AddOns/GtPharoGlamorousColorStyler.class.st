"
I display a color next to {{gtClass:BrGlamorousColors}} messages.
#Example
The following example shows how a {{gtMethod:BrGlamorousColors class >> #pressedButtonBorderColor | label=#selector}} looks like directly in the code: {{gtExample:GtPharoGlamorousColorStylerExamples>>#glamorousColor}}
"
Class {
	#name : #GtPharoGlamorousColorStyler,
	#superclass : #GtGenericPharoStyler,
	#category : 'GToolkit-Pharo-Coder-AddOns-Color'
}

{ #category : #'private - styling' }
GtPharoGlamorousColorStyler >> styleNode: aMessageSendNode [
	| color |
	color := [ BrGlamorousColors perform: aMessageSendNode message selector ]
			on: Error
			do: [ :anException | anException return: nil ].
	(color isKindOf: Color) ifFalse: [ ^ self ].
	self styleNode: aMessageSendNode withColor: color
]

{ #category : #'private - styling' }
GtPharoGlamorousColorStyler >> styleNode: aMessageSendNode withColor: color [
	self
		attribute:
			(BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [ BlElement new
						size: 10 @ 10;
						background: color;
						when: BlClickEvent
							do: [ :e | e target phlow spawnObject: color ] ])
		from: aMessageSendNode stopPosition
		to: aMessageSendNode stopPosition
]

{ #category : #generated }
GtPharoGlamorousColorStyler >> visitMessageSend: aMessageSendNode [
	| receiver |
	super visitMessageSend: aMessageSendNode.
	aMessageSendNode receiver isVariable
		ifFalse: [ ^ self ].
	receiver := aMessageSendNode receiver variableName.
	receiver = BrGlamorousColors name
		ifFalse: [ ^ self ].
	(aMessageSendNode message arguments size isZero)
		ifFalse: [ ^ self ].
	(aMessageSendNode message selector endsWith: 'Color')
		ifTrue: [ self styleNode: aMessageSendNode ].
]
