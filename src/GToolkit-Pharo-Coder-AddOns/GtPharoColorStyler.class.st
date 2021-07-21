Class {
	#name : #GtPharoColorStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Color'
}

{ #category : #'private - styling' }
GtPharoColorStyler >> styleFromString: aMessageSendNode [
	| color |
	color := Color
		fromHexString: aMessageSendNode arguments first literalValue.
	self styleNode: aMessageSendNode withColor: color
]

{ #category : #'private - styling' }
GtPharoColorStyler >> styleNode: aMessageSendNode withColor: color [
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

{ #category : #'private - styling' }
GtPharoColorStyler >> styleRegisteredColor: aMessageSendNode [
	| color |
	color := Color brickColorRegistry at: aMessageSendNode message selector ifAbsent: [ ^ self ].
	self styleNode: aMessageSendNode withColor: color.
]

{ #category : #'private - styling' }
GtPharoColorStyler >> styleRgbRange: aMessageSendNode [
	| color |
	color := Color
		r: aMessageSendNode arguments first literalValue
		g: aMessageSendNode arguments second literalValue
		b: aMessageSendNode arguments third literalValue
		range: aMessageSendNode arguments fourth literalValue.
	self styleNode: aMessageSendNode withColor: color
]

{ #category : #generated }
GtPharoColorStyler >> visitMessageSend: aMessageSendNode [
	| receiver |
	super visitMessageSend: aMessageSendNode.
	aMessageSendNode receiver isVariable
		ifFalse: [ ^ self ].
	receiver := aMessageSendNode receiver variableName.
	receiver = #Color
		ifFalse: [ ^ self ].
	(aMessageSendNode message arguments allSatisfy: #isLiteral)
		ifFalse: [ ^ self ].
	aMessageSendNode message selector = 'r:g:b:range:'
		ifTrue: [ self styleRgbRange: aMessageSendNode ].
	aMessageSendNode message selector = #fromHexString:
		ifTrue: [ self styleFromString: aMessageSendNode ].
	(Color brickColorRegistry
		includesKey: aMessageSendNode message selector)
		ifTrue: [ self styleRegisteredColor: aMessageSendNode ]
]
